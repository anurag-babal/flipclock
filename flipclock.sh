#!/bin/bash
# FlipClock helper. Run from the repo folder:  ./flipclock.sh help
set -euo pipefail

HERE="$(cd "$(dirname "$0")" && pwd)"
APP="/Applications/FlipClock.app"
DATA="$HOME/.flipclock"      # the running app reads its pages and settings from here

stop() { pkill -x FlipClock 2>/dev/null || true; sleep 0.5; }

start() { open "$APP"; echo "Started."; }

need_swiftc() {
    if ! command -v swiftc >/dev/null 2>&1; then
        echo "swiftc not found. Install the Xcode Command Line Tools first:  xcode-select --install"
        exit 1
    fi
}

# Pages are code: always refreshed. config.js and presets.js are yours: only created when missing.
sync_data() {
    mkdir -p "$DATA"
    cp "$HERE/web/index.html" "$HERE/web/settings.html" "$HERE/web/builtin-presets.js" "$DATA/"
    [ -f "$DATA/config.js" ]  || cp "$HERE/defaults/config.js"  "$DATA/config.js"
    [ -f "$DATA/presets.js" ] || cp "$HERE/defaults/presets.js" "$DATA/presets.js"
}

build() {
    need_swiftc
    echo "Building app..."
    local tmp; tmp="$(mktemp -d)"
    local app="$tmp/FlipClock.app"
    mkdir -p "$app/Contents/MacOS" "$app/Contents/Resources"
    swiftc -O "$HERE/src/main.swift" -o "$app/Contents/MacOS/FlipClock"
    # bundled fallback copies (also used by "reset")
    cp "$HERE/web/index.html" "$HERE/defaults/config.js" "$app/Contents/Resources/"
    cp "$HERE/icon/AppIcon.icns" "$app/Contents/Resources/"
    cat > "$app/Contents/Info.plist" <<'EOF'
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0"><dict>
<key>CFBundleName</key><string>FlipClock</string>
<key>CFBundleDisplayName</key><string>FlipClock</string>
<key>CFBundleIconFile</key><string>AppIcon</string>
<key>CFBundleIdentifier</key><string>local.flipclock.wallpaper</string>
<key>CFBundleExecutable</key><string>FlipClock</string>
<key>CFBundlePackageType</key><string>APPL</string>
<key>CFBundleVersion</key><string>1</string>
<key>LSUIElement</key><true/>
</dict></plist>
EOF
    codesign --force --sign - "$app" >/dev/null 2>&1
    stop
    rm -rf "$APP"
    mv "$app" "$APP"
    rm -rf "$tmp"
}

case "${1:-help}" in
install)
    sync_data
    build
    start
    echo "Installed to $APP"
    echo "Click the clock icon in the menu bar, then Settings, to choose a look."
    ;;
update)  sync_data; stop; start; echo "Pages refreshed from this folder." ;;
start)   start ;;
stop)    stop; echo "Stopped." ;;
restart) stop; start ;;
reset)
    cp "$APP/Contents/Resources/config.js" "$DATA/config.js"
    echo "Applied look reset to the default."
    ;;
login)
    osascript -e "tell application \"System Events\" to make login item at end with properties {path:\"$APP\", hidden:true}" >/dev/null
    echo "Added to login items."
    ;;
nologin)
    osascript -e 'tell application "System Events" to delete login item "FlipClock"' >/dev/null
    echo "Removed from login items."
    ;;
uninstall)
    stop
    osascript -e 'tell application "System Events" to delete login item "FlipClock"' >/dev/null 2>&1 || true
    rm -rf "$APP"
    echo "App removed. Your settings stay in $DATA (delete that folder to remove them too)."
    ;;
*)
    cat <<EOF
Usage: ./flipclock.sh <command>

  install     build the app into /Applications and start it
  update      copy changed pages (web/) into place and restart, without rebuilding
  reset       restore the default look
  start | stop | restart
  login       start automatically at login      (nologin to undo)
  uninstall   remove the app (your settings are kept)
EOF
    ;;
esac
