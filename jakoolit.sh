#!/bin/sh
############  Jakoolit hyprland  ###################
# Jakoolit hyprland Linux Dotfiles


sudo pacman -Sy archlinux-keyring && sudo pacman -Syyu

# enable flatpaks
sudo pacman -S --noconfirm --needed flatpak

###### yay ########
sudo pacman -S --needed git base-devel && git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si && cd




git clone --depth=1 https://github.com/JaKooLit/Arch-Hyprland.git ~/Arch-Hyprland
cd ~/Arch-Hyprland
chmod +x install.sh
./install.sh