/* Built-in Flip Clock presets (only differences from the defaults are listed). */
window.FLIPCLOCK_BUILTIN = {
  regular: {
            "Default": {},

            // ---- Everyday ----
            "System Auto (dark / light)": {
                themeMode: "auto", showSeconds: false, fit: "fill", fitMargin: 0.88,
                fontFamily: "Helvetica Neue, sans-serif", fontWeight: 500, radius: 20,
                cardColor: "#16181d", dividerColor: "#0a0b0e",
                lightBackground: "#e6e9ee", lightCardColor: "#ffffff", lightDividerColor: "#d3d7de"
            },
            "Big Minimal (HH:MM)": {
                showSeconds: false, fit: "fill", fitMargin: 0.92, blinkSeparator: true,
                fontFamily: "Helvetica Neue, sans-serif", fontWeight: 300, fontScale: 0.86, radius: 24,
                groupGap: 34, digitGap: 14, cardColor: "#101114", dividerColor: "#000000", dividerWidth: 3
            },
            "Compact Mini": {
                fit: "fill", fitMargin: 0.34, digitGap: 6, groupGap: 14, radius: 10, fontScale: 0.8,
                dividerWidth: 1
            },

            // ---- Professional ----
            "Boardroom Slate": {
                themeMode: "auto", showSeconds: false, fit: "fill", fitMargin: 0.86,
                fontFamily: "Helvetica Neue, sans-serif", fontWeight: 500, radius: 10, digitGap: 10, groupGap: 30,
                background: "#0f172a", cardColor: "#1e293b", textColor: "#e2e8f0",
                dividerColor: "#0f172a", separatorColor: "#64748b", dividerWidth: 2,
                lightBackground: "#f1f5f9", lightCardColor: "#ffffff", lightTextColor: "#0f172a",
                lightDividerColor: "#cbd5e1", lightSeparatorColor: "#64748b"
            },
            "Swiss Station": {
                themeMode: "auto", showSeconds: true, fit: "fill", fitMargin: 0.9,
                fontFamily: "Helvetica Neue, sans-serif", fontWeight: 700, radius: 4, digitGap: 6, groupGap: 22,
                fontScale: 0.8, dividerWidth: 2,
                background: "#111111", cardColor: "#1c1c1c", textColor: "#f5f5f0",
                dividerColor: "#000000", separatorColor: "#e53935",
                lightBackground: "#f2f2ee", lightCardColor: "#ffffff", lightTextColor: "#111111",
                lightDividerColor: "#d9d9d4", lightSeparatorColor: "#e53935"
            },
            "Executive Gold": {
                showSeconds: false, fit: "fill", fitMargin: 0.84,
                fontFamily: "Didot, Georgia, serif", fontWeight: 400, radius: 6, fontScale: 0.8,
                background: "#0b0b0c", cardColor: "#141416", textColor: "#d4af37",
                dividerColor: "#2a2412", separatorColor: "#d4af37", groupGap: 36
            },
            "Corporate Blue": {
                themeMode: "auto", showSeconds: false, fit: "fill", fitMargin: 0.86,
                fontFamily: "Avenir Next, Helvetica Neue, sans-serif", fontWeight: 600, radius: 12,
                background: "#07142b", cardColor: "#0d2347", textColor: "#ffffff",
                dividerColor: "#07142b", separatorColor: "#3b82f6", dividerWidth: 2,
                lightBackground: "#eaf1fb", lightCardColor: "#ffffff", lightTextColor: "#0d2347",
                lightDividerColor: "#c9d8ee", lightSeparatorColor: "#2563eb"
            },
            "Paper (light, serif)": {
                themeMode: "light", showSeconds: false, fit: "fill", fitMargin: 0.84,
                fontFamily: "Georgia, serif", fontWeight: 400, radius: 3, fontScale: 0.78,
                lightBackground: "#f4efe6", lightCardColor: "#fffdf8", lightTextColor: "#2b2620",
                lightDividerColor: "#e1d9c8", lightSeparatorColor: "#8a7f6a", animate: true
            },

            // ---- Hacker / retro ----
            "Terminal Green": {
                fontFamily: "Menlo, monospace", radius: 4, digitGap: 4, groupGap: 12, fontWeight: 400,
                cardColor: "#001a00", textColor: "#00ff66", separatorColor: "#00ff66",
                background: "#000a00", dividerColor: "#003300", fontScale: 0.74
            },
            "Amber CRT": {
                fontFamily: "Courier New, monospace", fontWeight: 700, radius: 8, fontScale: 0.78,
                background: "#120a00", cardColor: "#1d1100", textColor: "#ffb000",
                dividerColor: "#2e1b00", separatorColor: "#ffb000", digitGap: 8
            },
            "Orange Retro": {
                fontFamily: "Impact, sans-serif", fontWeight: 400, fontScale: 0.9,
                cardColor: "#1a0f00", textColor: "#ff8800", separatorColor: "#ff8800", dividerColor: "#331f00"
            },
            "Square Mono": {
                fontFamily: "Courier New, monospace", radius: 0, digitGap: 0, groupGap: 18, dividerWidth: 2,
                fontWeight: 700, background: "#000000", cardColor: "#111111", dividerColor: "#333333"
            },

            // ---- Colorful ----
            "Neon Night": {
                fontFamily: "Avenir Next, Helvetica Neue, sans-serif", fontWeight: 700, radius: 22,
                background: "#08001a", cardColor: "#14002e", textColor: "#00f0ff",
                dividerColor: "#ff2bd6", separatorColor: "#ff2bd6", dividerWidth: 2
            },
            "Sunset": {
                showSeconds: false, fit: "fill", fitMargin: 0.88, radius: 26,
                fontFamily: "Avenir Next, Helvetica Neue, sans-serif", fontWeight: 600,
                background: "#1b0b1f", cardColor: "#2d1233", textColor: "#ffb86b",
                dividerColor: "#1b0b1f", separatorColor: "#ff5e7e", dividerWidth: 3
            },
            "Forest": {
                showSeconds: false, fit: "fill", fitMargin: 0.86, radius: 18,
                fontFamily: "Avenir Next, Helvetica Neue, sans-serif", fontWeight: 600,
                background: "#07140d", cardColor: "#0f2a1b", textColor: "#c9f2d6",
                dividerColor: "#07140d", separatorColor: "#4ade80", dividerWidth: 3
            },
            "Ocean": {
                themeMode: "auto", showSeconds: false, fit: "fill", fitMargin: 0.86, radius: 20,
                fontFamily: "Avenir Next, Helvetica Neue, sans-serif", fontWeight: 600,
                background: "#04202b", cardColor: "#07394d", textColor: "#d9f6ff",
                dividerColor: "#04202b", separatorColor: "#38bdf8", dividerWidth: 3,
                lightBackground: "#e3f4fa", lightCardColor: "#ffffff", lightTextColor: "#07394d",
                lightDividerColor: "#bfe0ec", lightSeparatorColor: "#0284c7"
            },
            "Rose Gold Light": {
                themeMode: "light", showSeconds: false, fit: "fill", fitMargin: 0.86, radius: 28,
                fontFamily: "Avenir Next, Helvetica Neue, sans-serif", fontWeight: 500,
                lightBackground: "#f8e9e6", lightCardColor: "#fff7f5", lightTextColor: "#8c4a4a",
                lightDividerColor: "#efd2cd", lightSeparatorColor: "#c98b8b"
            }
        },
  fun: {
            "Burnt Toast": {
                showSeconds: false, fit: "fill", fitMargin: 0.86, radius: 44,
                fontFamily: "Georgia, serif", fontWeight: 700, separator: "~",
                background: "#1a0f08", cardColor: "#3b2314", textColor: "#e0903c",
                dividerColor: "#1a0f08", separatorColor: "#f2b36b", dividerWidth: 3
            },
            "Mission Control Panic": {
                fontFamily: "Courier New, monospace", fontWeight: 700, radius: 0, separator: "!",
                background: "#1a0000", cardColor: "#2e0000", textColor: "#ff3b30",
                dividerColor: "#000000", separatorColor: "#ff3b30", dividerWidth: 3,
                digitGap: 4, flipDuration: 90
            },
            "Slow Monday": {
                showSeconds: false, fit: "fill", fitMargin: 0.84, separator: "z",
                fontFamily: "Palatino, serif", fontWeight: 300, radius: 30, flipDuration: 1000,
                background: "#161a24", cardColor: "#222838", textColor: "#9fb0d0",
                dividerColor: "#161a24", separatorColor: "#6c7ba0", blinkSeparator: true
            },
            "Cheese Wheel": {
                showSeconds: false, fit: "fill", fitMargin: 0.86, radius: 60,
                fontFamily: "Chalkboard SE, Marker Felt, sans-serif", fontWeight: 700,
                background: "#3a2a00", cardColor: "#ffc928", textColor: "#7a4d00",
                dividerColor: "#e0a800", separatorColor: "#ffc928", separator: "\u2022", dividerWidth: 3
            },
            "Comic Sans Is Fine": {
                fontFamily: "Comic Sans MS, Chalkboard SE, sans-serif", fontWeight: 700, radius: 50,
                digitGap: 16, groupGap: 30, fontScale: 0.76,
                background: "#1b1033", cardColor: "#7c4dff", textColor: "#ffeb3b",
                dividerColor: "#1b1033", separatorColor: "#ff4081", dividerWidth: 4
            },
            "Bubblegum": {
                showSeconds: false, fit: "fill", fitMargin: 0.86, radius: 64,
                fontFamily: "Avenir Next, Helvetica Neue, sans-serif", fontWeight: 800, dividerWidth: 0,
                background: "#2a0a1f", cardColor: "#ff5fa2", textColor: "#ffffff",
                dividerColor: "#ff5fa2", separatorColor: "#ffd6ec", digitGap: 18, groupGap: 34
            },
            "Wake Up Neo": {
                fontFamily: "Monaco, Menlo, monospace", fontWeight: 400, radius: 0, digitGap: 2, groupGap: 16,
                fontScale: 0.72, separator: "|", dividerWidth: 1, flipDuration: 120,
                background: "#000000", cardColor: "#020a02", textColor: "#39ff14",
                dividerColor: "#0b3d0b", separatorColor: "#39ff14"
            },
            "Disco Fever": {
                fontFamily: "Impact, sans-serif", fontWeight: 400, radius: 34, fontScale: 0.9, flipDuration: 180,
                separator: "*", dividerWidth: 4,
                background: "#12002b", cardColor: "#ff00a8", textColor: "#fff700",
                dividerColor: "#00e5ff", separatorColor: "#00e5ff", digitGap: 14
            },
            "Midnight Snack": {
                showSeconds: false, fit: "fill", fitMargin: 0.86, radius: 22,
                fontFamily: "Baskerville, Georgia, serif", fontWeight: 400,
                background: "#120d0a", cardColor: "#2a1c14", textColor: "#9ff2d0",
                dividerColor: "#120d0a", separatorColor: "#ff9ab8", dividerWidth: 3
            },
            "Pocket Calculator": {
                fontFamily: "Menlo, Courier New, monospace", fontWeight: 700, radius: 2, digitGap: 2, groupGap: 14,
                fontScale: 0.74, dividerWidth: 1, blinkSeparator: false, flipDuration: 60,
                background: "#a9b695", cardColor: "#b9c6a5", textColor: "#2b3326",
                dividerColor: "#a1ae8d", separatorColor: "#2b3326", separator: "-"
            },
            "Dentist Waiting Room": {
                themeMode: "light", showSeconds: false, fit: "fill", fitMargin: 0.84, radius: 40,
                fontFamily: "Avenir Next, Helvetica Neue, sans-serif", fontWeight: 300, separator: "~",
                flipDuration: 700,
                lightBackground: "#d9f0ee", lightCardColor: "#f4fffe", lightTextColor: "#4a8f8a",
                lightDividerColor: "#d9f0ee", lightSeparatorColor: "#8cc9c4", dividerWidth: 3
            },
            "Beer O'Clock": {
                showSeconds: false, fit: "fill", fitMargin: 0.86, radius: 18, separator: "\uD83C\uDF7A",
                fontFamily: "Rockwell, Georgia, serif", fontWeight: 700,
                background: "#2b1700", cardColor: "#f5a623", textColor: "#fff8e1",
                dividerColor: "#b87400", separatorColor: "#fff8e1", dividerWidth: 3, blinkSeparator: true
            },
            "Taco Tuesday": {
                showSeconds: false, fit: "fill", fitMargin: 0.86, radius: 28, separator: "\uD83C\uDF2E",
                fontFamily: "Chalkboard SE, Marker Felt, sans-serif", fontWeight: 700,
                background: "#3d1f0d", cardColor: "#f4c542", textColor: "#b3260e",
                dividerColor: "#3d1f0d", separatorColor: "#f4c542", dividerWidth: 3
            },
            "Halloween Forever": {
                fontFamily: "Chalkduster, Marker Felt, fantasy", fontWeight: 400, radius: 10, separator: "\uD83C\uDF83",
                background: "#0b0014", cardColor: "#1a0a24", textColor: "#ff7518",
                dividerColor: "#3a1550", separatorColor: "#ff7518", digitGap: 10, fontScale: 0.8
            },
            "Avatar Movie Titles": {
                showSeconds: false, fit: "fill", fitMargin: 0.86, radius: 6,
                fontFamily: "Papyrus, fantasy", fontWeight: 400, separator: "\u2022", fontScale: 0.74,
                background: "#02121f", cardColor: "#073049", textColor: "#9be8ff",
                dividerColor: "#02121f", separatorColor: "#3ec6ff", dividerWidth: 2
            },
            "Banana for Scale": {
                themeMode: "light", showSeconds: false, fit: "fill", fitMargin: 0.86, radius: 50,
                separator: "\uD83C\uDF4C", fontFamily: "Avenir Next, Helvetica Neue, sans-serif", fontWeight: 800,
                lightBackground: "#ffe135", lightCardColor: "#fff3a0", lightTextColor: "#5a4300",
                lightDividerColor: "#ffe135", lightSeparatorColor: "#5a4300", dividerWidth: 4
            },
            "Is This Thing On?": {
                fit: "fill", fitMargin: 0.1, digitGap: 2, groupGap: 6, radius: 4, dividerWidth: 0.5,
                fontFamily: "Menlo, monospace", fontWeight: 400
            },
            "Ludicrous Speed": {
                fontFamily: "Impact, sans-serif", fontWeight: 400, radius: 2, flipDuration: 50, separator: "\u00BB",
                digitGap: 2, groupGap: 12, fontScale: 0.88,
                background: "#050000", cardColor: "#200000", textColor: "#ff2a00",
                dividerColor: "#ff2a00", separatorColor: "#ffffff", dividerWidth: 1
            },
            "Flashbang": {
                themeMode: "light", showSeconds: false, fit: "fill", fitMargin: 0.9, radius: 0, dividerWidth: 0,
                fontWeight: 900, blinkSeparator: false, animate: false,
                lightBackground: "#ffffff", lightCardColor: "#ffffff", lightTextColor: "#000000",
                lightDividerColor: "#ffffff", lightSeparatorColor: "#000000"
            },
            "Wide Load": {
                showSeconds: false, fit: "fill", fitMargin: 0.9, widthRatio: 1.15, fontScale: 0.66, radius: 12,
                fontFamily: "Verdana, sans-serif", fontWeight: 700, digitGap: 10, groupGap: 20,
                background: "#101820", cardColor: "#1d2b3a", textColor: "#f2aa4c", dividerColor: "#101820",
                separatorColor: "#f2aa4c", dividerWidth: 3
            },
            "Skinny Jeans": {
                fit: "fill", fitMargin: 0.9, widthRatio: 0.46, fontScale: 0.9, radius: 8,
                fontFamily: "DIN Condensed, Arial Narrow, sans-serif", fontWeight: 700, digitGap: 6, groupGap: 22,
                background: "#0d0d0d", cardColor: "#1a1a1a", textColor: "#e8e8e8", dividerColor: "#0d0d0d",
                separatorColor: "#ff5a5f", dividerWidth: 2
            },
            "Windows 95 Vibes": {
                fontFamily: "Arial, sans-serif", fontWeight: 700, radius: 0, dividerWidth: 2, blinkSeparator: false,
                digitGap: 6, groupGap: 14, fontScale: 0.76, flipDuration: 220,
                background: "#008080", cardColor: "#c0c0c0", textColor: "#000000",
                dividerColor: "#808080", separatorColor: "#ffffff"
            }
        }
};
