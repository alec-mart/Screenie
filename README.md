# Screenie

Snap it. Note it. Route it.

A tiny tray-resident Windows tool for capturing visual context while you work:
press a global hotkey (**F5** by default) anywhere, drag a box over the part of the
screen you mean, type a quick note, hit **Enter**. Screenie drops a paired
`snap_YYYYMMDD_HHMMSS.png` + `.txt` into a route folder of your choice, and also
puts the image on the clipboard. No save dialogs, no extra clicks.

Built for the workflow of pointing at a UI ("this button, right here — make it
blue") instead of describing it in paragraphs.

## How it works

1. Press the hotkey — the screen freezes and dims, snipping-tool style.
2. Drag to select a region. The PNG saves the moment you release the mouse.
3. A bare note box pops up. Type what you want done. **Enter** saves,
   **Ctrl+Enter** inserts a new line, **Esc** skips the note.

Each note's `.txt` shares its screenshot's basename and starts with
`[screenshot: snap_....png]`, so every pair is self-describing — any tool or
teammate picking up the folder knows exactly which note belongs to which image.

## The interface

Barebones and grey, the way it should be. Window shows the route folder (with a
Browse button), the hotkey box, and a run-at-startup checkbox. Closing or
minimizing the window tucks it into the system tray; it keeps listening for the
hotkey. Exit via the tray menu.

## Multiple projects

One hotkey, switchable destination: right-click the tray icon → **Route to**
lists your recent folders (up to 8). Two clicks to retarget when you switch
projects. A common pattern is routing to a `.screenie\` folder inside the
project you're currently working on (add `.screenie/` to that project's
`.gitignore`).

## Changing the hotkey

Click the hotkey box in the app and press the combo you want — it applies
instantly. Supports F1–F12, A–Z, 0–9, and PrintScreen, with any combination of
Ctrl/Alt/Shift.

**Heads up:** a global F5 steals F5 from *every* app, including browser refresh.
If that bites during web development, rebind to something like Ctrl+F5 or F8.

## Config

`%APPDATA%\Screenie\config.ini` — managed by the app, but human-editable:

- `folder=` current route folder
- `hotkey=` global hotkey
- `recent=` pipe-separated recent-folder list

## Autostart

The "Start Screenie with Windows" checkbox writes
`HKCU\Software\Microsoft\Windows\CurrentVersion\Run\Screenie` (enabled by
default on first run). It relaunches with `--tray` so it starts hidden.

## Build from source

Run `build.bat`. It compiles the single `Screenie.cs` with the C# compiler that
ships with Windows (.NET Framework 4.x) — no SDK or dependencies required.
