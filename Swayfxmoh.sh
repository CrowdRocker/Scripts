# !/bin/bash



###### swayfx ########

sudo pacman -Sy archlinux-keyring && sudo pacman -Syyu

# enable flatpaks
sudo pacman -S --noconfirm --needed flatpak

###### yay ########
sudo pacman -S --needed git base-devel && git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si && cd

###### paru ########
yay -S --noconfirm --needed paru 

#clone the Repository 
git clone https://github.com/mohammedbilalns/dotfiles


paru -S --noconfirm --needed stow swayfx mako foot swayidle swaylock-effects fuzzel waybar wlsunset swaybg
mkdir .config/sway .config/mako .config/foot .config/swayidle .config/swaylock .config/fuzzel .config/backup
mv .config/sway .config/mako .config/foot .config/swayidle .config/swaylock .config/fuzzel .config/backup/ &&
cd dotfiles && stow sway mako swayidle swaylock fuzzel 




