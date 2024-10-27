#!/bin/sh
############  ml4w-hyprland-setup  ###################
# ml4w-hyprland-setup Linux Dotfiles


sudo pacman -Sy archlinux-keyring && sudo pacman -Syyu

# enable flatpaks
sudo pacman -S --noconfirm --needed flatpak

###### yay ########
sudo pacman -S --needed git base-devel && git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si && cd


#Main Release

#You can use your preferred AUR helper.

yay -S --noconfirm --needed ml4w-hyprland
#After the installation, you can start the setup with

ml4w-hyprland-setup