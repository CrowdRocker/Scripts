# !/bin/bash


sudo pacman -Sy archlinux-keyring && sudo pacman -Syyu

# enable flatpaks
sudo pacman -S --noconfirm --needed flatpak

###### yay ########
sudo pacman -S --needed git base-devel && git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si && cd

###### paru ########
yay -S --noconfirm --needed paru 

###### i3 ########
sudo pacman -S --noconfirm --needed  xfce4 xfce4-goodies i3status dmenu i3lock xorg-xinit i3-gaps picom polybar alacritty kitty dunst rofi BetterLockscreen SDDM-Astronaut-Theme nitrogen feh wdisplay

# sddm
sudo pacman -S --noconfirm --needed sddm
sudo systemctl enable sddm.service

###### Packages ########     
yay -S --noconfirm --needed bottles
yay -S --noconfirm --needed pikaur
yay -S --noconfirm --needed yaru-icon-theme
yay -S --noconfirm --needed arch-gaming-meta
yay -S --noconfirm --needed dxvk-bin
yay -S --noconfirm --needed protontricks
yay -S --noconfirm --needed protonup-qt
yay -S --noconfirm --needed samba
yay -S --noconfirm --needed sane
yay -S --noconfirm --needed wine-installer
yay -S --noconfirm --needed archlinux-tweak-tool-git
yay -S --noconfirm --needed alacritty
yay -S --noconfirm --needed kitty
yay -S --noconfirm --needed cava
yay -S --noconfirm --needed glava
yay -S --noconfirm --needed mpd
yay -S --noconfirm --needed mpv
yay -S --noconfirm --needed ncmpcpp
yay -S --noconfirm --needed fastfetch
yay -S --noconfirm --needed newsboat
yay -S --noconfirm --needed neovim
yay -S --noconfirm --needed retroarch
yay -S --noconfirm --needed taskell
yay -S --noconfirm --needed zathura
yay -S --noconfirm --needed lutris
yay -S --noconfirm --needed alsa-utils
yay -S --noconfirm --needed amd-ucode
yay -S --noconfirm --needed arandr
yay -S --noconfirm --needed aria2
yay -S --noconfirm --needed b43-fwcutter
yay -S --noconfirm --needed baobab
yay -S --noconfirm --needed base
yay -S --noconfirm --needed base-devel
yay -S --noconfirm --needed bind
yay -S --noconfirm --needed blender
yay -S --noconfirm --needed boxtron
yay -S --noconfirm --needed brltty
yay -S --noconfirm --needed broadcom-wl-dkms
yay -S --noconfirm --needed btrfs-progs
yay -S --noconfirm --needed btrfs-assistant
yay -S --noconfirm --needed carla
yay -S --noconfirm --needed clonezilla
yay -S --noconfirm --needed cloud-init
yay -S --noconfirm --needed cryptsetup
yay -S --noconfirm --needed curl
yay -S --noconfirm --needed cups
yay -S --noconfirm --needed darkhttpd
yay -S --noconfirm --needed darktable
yay -S --noconfirm --needed ddrescue
yay -S --noconfirm --needed dhclient
yay -S --noconfirm --needed dhcpcd
yay -S --noconfirm --needed dialog
yay -S --noconfirm --needed diffutils
yay -S --noconfirm --needed dmidecode
yay -S --noconfirm --needed dmraid
yay -S --noconfirm --needed dnsmasq
yay -S --noconfirm --needed dosfstools
yay -S --noconfirm --needed e2fsprogs
yay -S --noconfirm --needed edk2-shell
yay -S --noconfirm --needed efibootmgr
yay -S --noconfirm --needed enchant
yay -S --noconfirm --needed espeakup
yay -S --noconfirm --needed ethtool
yay -S --noconfirm --needed exfatprogs
yay -S --noconfirm --needed f2fs-tools
yay -S --noconfirm --needed fatresize
yay -S --noconfirm --needed filezilla
yay -S --noconfirm --needed firefox
yay -S --noconfirm --needed flashplugin
yay -S --noconfirm --needed fsarchiver
yay -S --noconfirm --needed github-cli
yay -S --noconfirm --needed gst-libav
yay -S --noconfirm --needed gst-plugins-good
yay -S --noconfirm --needed gamescope
yay -S --noconfirm --needed gawk
yay -S --noconfirm --needed gdb
yay -S --noconfirm --needed gimp
yay -S --noconfirm --needed git
yay -S --noconfirm --needed gnu-netcat
yay -S --noconfirm --needed goverlay
yay -S --noconfirm --needed gpart
yay -S --noconfirm --needed gpm
yay -S --noconfirm --needed gptfdisk
yay -S --noconfirm --needed grub
yay -S --noconfirm --needed udate-grub
yay -S --noconfirm --needed gstreamer
yay -S --noconfirm --needed gufw
yay -S --noconfirm --needed gvfs
yay -S --noconfirm --needed gvfs-afc
yay -S --noconfirm --needed gvfs-gphoto2
yay -S --noconfirm --needed gvfs-mtp
yay -S --noconfirm --needed gvfs-nfs
yay -S --noconfirm --needed gvfs-smb
yay -S --noconfirm --needed hdparm
yay -S --noconfirm --needed hexchat
yay -S --noconfirm --needed hydrogen
yay -S --noconfirm --needed hyperv
yay -S --noconfirm --needed imagemagick
yay -S --noconfirm --needed inkscape
yay -S --noconfirm --needed irssi
yay -S --noconfirm --needed iw
yay -S --noconfirm --needed iwd
yay -S --noconfirm --needed jacktrip
yay -S --noconfirm --needed jfsutils
yay -S --noconfirm --needed jq
yay -S --noconfirm --needed jre8-openjdk
yay -S --noconfirm --needed kdenlive
yay -S --noconfirm --needed keepassxc
yay -S --noconfirm --needed kitty-terminfo
yay -S --noconfirm --needed languagetool
yay -S --noconfirm --needed less
yay -S --noconfirm --needed lftp
yay -S --noconfirm --needed libfido2
yay -S --noconfirm --needed libmythes
yay -S --noconfirm --needed libpipewire
yay -S --noconfirm --needed libreoffice-fresh
yay -S --noconfirm --needed libusb-compat
yay -S --noconfirm --needed linux-atm
yay -S --noconfirm --needed linux-headers
yay -S --noconfirm --needed speexdsp
yay -S --noconfirm --needed rnnoise
yay -S --noconfirm --needed mda.lv2
yay -S --noconfirm --needed speex
yay -S --noconfirm --needed nlohmann-json
yay -S --noconfirm --needed meson
yay -S --noconfirm --needed appstream-glib
yay -S --noconfirm --needed zam-plugins-lv2
yay -S --noconfirm --needed lsp-plugins-lv2
yay -S --noconfirm --needed zita-convolver
yay -S --noconfirm --needed livecd-sounds
yay -S --noconfirm --needed lmms
yay -S --noconfirm --needed easyeffects
yay -S --noconfirm --needed lsscsi
yay -S --noconfirm --needed lvm2
yay -S --noconfirm --needed lynx
yay -S --noconfirm --needed man-db
yay -S --noconfirm --needed man-pages
yay -S --noconfirm --needed mangohud
yay -S --noconfirm --needed mc
yay -S --noconfirm --needed mdadm
yay -S --noconfirm --needed meld
yay -S --noconfirm --needed memtest86+
yay -S --noconfirm --needed memtest86+-efi
yay -S --noconfirm --needed mixxx
yay -S --noconfirm --needed mkinitcpio
yay -S --noconfirm --needed mkinitcpio-archiso
yay -S --noconfirm --needed mkinitcpio-nfs-utils
yay -S --noconfirm --needed mkinitcpio-openswap
yay -S --noconfirm --needed mkinitcpio-firmware
yay -S --noconfirm --needed modemmanager
yay -S --noconfirm --needed mtools
yay -S --noconfirm --needed mtpfs
yay -S --noconfirm --needed muse
yay -S --noconfirm --needed mythes-en
yay -S --noconfirm --needed nano
yay -S --noconfirm --needed nbd
yay -S --noconfirm --needed ndisc6
yay -S --noconfirm --needed net-tools
yay -S --noconfirm --needed nfs-utils
yay -S --noconfirm --needed nilfs-utils
yay -S --noconfirm --needed nmap
yay -S --noconfirm --needed ntfs-3g
yay -S --noconfirm --needed numlockx
yay -S --noconfirm --needed nvme-cli
yay -S --noconfirm --needed obs-studio
yay -S --noconfirm --needed octopi
yay -S --noconfirm --needed open-iscsi
yay -S --noconfirm --needed open-vm-tools
yay -S --noconfirm --needed openconnect
yay -S --noconfirm --needed openshot
yay -S --noconfirm --needed openssh
yay -S --noconfirm --needed openvpn
yay -S --noconfirm --needed p7zip
yay -S --noconfirm --needed partclone
yay -S --noconfirm --needed parted
yay -S --noconfirm --needed partimage
yay -S --noconfirm --needed pavucontrol
yay -S --noconfirm --needed pcsclite
yay -S --noconfirm --needed pev
yay -S --noconfirm --needed calf
yay -S --noconfirm --needed plank
yay -S --noconfirm --needed powerpill
yay -S --noconfirm --needed ppp
yay -S --noconfirm --needed pptpclient
yay -S --noconfirm --needed pv
yay -S --noconfirm --needed qbittorrent
yay -S --noconfirm --needed qemu-guest-agent
yay -S --noconfirm --needed qpwgraph
yay -S --noconfirm --needed qsynth
yay -S --noconfirm --needed qtractor
yay -S --noconfirm --needed qt5
yay -S --noconfirm --needed rate-mirrors-bin
yay -S --noconfirm --needed realtime-privileges
yay -S --noconfirm --needed refind
yay -S --noconfirm --needed reflector
yay -S --noconfirm --needed reiserfsprogs
yay -S --noconfirm --needed replay-sorcery
yay -S --noconfirm --needed ripgrep-all
yay -S --noconfirm --needed rp-pppoe
yay -S --noconfirm --needed rsync
yay -S --noconfirm --needed rtkit
yay -S --noconfirm --needed rxvt-unicode-terminfo
yay -S --noconfirm --needed screen
yay -S --noconfirm --needed scummvm
yay -S --noconfirm --needed sdparm
yay -S --noconfirm --needed sg3_utils
yay -S --noconfirm --needed shotwell
yay -S --noconfirm --needed smartmontools
yay -S --noconfirm --needed sof-firmware
yay -S --noconfirm --needed spotify-launcher
yay -S --noconfirm --needed squashfs-tools
yay -S --noconfirm --needed strace
yay -S --noconfirm --needed sudo
yay -S --noconfirm --needed syslinux
yay -S --noconfirm --needed systemd-resolvconf
yay -S --noconfirm --needed tcpdump
yay -S --noconfirm --needed terminus-font
yay -S --noconfirm --needed testdisk
yay -S --noconfirm --needed thunderbird
yay -S --noconfirm --needed tmux
yay -S --noconfirm --needed tpm2-tss
yay -S --noconfirm --needed udftools
yay -S --noconfirm --needed udiskie
yay -S --noconfirm --needed udisks2
yay -S --noconfirm --needed ufw
yay -S --noconfirm --needed usb_modeswitch
yay -S --noconfirm --needed usbmuxd
yay -S --noconfirm --needed usbutils
yay -S --noconfirm --needed ventoy-bin
yay -S --noconfirm --needed vim
yay -S --noconfirm --needed vkbasalt
yay -S --noconfirm --needed vlc
yay -S --noconfirm --needed vpnc
yay -S --noconfirm --needed wget
yay -S --noconfirm --needed winetricks
yay -S --noconfirm --needed wireless-regdb
yay -S --noconfirm --needed wireless_tools
yay -S --noconfirm --needed wpa_supplicant
yay -S --noconfirm --needed wvdial
yay -S --noconfirm --needed xdg-user-dirs
yay -S --noconfirm --needed xdg-utils
yay -S --noconfirm --needed xdotool
yay -S --noconfirm --needed xfsprogs
yay -S --noconfirm --needed xl2tpd
yay -S --noconfirm --needed xorg-xwininfo
yay -S --noconfirm --needed yad
yay -S --noconfirm --needed avahi
yay -S --noconfirm --needed nss-mdns
yay -S --noconfirm --needed mobile-broadband-provider-info
yay -S --noconfirm --needed modemmanager
yay -S --noconfirm --needed networkmanager
yay -S --noconfirm --needed network-manager-applet
yay -S --noconfirm --needed networkmanager-openconnect
yay -S --noconfirm --needed networkmanager-openvpn
yay -S --noconfirm --needed networkmanager-pptp
yay -S --noconfirm --needed networkmanager-vpnc
yay -S --noconfirm --needed openresolv
yay -S --noconfirm --needed neofetch
yay -S --noconfirm --needed timeshift
yay -S --noconfirm --needed bash-completion
yay -S --noconfirm --needed os-prober
yay -S --noconfirm --needed dex
yay -S --noconfirm --needed libxinerama
yay -S --noconfirm --needed make
yay -S --noconfirm --needed xorg-server
yay -S --noconfirm --needed xorg-apps
yay -S --noconfirm --needed xorg-xkill
yay -S --noconfirm --needed xterm
yay -S --noconfirm --needed xorg-xrdb
sudo pacman -S --noconfirm --needed xorg-xinit
sudo pacman -S --noconfirm --needed xorg-fonts-misc


###### Browsers ########
yay -S --noconfirm --needed brave-bin
yay -S --noconfirm --needed microsoft-edge-stable-bin
yay -S --noconfirm --needed vivaldi
yay -S --noconfirm --needed vivaldi-ffmpeg-codecs
yay -S --noconfirm --needed opera
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

### update-grub

git clone https://aur.archlinux.org/update-grub.git
cd update-grub
makepkg -si
cd
sudo update-grub

### cachyos-repo
wget https://mirror.cachyos.org/cachyos-repo.tar.xz
tar xvf cachyos-repo.tar.xz && cd cachyos-repo
sudo ./cachyos-repo.sh

### chaotic-aur
sudo pacman-key --recv-key 3056513887B78AEB --keyserver keyserver.ubuntu.com
sudo pacman-key --lsign-key 3056513887B78AEB
sudo pacman -U 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-keyring.pkg.tar.zst'
sudo pacman -U 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-mirrorlist.pkg.tar.zst'


###### Flatpaks installs ####
flatpak install flathub com.github.tchx84.Flatseal --assumeyes  --or-update --system
flatpak install flathub com.adobe.Flash-Player-Projector --assumeyes  --or-update --system
flatpak install flathub nz.mega.MEGAsync --assumeyes  --or-update --system
flatpak install flathub fr.natron.Natron --assumeyes  --or-update --system
flatpak install flathub com.protonvpn.www --assumeyes  --or-update --system
flatpak install flathub me.proton.Pass --assumeyes  --or-update --system

###### ZSH ########
yay -S --noconfirm --needed zsh
yay -S --noconfirm --needed zsh-completions
yay -S --noconfirm --needed grml-zsh-config
sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

sudo pacman -Syyu && sudo pacman -Syu
