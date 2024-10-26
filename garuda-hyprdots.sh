#!/bin/sh
############  garuda-hyprdots ###################


paru -S swaylock-effects hyprlock-git rofi-wayland waybar fastfetch cava-git foot hyprland-git mpd mpc rose-pine-cursor rose-pine-hyprcursor ttf-font-awesome nerd-fonts hyprpicker pipewire wireplumber nwg-launchers mako most pavucontrol swayfx bluez bluez-utils grimblast gpu-screen-recorder btop networkmanager matugen wl-clipboard swww dart-sass brightnessctl gnome-bluetooth-3.0 aylurs-gtk-shell micro blueberry kitty


############  Installation ###################
git clone https://github.com/yurihikari/garuda-sway-config.git
cp -r garuda-sway-config/* ~/.config


############  Install Script ###################
git clone https://github.com/yurihikari/garuda-sway-config.git
cd ./garuda-sway-config
./install.sh
# You'll have some interactions sometime, it's not fully automatized
