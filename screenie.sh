#!/usr/bin/env bash
# screenie — region screenshot + note pair for Linux.
# Bind this script to PrtSc in your DE's keyboard shortcut settings.
# Usage: screenie.sh [folder]        capture into folder (or configured/default)
#        screenie.sh --set-folder F  set default route folder
set -u

conf="${XDG_CONFIG_HOME:-$HOME/.config}/screenie/config"

if [ "${1:-}" = "--set-folder" ]; then
  [ -n "${2:-}" ] || { echo "usage: screenie.sh --set-folder /path" >&2; exit 1; }
  mkdir -p "$(dirname "$conf")"
  printf 'folder=%s\n' "$2" > "$conf"
  echo "routing to $2"
  exit 0
fi

folder="${1:-}"
[ -z "$folder" ] && [ -f "$conf" ] && folder=$(sed -n 's/^folder=//p' "$conf")
[ -z "$folder" ] && folder="$HOME/Screenie/inbox"
mkdir -p "$folder"

base="snap_$(date +%Y%m%d_%H%M%S)"
png="$folder/$base.png"
n=2
while [ -e "$png" ]; do png="$folder/${base}_$n.png"; n=$((n+1)); done
base=$(basename "$png" .png)

capture() {
  if [ "${XDG_SESSION_TYPE:-}" = "wayland" ] && command -v grim >/dev/null && command -v slurp >/dev/null; then
    g=$(slurp) || return 1
    grim -g "$g" "$png"
    return
  fi
  if command -v maim >/dev/null; then maim -s "$png"; return; fi
  if command -v flameshot >/dev/null; then
    flameshot gui --raw > "$png" 2>/dev/null
    [ -s "$png" ] || { rm -f "$png"; return 1; }
    return
  fi
  if command -v gnome-screenshot >/dev/null; then gnome-screenshot -a -f "$png"; return; fi
  if command -v spectacle >/dev/null; then spectacle -brn -o "$png"; return; fi
  echo "screenie: need one of grim+slurp, maim, flameshot, gnome-screenshot, spectacle" >&2
  return 1
}

capture || { rm -f "$png"; exit 1; }
[ -s "$png" ] || { rm -f "$png"; exit 1; }

# clipboard, if a tool is around
if command -v wl-copy >/dev/null; then wl-copy -t image/png < "$png"
elif command -v xclip >/dev/null; then xclip -selection clipboard -t image/png -i "$png"
fi

note=""
if command -v zenity >/dev/null; then
  note=$(zenity --entry --title="Screenie — Note" --text="Note for $base.png:" --width=400 2>/dev/null)
elif command -v kdialog >/dev/null; then
  note=$(kdialog --title "Screenie — Note" --inputbox "Note for $base.png:" 2>/dev/null)
fi

if [ -n "$note" ]; then
  printf '[screenshot: %s.png]\n\n%s\n' "$base" "$note" > "$folder/$base.txt"
fi
