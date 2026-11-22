import Cocoa
import WebKit

// Loads ~/.flipclock/index.html (falls back to the copy bundled in the app).
// Reloads automatically whenever index.html or config.js in that folder changes.
// Optional: pass a path to an html file as the first argument to override.

let configDir = FileManager.default.homeDirectoryForCurrentUser
    .appendingPathComponent(".flipclock")

func resolveHTML() -> URL {
    if CommandLine.arguments.count > 1 {
        return URL(fileURLWithPath: CommandLine.arguments[1])
    }
    let user = configDir.appendingPathComponent("index.html")
    if FileManager.default.fileExists(atPath: user.path) { return user }
    return URL(fileURLWithPath: Bundle.main.path(forResource: "index", ofType: "html") ?? "")
}

class AppDelegate: NSObject, NSApplicationDelegate, NSWindowDelegate, WKScriptMessageHandler {
    var settingsWindow: NSWindow?
    var windows: [NSWindow] = []
    var webs: [WKWebView] = []
    var statusItem: NSStatusItem?
    var lastStamp: Date = .distantPast
    var timer: Timer?

    func applicationDidFinishLaunching(_ notification: Notification) {
        buildWindows()
        NotificationCenter.default.addObserver(
            forName: NSApplication.didChangeScreenParametersNotification,
            object: nil, queue: .main
        ) { _ in self.buildWindows() }

        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        if let b = statusItem?.button {
            b.image = menuBarIcon()
            b.toolTip = "FlipClock"
            b.setAccessibilityLabel("FlipClock")
        }
        // macOS may add its own icon to some items (e.g. Settings), so every item gets one explicitly to stay consistent.
        func item(_ title: String, _ symbol: String, _ action: Selector, _ key: String) -> NSMenuItem {
            let m = NSMenuItem(title: title, action: action, keyEquivalent: key)
            let img = NSImage(systemSymbolName: symbol, accessibilityDescription: nil)
            img?.isTemplate = true
            m.image = img
            return m
        }
        let menu = NSMenu()
        menu.addItem(item("Reload", "arrow.clockwise", #selector(reload), "r"))
        menu.addItem(item("Settings", "gearshape", #selector(openSettings), ","))
        menu.addItem(.separator())
        menu.addItem(item("Quit FlipClock", "power", #selector(NSApplication.terminate(_:)), "q"))
        statusItem?.menu = menu

        lastStamp = stamp()
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            let s = self.stamp()
            if s != self.lastStamp { self.lastStamp = s; self.reload() }
        }
    }

    // newest modification time of index.html / config.js
    func stamp() -> Date {
        let dir = resolveHTML().deletingLastPathComponent()
        return ["index.html", "config.js"].compactMap { name in
            let p = dir.appendingPathComponent(name).path
            return (try? FileManager.default.attributesOfItem(atPath: p))?[.modificationDate] as? Date
        }.max() ?? .distantPast
    }

    @objc func reload() {
        let url = resolveHTML()
        // drop cached copies of config.js / index.html so edits are actually re-read
        WKWebsiteDataStore.default().removeData(
            ofTypes: [WKWebsiteDataTypeDiskCache, WKWebsiteDataTypeMemoryCache],
            modifiedSince: .distantPast) {
            self.webs.forEach { $0.loadFileURL(url, allowingReadAccessTo: url.deletingLastPathComponent()) }
        }
    }

    // Monochrome template glyph (two flip cards showing "1 2", with a hinge) - macOS tints it for light/dark menu bars.
    func menuBarIcon() -> NSImage {
        let img = NSImage(size: NSSize(width: 22, height: 16), flipped: false) { _ in
            NSColor.black.setFill()
            let cards = [NSRect(x: 1, y: 1, width: 9.5, height: 14), NSRect(x: 11.5, y: 1, width: 9.5, height: 14)]
            for c in cards { NSBezierPath(roundedRect: c, xRadius: 2.2, yRadius: 2.2).fill() }
            // punch the digits and the hinge slit out of the cards
            NSGraphicsContext.current?.compositingOperation = .clear
            let font = NSFont.systemFont(ofSize: 10.5, weight: .heavy)
            for (i, d) in ["1", "2"].enumerated() {
                let s = NSAttributedString(string: d, attributes: [.font: font])
                let sz = s.size()
                s.draw(at: NSPoint(x: cards[i].midX - sz.width / 2, y: cards[i].midY - sz.height / 2))
            }
            NSRect(x: 0, y: 7.55, width: 22, height: 0.9).fill()
            return true
        }
        img.isTemplate = true
        return img
    }

    // ---- settings window (form UI in ~/.flipclock/settings.html) ----
    @objc func openSettings() {
        if let w = settingsWindow {
            w.makeKeyAndOrderFront(nil)
            NSApp.activate(ignoringOtherApps: true)
            return
        }
        let dir = resolveHTML().deletingLastPathComponent()
        let page = dir.appendingPathComponent("settings.html")
        guard FileManager.default.fileExists(atPath: page.path) else {
            let a = NSAlert()
            a.messageText = "settings.html not found"
            a.informativeText = "Expected at \(page.path). Run ./flipclock.sh install from the FlipClock folder."
            a.runModal()
            return
        }

        let ucc = WKUserContentController()
        ucc.add(self, name: "save")
        // hand the installed font families to the form
        let families = NSFontManager.shared.availableFontFamilies.sorted()
        if let data = try? JSONSerialization.data(withJSONObject: families),
           let json = String(data: data, encoding: .utf8) {
            ucc.addUserScript(WKUserScript(source: "window.__FONTS__ = \(json);",
                                           injectionTime: .atDocumentStart, forMainFrameOnly: true))
        }
        let conf = WKWebViewConfiguration()
        conf.userContentController = ucc

        let w = NSWindow(contentRect: NSRect(x: 0, y: 0, width: 1240, height: 780),
                         styleMask: [.titled, .closable, .miniaturizable, .resizable],
                         backing: .buffered, defer: false)
        w.title = "FlipClock Settings"
        w.isReleasedWhenClosed = false
        w.delegate = self
        let web = WKWebView(frame: .zero, configuration: conf)
        web.loadFileURL(page, allowingReadAccessTo: dir)
        w.contentView = web
        w.center()
        settingsWindow = w
        w.makeKeyAndOrderFront(nil)
        NSApp.activate(ignoringOtherApps: true)
    }

    // closing the window discards it, so the next open starts from what is applied to the wallpaper
    func windowWillClose(_ notification: Notification) {
        if (notification.object as? NSWindow) === settingsWindow {
            settingsWindow?.contentView = nil
            settingsWindow = nil
        }
    }

    func userContentController(_ ucc: WKUserContentController, didReceive message: WKScriptMessage) {
        guard message.name == "save",
              let body = message.body as? [String: Any],
              let file = body["file"] as? String,
              let text = body["text"] as? String,
              ["config.js", "presets.js"].contains(file) else { return }   // only these two files may be written
        let target = resolveHTML().deletingLastPathComponent().appendingPathComponent(file)
        try? text.write(to: target, atomically: true, encoding: .utf8)
        // for config.js the 1s file watcher then reloads the wallpaper
    }

    func buildWindows() {
        windows.forEach { $0.close() }
        webs = []
        let url = resolveHTML()
        windows = NSScreen.screens.map { screen in
            let window = NSWindow(contentRect: screen.frame, styleMask: .borderless,
                                  backing: .buffered, defer: false)
            window.level = NSWindow.Level(rawValue: Int(CGWindowLevelForKey(.desktopWindow)))
            window.collectionBehavior = [.canJoinAllSpaces, .stationary, .ignoresCycle]
            window.ignoresMouseEvents = true
            window.isOpaque = true
            window.backgroundColor = .black
            window.hasShadow = false

            let web = WKWebView(frame: CGRect(origin: .zero, size: screen.frame.size),
                                configuration: WKWebViewConfiguration())
            web.autoresizingMask = [.width, .height]
            web.loadFileURL(url, allowingReadAccessTo: url.deletingLastPathComponent())
            webs.append(web)
            window.contentView = web
            window.setFrame(screen.frame, display: true)
            window.orderBack(nil)
            return window
        }
    }
}

let app = NSApplication.shared
app.setActivationPolicy(.accessory)
let delegate = AppDelegate()
app.delegate = delegate
app.run()
