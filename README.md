# Screenie

Screenshot + note tool for Windows, built for a Claude Code workflow. Instead of writing a paragraph explaining which button you mean, hit F5, box it, type the note, and tell Claude to go look.

## Use

- Press F5, drag a box. The screenshot saves instantly (and lands on your clipboard).
- A note box pops up. Enter saves, Ctrl+Enter for a new line, Esc skips.
- Files land in your route folder as matching pairs: `snap_*.png` + `snap_*.txt`.

## Claude Code setup

Point the route folder at a `.screenie\` folder inside your project (gitignore it), then add this to the project's CLAUDE.md:

```
When I say "screenie", read the newest snap_*.png in .screenie/ plus its matching .txt note.
```

Then just type "screenie" in Claude Code.

## Settings

- Route folder: Browse button in the app, or right-click the tray icon > Route to for recent folders.
- Hotkey: click the hotkey box in the app and press the combo you want. Warning: global F5 also steals browser refresh — rebind to Ctrl+F5 or F8 if that gets annoying.
- Starts with Windows by default (checkbox to turn off).
- X or minimize hides it to the tray. Exit from the tray menu.
- Config lives in `%APPDATA%\Screenie\config.ini`.

## Build

Run `build.bat`. Uses the C# compiler built into Windows, no SDK needed. Or just grab `Screenie.exe` from Releases.
