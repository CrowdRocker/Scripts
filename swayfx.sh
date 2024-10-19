# !/bin/bash



###### swayfx ########

yay -S --noconfirm --needed swayfx waybar nwg-panel nwg-launchers wofi mako avizo alacritty wf-recorder wl-clipboard swww swaybg wdisplay waypaper picom polykit nwg-look fuzzel qt5ct qt6ct alacritty kitty xsettingsd swaybg swayidle swaylock wofi wlroots wayland wayland-protocols light grim XWayland slurp wlr-randr wayland-utils google-chrome vscodium swappy smplayer qbittorrent pulse psd pamac menus micro mpv nitrogen feh nwg-drawer octopi pacseek autostart azote bleachbit catfish deluge easyeffects falkon fish foot galculator kvantum wlogout neovim vim nano sudo wl-clipboard grim slurp swappy qt5ct qt5-wayland qt6ct qt6-wayland xdg-desktop-portal-wlr xorg-xwayland xorg-xrandr mesa vulkan-radeon libva-mesa-driver firefox libreoffice-fresh gimp imv spotify mpv mpv-mpris thunar xdg-user-dirs zsh git neofetch htop btop reflector ttf-dejavu ttf-liberation ttf-nerd-fonts-symbols-2048-em noto-fonts noto-fonts-emoji noto-fonts-cjk noto-fonts-extra bc
jq p7zip playerctl python-gobject libnotify bluez-utils lm_sensors imagemagick 

paru -S swaylock-effects hyprlock-git rofi-wayland waybar fastfetch cava-git foot hyprland-git mpd mpc rose-pine-cursor rose-pine-hyprcursor ttf-font-awesome nerd-fonts hyprpicker pipewire wireplumber nwg-launchers mako most pavucontrol swayfx bluez bluez-utils grimblast gpu-screen-recorder btop networkmanager matugen wl-clipboard swww dart-sass brightnessctl gnome-bluetooth-3.0 aylurs-gtk-shell micro blueberry kitty rofi-lbonn-wayland

git clone https://github.com/yurihikari/garuda-sway-config.git
cp -r garuda-sway-config/* ~/.config

git clone https://github.com/yurihikari/garuda-sway-config.git
cd ./garuda-sway-config
./install.sh
# You'll have some interactions sometime, it's not fully automatized


sudo pacman -Syu
