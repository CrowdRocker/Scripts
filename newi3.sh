# !/bin/bash



###### i3 ########



sudo pacman -S git

git clone --bare https://github.com/simonvic/dotfiles.git ${XDG_DATA_HOME:-$HOME/.local/share}/.dotfiles

git --git-dir=${XDG_DATA_HOME:-$HOME/.local/share}/.dotfiles/ --work-tree=$HOME checkout

git --git-dir=${XDG_DATA_HOME:-$HOME/.local/share}/.dotfiles/ --work-tree=$HOME checkout dev

git --git-dir=${XDG_DATA_HOME:-$HOME/.local/share}/.dotfiles/ --work-tree=$HOME config --local status.showUntrackedFiles no

echo ".dotfiles" >> $HOME/.gitignore

echo '
if [[ $UID -ge 1000 && -d $HOME/.local/bin && -z $(echo $PATH | grep -o $HOME/.local/bin) ]]; then
	export PATH="${PATH}:$HOME/.local/bin"
fi' >> /etc/profile

chmod +x ~/.local/bin/*
chmod +x ~/.config/i3/scripts/*
chmod +x ~/.config/polybar/scripts/*

sudo pacman -Syu
sudo pacman -S base-devel

sudo pacman -S adobe-source-code-pro-fonts ttf-lato ttf-liberation noto-fonts noto-fonts-emoji

git clone https://aur.archlinux.org/nerd-fonts-source-code-pro.git
cd nerd-fonts-source-code-pro
makepkg -si
cd

git clone https://aur.archlinux.org/ttf-work-sans.git
cd ttf-work-sans
makepkg -si

sudo sh -c 'curl -fLo /usr/share/fonts/TTF/DejaVuSansMono-wifi-ramp.ttf https://raw.githubusercontent.com/isaif/polybar-wifi-ramp-icons/main/DejaVuSansMono-wifi-ramp.ttf'

fc-conflist | grep 60-simonvic-prefs.conf

ln -s ~/.config/fontconfig/conf.d/60-simonvic-prefs.conf /etc/fonts/conf.d/

git clone https://aur.archlinux.org/vimix-icon-theme.git
cd vimix-icon-theme
makepkg -si

git clone https://aur.archlinux.org/vimix-gtk-themes.git
cd vimix-gtk-themes
makepkg -si

sudo pacman -S xorg

sudo pacman -S feh numlockx wget rofi-calc libnotify redshift  xclip scrot imagemagick playerctl xss-lock xdg-utils

git clone https://aur.archlinux.org/i3lock-color.git
cd i3lock-color
makepkg -si

sudo pacman -S bluez bluez-utils

sudo systemctl enable --now bluetooth.service

sudo pacman -S i3-gaps picom rofi dunst

git clone https://aur.archlinux.org/polybar.git
cd polybar
makepkg -si

bash -c "$(wget -qO- https://git.io/vQgMr)"

sudo pacman -S neovim ripgrep fd gcc wget

sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

sudo pacman -S ranger ueberzug

ranger --copy-config=all

git clone https://github.com/alexanderjeurissen/ranger_devicons ~/.config/ranger/plugins/ranger_devicons
echo "" >> $HOME/.config/ranger/rc.conf
#Edit ~/.config/ranger/rc.conf and change settings to
#set vcs_aware true
#set preview_images true
#set preview_images_method ueberzug
#set draw_borders both
#default_linemode devicons

sudo pacman -S htop