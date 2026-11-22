import Cocoa
import CoreText

// usage: swift make-icon.swift <out-dir>   -> writes AppIcon.iconset/*.png (run iconutil afterwards)
let outDir = CommandLine.arguments.count > 1 ? CommandLine.arguments[1] : "."
let set = outDir + "/AppIcon.iconset"
try? FileManager.default.createDirectory(atPath: set, withIntermediateDirectories: true)

func rr(_ r: CGRect, _ radius: CGFloat) -> NSBezierPath { NSBezierPath(roundedRect: r, xRadius: radius, yRadius: radius) }
func grad(_ a: NSColor, _ b: NSColor) -> NSGradient { NSGradient(starting: a, ending: b)! }
func hex(_ v: UInt32, _ a: CGFloat = 1) -> NSColor {
    NSColor(srgbRed: CGFloat((v >> 16) & 255) / 255, green: CGFloat((v >> 8) & 255) / 255, blue: CGFloat(v & 255) / 255, alpha: a)
}

// the artwork is drawn on a 1024 grid, y up
func draw(_ ctx: CGContext) {
    // macOS icon body: 824 square centred on the 1024 canvas
    let body = CGRect(x: 100, y: 100, width: 824, height: 824)
    let shape = rr(body, 186)

    NSGraphicsContext.saveGraphicsState()
    let sh = NSShadow(); sh.shadowColor = NSColor.black.withAlphaComponent(0.45)
    sh.shadowBlurRadius = 24; sh.shadowOffset = NSSize(width: 0, height: -12); sh.set()
    hex(0x15161a).setFill(); shape.fill()
    NSGraphicsContext.restoreGraphicsState()

    NSGraphicsContext.saveGraphicsState()
    shape.addClip()
    grad(hex(0x3a3d46), hex(0x14151a)).draw(in: body, angle: -90)
    // soft top sheen
    grad(NSColor.white.withAlphaComponent(0.10), NSColor.white.withAlphaComponent(0)).draw(in: CGRect(x: 100, y: 560, width: 824, height: 364), angle: -90)

    let cw: CGFloat = 292, ch: CGFloat = 400, gap: CGFloat = 40
    let x0 = 512 - cw - gap / 2
    let y0 = 512 - ch / 2
    let font = CTFontCreateWithName("HelveticaNeue-Bold" as CFString, 360, nil)

    for (i, d) in ["1", "2"].enumerated() {
        let card = CGRect(x: x0 + CGFloat(i) * (cw + gap), y: y0, width: cw, height: ch)
        let cshape = rr(card, 46)

        // card shadow
        NSGraphicsContext.saveGraphicsState()
        let cs = NSShadow(); cs.shadowColor = NSColor.black.withAlphaComponent(0.55)
        cs.shadowBlurRadius = 22; cs.shadowOffset = NSSize(width: 0, height: -10); cs.set()
        hex(0x202228).setFill(); cshape.fill()
        NSGraphicsContext.restoreGraphicsState()

        NSGraphicsContext.saveGraphicsState()
        cshape.addClip()
        // two flaps: the upper catches the light, the lower sits in shade
        let top = CGRect(x: card.minX, y: card.midY, width: cw, height: ch / 2)
        let bot = CGRect(x: card.minX, y: card.minY, width: cw, height: ch / 2)
        grad(hex(0x30323a), hex(0x26282e)).draw(in: top, angle: -90)
        grad(hex(0x1f2025), hex(0x17181c)).draw(in: bot, angle: -90)

        // digit, centred on its real glyph bounds
        let attrs: [NSAttributedString.Key: Any] = [.font: font, .foregroundColor: hex(0xf4efe6)]
        let line = CTLineCreateWithAttributedString(NSAttributedString(string: d, attributes: attrs))
        let b = CTLineGetBoundsWithOptions(line, .useGlyphPathBounds)
        ctx.textPosition = CGPoint(x: card.midX - b.midX, y: card.midY - b.midY)
        CTLineDraw(line, ctx)

        // hinge: dark slit with a faint highlight under it
        hex(0x0b0c0e).setFill(); CGRect(x: card.minX, y: card.midY - 4, width: cw, height: 8).fill()
        NSColor.white.withAlphaComponent(0.07).setFill(); CGRect(x: card.minX, y: card.midY - 8, width: cw, height: 4).fill()
        NSGraphicsContext.restoreGraphicsState()

        // card rim
        NSColor.white.withAlphaComponent(0.08).setStroke(); cshape.lineWidth = 3; cshape.stroke()
    }

    // amber accent: the clock's "seconds" dot between the cards
    hex(0xff9f1c).setFill()
    NSBezierPath(ovalIn: CGRect(x: 512 - 12, y: 512 - 12, width: 24, height: 24)).fill()
    NSGraphicsContext.restoreGraphicsState()

    // body rim
    NSColor.white.withAlphaComponent(0.16).setStroke(); shape.lineWidth = 3; shape.stroke()
}

func png(_ px: Int, _ name: String) {
    let rep = NSBitmapImageRep(bitmapDataPlanes: nil, pixelsWide: px, pixelsHigh: px, bitsPerSample: 8, samplesPerPixel: 4,
                               hasAlpha: true, isPlanar: false, colorSpaceName: .deviceRGB, bytesPerRow: 0, bitsPerPixel: 0)!
    let g = NSGraphicsContext(bitmapImageRep: rep)!
    NSGraphicsContext.current = g
    let c = g.cgContext
    c.scaleBy(x: CGFloat(px) / 1024, y: CGFloat(px) / 1024)
    c.interpolationQuality = .high
    draw(c)
    NSGraphicsContext.current = nil
    try! rep.representation(using: .png, properties: [:])!.write(to: URL(fileURLWithPath: set + "/" + name))
}

for s in [16, 32, 128, 256, 512] {
    png(s, "icon_\(s)x\(s).png")
    png(s * 2, "icon_\(s)x\(s)@2x.png")
}
print("wrote", set)
