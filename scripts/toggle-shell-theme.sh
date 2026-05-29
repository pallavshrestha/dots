#!/usr/bin/env bash
# toggle-waybar-theme.sh
# Toggle between style_dark.css and style_light.css by switching ~/.config/waybar/style.css symlink and restarting waybar.

set -euo pipefail

CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/waybar"
DARK="$CONFIG_DIR/style_dark.css"
LIGHT="$CONFIG_DIR/style_light.css"
LINK="$CONFIG_DIR/style.css"
STATE="$CONFIG_DIR/.theme_state"
RESTART_WAIT=0.12

CONFIG_ROFI="${XDG_CONFIG_HOME:-$HOME/.config}/rofi/themes"
DARK_ROFI="$CONFIG_ROFI/nord-dark.rasi"
LIGHT_ROFI="$CONFIG_ROFI/nord-light.rasi"
LINK_ROFI="$CONFIG_ROFI/nord-colors.rasi"

# Validate presence
for f in "$DARK" "$LIGHT"; do
  if [ ! -f "$f" ]; then
    echo "Missing file: $f" >&2
    exit 1
  fi
done

# Determine current (prefer explicit state file, else infer from symlink target)
current="dark"
if [ -f "$STATE" ]; then
  current="$(cat "$STATE" 2>/dev/null || echo dark)"
else
  if [ -L "$LINK" ]; then
    target="$(readlink -f "$LINK" 2>/dev/null || true)"
    case "$target" in
      "$LIGHT") current="light" ;;
      "$DARK") current="dark" ;;
      *) current="dark" ;;
    esac
  elif [ -f "$LINK" ]; then
    if cmp -s "$LINK" "$LIGHT"; then current="light"; fi
    if cmp -s "$LINK" "$DARK"; then current="dark"; fi
  fi
fi

# Choose next
if [ "$current" = "light" ]; then
  next="dark"; next_target="$DARK"; rofi_target=$DARK_ROFI
  dconf write /org/gnome/desktop/interface/color-scheme '"prefer-dark"'
  gsettings set org.gnome.desktop.interface gtk-theme 'nordic-blue'
  gsettings set org.gnome.desktop.interface icon-theme 'Qogir-Dark'
  gsettings set org.gnome.desktop.interface cursor-theme 'Qogir-Dark'
else
  next="light"; next_target="$LIGHT"; rofi_target=$LIGHT_ROFI
  dconf write /org/gnome/desktop/interface/color-scheme '"prefer-light"'
  gsettings set org.gnome.desktop.interface gtk-theme 'nordic-polar'
  gsettings set org.gnome.desktop.interface icon-theme 'Qogir-Light'
  gsettings set org.gnome.desktop.interface cursor-theme 'Qogir-Light'
  killall swaybg
  swaybg -i $HOME/.config/wallpaper/deep-diver.png &
fi

# Atomically update symlink (or overwrite file)
rm "$LINK_ROFI"
ln -s  "$rofi_target" "$LINK_ROFI"
tmp="$LINK.tmp.$$"
ln -sf "$next_target" "$tmp"
mv -f "$tmp" "$LINK"


# Persist state
printf '%s' "$next" > "$STATE"

# Restart waybar: prefer systemd --user if available
if systemctl --user --quiet status waybar.service >/dev/null 2>&1; then
  systemctl --user restart waybar.service || {
    pkill -TERM -x waybar || true
    sleep "$RESTART_WAIT"
    setsid waybar >/dev/null 2>&1 &
  }
else
  if pgrep -x "waybar" >/dev/null 2>&1; then
    pkill -TERM -x waybar || pkill -9 -x waybar || true
    sleep "$RESTART_WAIT"
  fi
  setsid waybar >/dev/null 2>&1 &
fi

echo "$next"

