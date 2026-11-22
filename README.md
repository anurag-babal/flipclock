# FlipClock

A flip clock as your Mac desktop wallpaper. No account, no sign-in, no App Store.

It sits behind your desktop icons, follows macOS dark and light mode if you want it to, and has a settings window with 40 ready-made looks, a randomizer, and a live preview.

## Install

You need a Mac and the free Xcode Command Line Tools (about 1 GB, no Apple account needed).

1. Open **Terminal** and install the tools. Skip this if you already have them:

   ```
   xcode-select --install
   ```

2. Download and build:

   ```
   git clone https://github.com/anurag-babal/flipclock.git
   cd flipclock
   ./flipclock.sh install
   ```

3. Click the small clock icon in the menu bar, then choose **Settings**.

The app is built on your own Mac, so macOS does not block it and you do not need to approve anything.

## Using it

- **Presets tab**: click a look to preview it. The row at the top shows what is on your wallpaper now.
- **Apply to wallpaper** makes the previewed look your wallpaper.
- **Randomize** rolls a new look. **Save preset** keeps one under your own name.
- **Look, Type, Layout tabs** change colors, fonts, digit size, spacing and flip speed.

## Commands

```
./flipclock.sh install     build and start the app
./flipclock.sh update      pick up changes made in web/ without rebuilding
./flipclock.sh reset       go back to the default look
./flipclock.sh login       start at login (nologin to undo)
./flipclock.sh uninstall   remove the app, keeps your settings
```

Quit the app from the menu bar icon.

## Where things live

| What | Where |
| --- | --- |
| App | `/Applications/FlipClock.app` |
| Your applied look and saved presets | `~/.flipclock/config.js`, `~/.flipclock/presets.js` |
| Pages the app shows | `~/.flipclock/` (copied from `web/` by `install` and `update`) |

Re-running `install` never overwrites your look or your saved presets.

## Repo layout

```
src/main.swift    the macOS app (wallpaper windows, menu bar, settings window)
web/              the clock page, the settings page, built-in presets
defaults/         the config a new install starts with
icon/             app icon and the script that draws it
flipclock.sh      install and helper commands
```

To change the app icon, edit `icon/make-icon.swift`, then:

```
swiftc icon/make-icon.swift -o /tmp/mk && /tmp/mk /tmp/icon
iconutil -c icns /tmp/icon/AppIcon.iconset -o icon/AppIcon.icns
```

## Notes

- Built and tested on macOS 26. Older versions may work but are untested.
- Some presets use fonts that ship with macOS, such as DIN Condensed. If a font is missing, the clock falls back to a plain one.
- The app is only ad-hoc signed. Sending someone a prebuilt copy will make macOS block it, so share this repo and let them build it.

## License

MIT
