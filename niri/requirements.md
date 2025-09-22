# Following are required #

## wayland-satellite ##

Required for xwayland implementation

## wl-clipboard ##

Couldn't get copy to vim "+y to global clipboard.
Needed to select (visual select then `:w !wl-copy`)

## sway-lock ##

For lock

## sway-idle ##

For idling and sleeping/locking after idle

## sway-bg ##

For wallpaper
[done] Randomized wallpaper possible but only looks once per boot, unless a script is bound to change
wallpaper. [done: made a refresh script to refresh wallpaper, restart waybar, reapply gnome settings]
[done] Wallpaper only set to workspace. Need to find out how to set wallpaper to the whole desktop and
not to just workspace. Seen it done somewhere, need to figure out where

## xdg-desktop-portals-gnome ##

Requires this for screen sharing and casting 
uses xdg-desktop-portals-gtk as backup but doesn't even set the theme.
(nautilus is pulled as a requirement among other things)

Seems to be working also with xdg-desktop-portals-wlr



