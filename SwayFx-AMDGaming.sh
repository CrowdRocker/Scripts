#!/bin/sh
############  crowdrocker SwayFx dotfiles ###################
# crowdrocker SwayFx dotfiles
# My Sway Config


###### yay ########
sudo pacman -S --needed git base-devel && git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si && cd

###### paru ########
yay -S --noconfirm --needed paru

############  Installation ###################

### cachyos-repo
curl https://mirror.cachyos.org/cachyos-repo.tar.xz -o cachyos-repo.tar.xz
tar xvf cachyos-repo.tar.xz && cd cachyos-repo
sudo ./cachyos-repo.sh

### chaotic-aur
# Add chaotic AUR keys and repository if not added, else skip
echo "Adding chaotic AUR keys and repository"
if ! pacman-key --list-keys chaotic-aur &> /dev/null; then
  echo "Adding chaotic AUR keys and repository"
  sudo pacman-key --recv-key 3056513887B78AEB --keyserver keyserver.ubuntu.com
  sudo pacman-key --lsign-key 3056513887B78AEB
  sudo pacman -U 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-keyring.pkg.tar.zst'
  sudo pacman -U 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-mirrorlist.pkg.tar.zst'
  echo "Chaotic AUR keys added successfully"
else
  echo "Chaotic AUR keys and repository already added. Skipping..."
fi

# Add chaotic AUR
if ! grep -q "^\[chaotic-aur\]" /etc/pacman.conf; then
  echo "[chaotic-aur]
Include = /etc/pacman.d/chaotic-mirrorlist" | sudo tee -a /etc/pacman.conf
  sudo pacman -Sy
  echo "Chaotic AUR repository added/updated successfully"
fi



# cp -r garuda-sway-config/* ~/.config


############  Install Script ###################


# sddm
sudo pacman -S --noconfirm --needed sddm
sudo mkdir -p /etc/sddm.conf.d
echo -e "[Theme]\nCurrent=nordic" | sudo tee /etc/sddm.conf.d/theme.conf
sudo systemctl enable sddm.service

###### Packages ########

yay -S --noconfirm --needed 7zip
yay -S --noconfirm --needed alacritty
yay -S --noconfirm --needed alsa-firmware
yay -S --noconfirm --needed alsa-plugins
yay -S --noconfirm --needed alsa-utils
yay -S --noconfirm --needed amd-ucode
yay -S --noconfirm --needed antimicrox
yay -S --noconfirm --needed appimagelauncher
yay -S --noconfirm --needed ardour
yay -S --noconfirm --needed arj
yay -S --noconfirm --needed audacious
yay -S --noconfirm --needed audacity
yay -S --noconfirm --needed auto-cpufreq
yay -S --noconfirm --needed autostart
yay -S --noconfirm --needed autotiling
yay -S --noconfirm --needed avizo
yay -S --noconfirm --needed azote
yay -S --noconfirm --needed b43-fwcutter
yay -S --noconfirm --needed base
yay -S --noconfirm --needed base-devel
yay -S --noconfirm --needed bash-completion
yay -S --noconfirm --needed battop
yay -S --noconfirm --needed bc
yay -S --noconfirm --needed bemenu-wayland
yay -S --noconfirm --needed bind
yay -S --noconfirm --needed bleachbit
yay -S --noconfirm --needed blender
yay -S --noconfirm --needed blueman
yay -S --noconfirm --needed bluez-utils
yay -S --noconfirm --needed bottles
yay -S --noconfirm --needed bottom
yay -S --noconfirm --needed boxtron
yay -S --noconfirm --needed bridge-utils
yay -S --noconfirm --needed brightnessctl
yay -S --noconfirm --needed btop
yay -S --noconfirm --needed btrfs-assistant
yay -S --noconfirm --needed calcurse
yay -S --noconfirm --needed catfish
yay -S --noconfirm --needed celluloid
yay -S --noconfirm --needed cliphist
yay -S --noconfirm --needed corectrl
yay -S --noconfirm --needed cpupower
yay -S --noconfirm --needed curl
yay -S --noconfirm --needed curlftpfs
yay -S --noconfirm --needed darktable
yay -S --noconfirm --needed deluge
yay -S --noconfirm --needed dex
yay -S --noconfirm --needed dialog
yay -S --noconfirm --needed dmenu
yay -S --noconfirm --needed dmidecode
yay -S --noconfirm --needed dmraid
yay -S --noconfirm --needed dosfstools
yay -S --noconfirm --needed downgrade
yay -S --noconfirm --needed dracut
yay -S --noconfirm --needed dua-cli
yay -S --noconfirm --needed dunst
yay -S --noconfirm --needed dunstctl
yay -S --noconfirm --needed dvgrab
yay -S --noconfirm --needed dxvk-mingw-git
yay -S --noconfirm --needed earlyoom
yay -S --noconfirm --needed easyeffects
yay -S --noconfirm --needed ecryptfs-utils
yay -S --noconfirm --needed efibootmgr
yay -S --noconfirm --needed eog
yay -S --noconfirm --needed ethtool
yay -S --noconfirm --needed exfatprogs
yay -S --noconfirm --needed f2fs-tools
yay -S --noconfirm --needed falkon
yay -S --noconfirm --needed fastfetch
yay -S --noconfirm --needed fatresize
yay -S --noconfirm --needed feh
yay -S --noconfirm --needed ffmpegthumbnailer
yay -S --noconfirm --needed ffmpegthumbs
yay -S --noconfirm --needed file-roller
yay -S --noconfirm --needed findutils
yay -S --noconfirm --needed fish
yay -S --noconfirm --needed flameshot
yay -S --noconfirm --needed flatpak
yay -S --noconfirm --needed font-manager
yay -S --noconfirm --needed foot
yay -S --noconfirm --needed frei0r-plugins
yay -S --noconfirm --needed fscrypt
yay -S --noconfirm --needed fuse2fs
yay -S --noconfirm --needed fuzzel
yay -S --noconfirm --needed fwupd
yay -S --noconfirm --needed galculator
yay -S --noconfirm --needed gamemode
yay -S --noconfirm --needed gamescope
yay -S --noconfirm --needed gamescope-session-git
yay -S --noconfirm --needed garcon
yay -S --noconfirm --needed gedit
yay -S --noconfirm --needed gimp
yay -S --noconfirm --needed git
yay -S --noconfirm --needed gnome-disk-utility
yay -S --noconfirm --needed gnome-firmware
yay -S --noconfirm --needed gnome-keyring
yay -S --noconfirm --needed gnu-netcat
yay -S --noconfirm --needed goverlay
yay -S --noconfirm --needed gparted
yay -S --noconfirm --needed grim
yay -S --noconfirm --needed grimshot
yay -S --noconfirm --needed grub
yay -S --noconfirm --needed grub-btrfs
yay -S --noconfirm --needed gst-libav
yay -S --noconfirm --needed gst-plugin-pipewire
yay -S --noconfirm --needed gst-plugins-bad
yay -S --noconfirm --needed gst-plugins-ugly
yay -S --noconfirm --needed gstreamer-vaapi
yay -S --noconfirm --needed gtklock
yay -S --noconfirm --needed gtklock-powerbar-module
yay -S --noconfirm --needed gtklock-userinfo-module
yay -S --noconfirm --needed gvfs
yay -S --noconfirm --needed gvfs-afc
yay -S --noconfirm --needed gvfs-gphoto2
yay -S --noconfirm --needed gvfs-mtp
yay -S --noconfirm --needed gvfs-nfs
yay -S --noconfirm --needed gvfs-smb
yay -S --noconfirm --needed heroic-games-launcher-bin
yay -S --noconfirm --needed htop
yay -S --noconfirm --needed imagemagick
yay -S --noconfirm --needed imv
yay -S --noconfirm --needed inetutils
yay -S --noconfirm --needed inkscape
yay -S --noconfirm --needed intel-media-driver
yay -S --noconfirm --needed intel-ucode
yay -S --noconfirm --needed inxi
yay -S --noconfirm --needed iwd
yay -S --noconfirm --needed jfsutils
yay -S --noconfirm --needed joystickwake
yay -S --noconfirm --needed jq
yay -S --noconfirm --needed kanshi
yay -S --noconfirm --needed kate
yay -S --noconfirm --needed kdenlive
yay -S --noconfirm --needed kitty
yay -S --noconfirm --needed konsole
yay -S --noconfirm --needed krita
yay -S --noconfirm --needed krita-plugin-gmic
yay -S --noconfirm --needed kvantum
yay -S --noconfirm --needed kvantum-qt5
yay -S --noconfirm --needed lact
yay -S --noconfirm --needed lhasa
yay -S --noconfirm --needed lib32-gamemode
yay -S --noconfirm --needed lib32-mangohud
yay -S --noconfirm --needed lib32-mesa
yay -S --noconfirm --needed lib32-pipewire-jack
yay -S --noconfirm --needed lib32-vulkan-icd-loader
yay -S --noconfirm --needed lib32-vulkan-radeon
yay -S --noconfirm --needed libdvdcss
yay -S --noconfirm --needed libgsf
yay -S --noconfirm --needed libmythes
yay -S --noconfirm --needed libnotify
yay -S --noconfirm --needed libopenraw
yay -S --noconfirm --needed libpulse
yay -S --noconfirm --needed libreoffice-fresh
yay -S --noconfirm --needed libva-intel-driver
yay -S --noconfirm --needed libva-mesa-driver
yay -S --noconfirm --needed light
yay -S --noconfirm --needed lm_sensors
yay -S --noconfirm --needed lmms
yay -S --noconfirm --needed logrotate
yay -S --noconfirm --needed lrzip
yay -S --noconfirm --needed lsb-release
yay -S --noconfirm --needed lutris
yay -S --noconfirm --needed lvm2
yay -S --noconfirm --needed lzip
yay -S --noconfirm --needed lzop
yay -S --noconfirm --needed mako
yay -S --noconfirm --needed man-db
yay -S --noconfirm --needed man-pages
yay -S --noconfirm --needed mangohud
yay -S --noconfirm --needed mcfly
yay -S --noconfirm --needed meld
yay -S --noconfirm --needed memtest86+
yay -S --noconfirm --needed menus
yay -S --noconfirm --needed mesa
yay -S --noconfirm --needed micro
yay -S --noconfirm --needed mixxx
yay -S --noconfirm --needed mousepad
yay -S --noconfirm --needed movit
yay -S --noconfirm --needed mpd
yay -S --noconfirm --needed mpdris2
yay -S --noconfirm --needed mpv
yay -S --noconfirm --needed mpv-mpris
yay -S --noconfirm --needed mtools
yay -S --noconfirm --needed nano
yay -S --noconfirm --needed ncmpcpp
yay -S --noconfirm --needed neofetch
yay -S --noconfirm --needed neovim
yay -S --noconfirm --needed net-tools
yay -S --noconfirm --needed network-manager-applet
yay -S --noconfirm --needed networkmanager
yay -S --noconfirm --needed nfs-utils
yay -S --noconfirm --needed nilfs-utils
yay -S --noconfirm --needed nitrogen
yay -S --noconfirm --needed nm-applet
yay -S --noconfirm --needed nmap
yay -S --noconfirm --needed nss-mdns
yay -S --noconfirm --needed ntfs-3g
yay -S --noconfirm --needed nwg-displays
yay -S --noconfirm --needed nwg-drawer
yay -S --noconfirm --needed nwg-hello
yay -S --noconfirm --needed nwg-launchers
yay -S --noconfirm --needed nwg-look
yay -S --noconfirm --needed nwg-menu
yay -S --noconfirm --needed nwg-panel
yay -S --noconfirm --needed octopi
yay -S --noconfirm --needed opus-tools
yay -S --noconfirm --needed os-prober
yay -S --noconfirm --needed p7zip
yay -S --noconfirm --needed pacman-contrib
yay -S --noconfirm --needed pacseek
yay -S --noconfirm --needed pamac
yay -S --noconfirm --needed pamixer
yay -S --noconfirm --needed parole
yay -S --noconfirm --needed paru
yay -S --noconfirm --needed pavucontrol
yay -S --noconfirm --needed perl-file-mimeinfo
yay -S --noconfirm --needed picom
yay -S --noconfirm --needed pipewire
yay -S --noconfirm --needed pipewire-alsa
yay -S --noconfirm --needed pipewire-jack
yay -S --noconfirm --needed pipewire-pulse
yay -S --noconfirm --needed playerctl
yay -S --noconfirm --needed plocate
yay -S --noconfirm --needed polkit-gnome
yay -S --noconfirm --needed polykit
yay -S --noconfirm --needed popsicle
yay -S --noconfirm --needed power-profiles-daemon
yay -S --noconfirm --needed powertop
yay -S --noconfirm --needed proton-ge-custom-bin
yay -S --noconfirm --needed psd
yay -S --noconfirm --needed pulse
yay -S --noconfirm --needed python-gobject
yay -S --noconfirm --needed qbittorrent
yay -S --noconfirm --needed qt5-wayland
yay -S --noconfirm --needed qt5ct
yay -S --noconfirm --needed qt6-wayland
yay -S --noconfirm --needed qt6ct
yay -S --noconfirm --needed rebuild-detector
yay -S --noconfirm --needed reflector
yay -S --noconfirm --needed ristretto
yay -S --noconfirm --needed rocm-hip-runtime
yay -S --noconfirm --needed rocm-opencl-runtime
yay -S --noconfirm --needed rofi-wayland
yay -S --noconfirm --needed rsync
yay -S --noconfirm --needed s-tui
yay -S --noconfirm --needed sassc
yay -S --noconfirm --needed sddm
yay -S --noconfirm --needed slurp
yay -S --noconfirm --needed smartmontools
yay -S --noconfirm --needed smplayer
yay -S --noconfirm --needed snapper-support
yay -S --noconfirm --needed snapper-tools
yay -S --noconfirm --needed sof-firmware
yay -S --noconfirm --needed sox
yay -S --noconfirm --needed spotify
yay -S --noconfirm --needed sshfs
yay -S --noconfirm --needed starship
yay -S --noconfirm --needed steam
yay -S --noconfirm --needed sudo
yay -S --noconfirm --needed swappy
yay -S --noconfirm --needed sway-contrib
yay -S --noconfirm --needed swaybg
yay -S --noconfirm --needed swayfx-git
yay -S --noconfirm --needed swayidle
yay -S --noconfirm --needed swayimg
yay -S --noconfirm --needed swaylock
yay -S --noconfirm --needed swaylock-effects
yay -S --noconfirm --needed swayr
yay -S --noconfirm --needed swww
yay -S --noconfirm --needed terminus-font
yay -S --noconfirm --needed thunar
yay -S --noconfirm --needed thunar-archive-plugin
yay -S --noconfirm --needed thunar-media-tags-plugin
yay -S --noconfirm --needed thunar-shares-plugin
yay -S --noconfirm --needed thunar-volman
yay -S --noconfirm --needed thunderbird
yay -S --noconfirm --needed traceroute
yay -S --noconfirm --needed tumbler
yay -S --noconfirm --needed ufw
yay -S --noconfirm --needed ugrep
yay -S --noconfirm --needed unace
yay -S --noconfirm --needed unarchiver
yay -S --noconfirm --needed unarj
yay -S --noconfirm --needed unrar
yay -S --noconfirm --needed unzip
yay -S --noconfirm --needed vi
yay -S --noconfirm --needed vim
yay -S --noconfirm --needed visual-studio-code-bin
yay -S --noconfirm --needed vkbasalt
yay -S --noconfirm --needed vlc
yay -S --noconfirm --needed vscodium
yay -S --noconfirm --needed vulkan-icd-loader
yay -S --noconfirm --needed vulkan-intel
yay -S --noconfirm --needed vulkan-mesa-layers
yay -S --noconfirm --needed vulkan-nouveau
yay -S --noconfirm --needed vulkan-radeon
yay -S --noconfirm --needed waybar
yay -S --noconfirm --needed waybar-module-pacman-updates-git
yay -S --noconfirm --needed wayland
yay -S --noconfirm --needed wayland-protocols
yay -S --noconfirm --needed wayland-utils
yay -S --noconfirm --needed wf-recorder
yay -S --noconfirm --needed wget
yay -S --noconfirm --needed whois
yay -S --noconfirm --needed wireless-regdb
yay -S --noconfirm --needed wireless_tools
yay -S --noconfirm --needed wireplumber
yay -S --noconfirm --needed wl-clipboard
yay -S --noconfirm --needed wl-clipboard-history-git
yay -S --noconfirm --needed wlogout
yay -S --noconfirm --needed wlr-randr
yay -S --noconfirm --needed wlroots
yay -S --noconfirm --needed wmcliphist
yay -S --noconfirm --needed wmenu
yay -S --noconfirm --needed wofi
yay -S --noconfirm --needed wqy-zenhei
yay -S --noconfirm --needed wtype
yay -S --noconfirm --needed xdg-desktop-portal-wlr
yay -S --noconfirm --needed xdg-user-dirs
yay -S --noconfirm --needed xdg-utils
yay -S --noconfirm --needed xf86-video-amdgpu
yay -S --noconfirm --needed xfce4-terminal-git
yay -S --noconfirm --needed xfsprogs
yay -S --noconfirm --needed xorg-xhost
yay -S --noconfirm --needed xorg-xrandr
yay -S --noconfirm --needed xorg-xwayland
yay -S --noconfirm --needed xpadneo-dkms
yay -S --noconfirm --needed xsel
yay -S --noconfirm --needed xsettingsd
yay -S --noconfirm --needed XWayland
yay -S --noconfirm --needed xz
yay -S --noconfirm --needed yad
yay -S --noconfirm --needed zip
yay -S --noconfirm --needed zram-generator
yay -S --noconfirm --needed zsh
yay -S --noconfirm --needed zsh-autocomplete
yay -S --noconfirm --needed zsh-autosuggestions
yay -S --noconfirm --needed zsh-history-substring-search
yay -S --noconfirm --needed zsh-syntax-highlighting


###### Browsers ########
yay -S --noconfirm --needed brave-bin
yay -S --noconfirm --needed microsoft-edge-stable-bin
yay -S --noconfirm --needed vivaldi
yay -S --noconfirm --needed vivaldi-ffmpeg-codecs
yay -S --noconfirm --needed google-chrome
yay -S --noconfirm --needed firefox

###### Firewall installs ####
sudo ufw enable
sudo ufw status verbose
sudo systemctl enable ufw.service
sudo systemctl enable fstrim.timer
sudo systemctl start fstrim.timer
du -sh /var/cache/pacman/pkg/
sudo pacman -S -y pacman-contrib
sudo systemctl enable paccache.timer


###### Themes installs ####
yay -S --noconfirm --needed arc-gtk-theme-eos
yay -S --noconfirm --needed arc-x-icons-theme
yay -S --noconfirm --needed bibata-cursor-theme
yay -S --noconfirm --needed bibata-cursor-translucent
yay -S --noconfirm --needed bibata-extra-cursor-theme
yay -S --noconfirm --needed bibata-rainbow-cursor-theme
yay -S --noconfirm --needed dracula-cursors-git
yay -S --noconfirm --needed dracula-gtk-theme-git
yay -S --noconfirm --needed dracula-icons-git
yay -S --noconfirm --needed fluent-gtk-theme-git
yay -S --noconfirm --needed graphite-gtk-theme-git
yay -S --noconfirm --needed kvantum
yay -S --noconfirm --needed kvantum-theme-materia
yay -S --noconfirm --needed kvantum-theme-nordic-git
yay -S --noconfirm --needed kvantum-theme-qogir-git
yay -S --noconfirm --needed layan-gtk-theme-git
yay -S --noconfirm --needed materia-gtk-theme
yay -S --noconfirm --needed nordic-darker-theme
yay -S --noconfirm --needed numix-gtk-theme-git
yay -S --noconfirm --needed obsidian-icon-theme
yay -S --noconfirm --needed oh-my-zsh-powerline-theme-git
yay -S --noconfirm --needed papirus-icon-theme
yay -S --noconfirm --needed qogir-gtk-theme-git
yay -S --noconfirm --needed sweet-gtk-theme-dark
yay -S --noconfirm --needed tokyonight-gtk-theme-git
yay -S --noconfirm --needed vimix-cursors
yay -S --noconfirm --needed vimix-gtk-themes
yay -S --noconfirm --needed vimix-icon-theme
yay -S --noconfirm --needed whitesur-icon-theme-git
yay -S --noconfirm --needed yaru-icon-theme
yay -S --noconfirm --needed tokyonight-gtk-theme-git
yay -S --noconfirm --needed papirus-icon-theme
yay -S --noconfirm --needed tela-circle-icon-theme-manjaro
yay -S --noconfirm --needed tela-circle-icon-theme-nord
yay -S --noconfirm --needed nordic-darker-theme
yay -S --noconfirm --needed nordic-theme-git


###### Fonts installs ####
yay -S --noconfirm --needed adobe-source-code-pro-fonts
yay -S --noconfirm --needed adobe-source-han-sans-cn-fonts
yay -S --noconfirm --needed adobe-source-han-sans-jp-fonts
yay -S --noconfirm --needed adobe-source-han-sans-kr-fonts
yay -S --noconfirm --needed adobe-source-sans-fonts
yay -S --noconfirm --needed adobe-source-serif-fonts
yay -S --noconfirm --needed awesome-terminal-fonts
yay -S --noconfirm --needed font-manager
yay -S --noconfirm --needed gsfonts
yay -S --noconfirm --needed noto-fonts
yay -S --noconfirm --needed noto-fonts noto-fonts-emoji
yay -S --noconfirm --needed noto-fonts-cjk
yay -S --noconfirm --needed noto-fonts-emoji
yay -S --noconfirm --needed noto-fonts-extra
yay -S --noconfirm --needed otf-aurulent-nerd
yay -S --noconfirm --needed otf-codenewroman-nerd
yay -S --noconfirm --needed otf-comicshanns-nerd
yay -S --noconfirm --needed otf-commit-mono-nerd
yay -S --noconfirm --needed otf-droid-nerd
yay -S --noconfirm --needed otf-firamono-nerd
yay -S --noconfirm --needed otf-font-awesome
yay -S --noconfirm --needed otf-font-awesome-4
yay -S --noconfirm --needed otf-geist-mono-nerd
yay -S --noconfirm --needed otf-hasklig-nerd
yay -S --noconfirm --needed otf-hermit-nerd
yay -S --noconfirm --needed otf-libertinus
yay -S --noconfirm --needed otf-monaspace-nerd
yay -S --noconfirm --needed otf-opendyslexic-nerd
yay -S --noconfirm --needed otf-overpass-ne
yay -S --noconfirm --needed otf-overpass-nerd
yay -S --noconfirm --needed powerline-fonts
yay -S --noconfirm --needed terminus-font
yay -S --noconfirm --needed ttf-0xproto-nerd
yay -S --noconfirm --needed ttf-3270-nerd
yay -S --noconfirm --needed ttf-agave-nerd
yay -S --noconfirm --needed ttf-anonymous-pro
yay -S --noconfirm --needed ttf-anonymouspro-nerd
yay -S --noconfirm --needed ttf-arimo-nerd
yay -S --noconfirm --needed ttf-bigblueterminal-nerd
yay -S --noconfirm --needed ttf-bitstream-vera
yay -S --noconfirm --needed ttf-bitstream-vera-mono-nerd
yay -S --noconfirm --needed ttf-caladea
yay -S --noconfirm --needed ttf-carlito
yay -S --noconfirm --needed ttf-cascadia-code
yay -S --noconfirm --needed ttf-cascadia-code-nerd
yay -S --noconfirm --needed ttf-cascadia-mono-nerd
yay -S --noconfirm --needed ttf-cormorant
yay -S --noconfirm --needed ttf-cousine-nerd
yay -S --noconfirm --needed ttf-croscore
yay -S --noconfirm --needed ttf-d2coding-nerd
yay -S --noconfirm --needed ttf-daddytime-mono-nerd
yay -S --noconfirm --needed ttf-dejavu
yay -S --noconfirm --needed ttf-dejavu-nerd
yay -S --noconfirm --needed ttf-droid
yay -S --noconfirm --needed ttf-envycoder-nerd
yay -S --noconfirm --needed ttf-eurof
yay -S --noconfirm --needed ttf-fantasque-nerd
yay -S --noconfirm --needed ttf-fantasque-sans-mono
yay -S --noconfirm --needed ttf-fira-code
yay -S --noconfirm --needed ttf-fira-mono
yay -S --noconfirm --needed ttf-fira-sans
yay -S --noconfirm --needed ttf-firacode-nerd
yay -S --noconfirm --needed ttf-font-awesome
yay -S --noconfirm --needed ttf-go-nerd
yay -S --noconfirm --needed ttf-gohu-nerd
yay -S --noconfirm --needed ttf-google-fonts-git
yay -S --noconfirm --needed ttf-hack
yay -S --noconfirm --needed ttf-hack-nerd
yay -S --noconfirm --needed ttf-hactor
yay -S --noconfirm --needed ttf-heavydata-nerd
yay -S --noconfirm --needed ttf-hellvetica
yay -S --noconfirm --needed ttf-iawriter-nerd
yay -S --noconfirm --needed ttf-ibm-plex
yay -S --noconfirm --needed ttf-ibmplex-mono-nerd
yay -S --noconfirm --needed ttf-inconsolata
yay -S --noconfirm --needed ttf-inconsolata-go-nerd
yay -S --noconfirm --needed ttf-inconsolata-lgc-nerd
yay -S --noconfirm --needed ttf-inconsolata-nerd
yay -S --noconfirm --needed ttf-intone-nerd
yay -S --noconfirm --needed ttf-iosevka-nerd
yay -S --noconfirm --needed ttf-iosevkaterm-nerd
yay -S --noconfirm --needed ttf-iosevkatermslab-nerd
yay -S --noconfirm --needed ttf-jetbrains-mono
yay -S --noconfirm --needed ttf-jetbrains-mono-nerd
yay -S --noconfirm --needed ttf-joypixels
yay -S --noconfirm --needed ttf-lato
yay -S --noconfirm --needed ttf-lekton-nerd
yay -S --noconfirm --needed ttf-liberation
yay -S --noconfirm --needed ttf-liberation-mono-nerd
yay -S --noconfirm --needed ttf-lilex-nerd
yay -S --noconfirm --needed ttf-linux-libertine
yay -S --noconfirm --needed ttf-linux-libertine-g
yay -S --noconfirm --needed ttf-mac-fonts
yay -S --noconfirm --needed ttf-martian-mono-nerd
yay -S --noconfirm --needed ttf-meslo-nerd
yay -S --noconfirm --needed ttf-meslo-nerd-font-powerlevel10k
yay -S --noconfirm --needed ttf-monofur
yay -S --noconfirm --needed ttf-monofur-nerd
yay -S --noconfirm --needed ttf-monoid-nerd
yay -S --noconfirm --needed ttf-mononoki-nerd
yay -S --noconfirm --needed ttf-mplus-nerd
yay -S --noconfirm --needed ttf-ms-fonts
yay -S --noconfirm --needed ttf-nerd-fonts-symbols
yay -S --noconfirm --needed ttf-nerd-fonts-symbols-2048-em
yay -S --noconfirm --needed ttf-nerd-fonts-symbols-common
yay -S --noconfirm --needed ttf-nerd-fonts-symbols-mono
yay -S --noconfirm --needed ttf-noto-nerd
yay -S --noconfirm --needed ttf-opensans
yay -S --noconfirm --needed ttf-profont-nerd
yay -S --noconfirm --needed ttf-proggyclean-nerd
yay -S --noconfirm --needed ttf-recursive-nerd
yay -S --noconfirm --needed ttf-roboto
yay -S --noconfirm --needed ttf-roboto-mono
yay -S --noconfirm --needed ttf-roboto-mono-nerd
yay -S --noconfirm --needed ttf-sharetech-mono-nerd
yay -S --noconfirm --needed ttf-sourcecodepro-nerd
yay -S --noconfirm --needed ttf-space-mono-nerd
yay -S --noconfirm --needed ttf-terminus-nerd
yay -S --noconfirm --needed ttf-tinos-nerd
yay -S --noconfirm --needed ttf-ubuntu-font-family
yay -S --noconfirm --needed ttf-ubuntu-mono-nerd
yay -S --noconfirm --needed ttf-ubuntu-nerd
yay -S --noconfirm --needed ttf-victor-mono-nerd
yay -S --noconfirm --needed ttf-zed-mono-nerd
yay -S --noconfirm --needed tty-clock-git
yay -S --noconfirm --needed xorg-fonts-misc
yay -S --noconfirm --needed xorg-mkfontscale

sudo pacman -Syu && sudo pacman -Scc && fc-cache -fv




###### Flatpaks installs ####
flatpak install flathub com.github.tchx84.Flatseal --assumeyes  --or-update --system
flatpak install flathub org.dupot.easyflatpak --assumeyes  --or-update --system


sudo pacman -Syu && sudo pacman -Syyu
