#!/bin/sh
############  yurihikari garuda-hyprdots ###################
# Yurihikari's Garuda Linux Dotfiles
# My Garuda Sway Config (Hyprland + Sway)

sudo pacman -Sy archlinux-keyring && sudo pacman -Syyu

# enable flatpaks
sudo pacman -S --noconfirm --needed flatpak

###### yay ########
sudo pacman -S --needed git base-devel && git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si && cd

###### paru ########
yay -S --noconfirm --needed paru 


paru -S swaylock-effects hyprlock-git rofi-wayland waybar fastfetch cava-git foot hyprland-git mpd mpc rose-pine-cursor rose-pine-hyprcursor ttf-font-awesome nerd-fonts hyprpicker pipewire wireplumber nwg-launchers mako most pavucontrol swayfx bluez bluez-utils grimblast gpu-screen-recorder btop networkmanager matugen wl-clipboard swww dart-sass brightnessctl gnome-bluetooth-3.0 aylurs-gtk-shell micro blueberry kitty


############  Installation ###################
git clone https://github.com/yurihikari/garuda-sway-config.git
cp -r garuda-sway-config/* ~/.config


############  Install Script ###################
git clone https://github.com/yurihikari/garuda-sway-config.git
cd ./garuda-sway-config
./install.sh
# You'll have some interactions sometime, it's not fully automatized
