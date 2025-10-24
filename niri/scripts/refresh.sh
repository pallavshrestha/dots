killall swaybg
swaybg -i "$(find ~/.config/wallpaper/ -type f |shuf -n 1)" &

killall waybar  
waybar &

dconf write /org/gnome/gesktop/interface/color-scheme '"prefer-dark"'
gsettings set org.gnome.desktop.interface gtk-theme 'nordic'
gsettings set org.gnome.desktop.interface font-name 'Iosevka Nerd Font 12'
gsettings set org.gnome.desktop.interface icon-theme 'Qogir-dark'
gsettings set org.gnome.desktop.interface cursor-theme 'Qogir-dark'

