#!/bin/bash

# WehttamSnaps Hyprland Gaming & Streaming Setup Script
# For Arch Linux and Arch-based distros
# Optimized for AMD RX 580 gaming and content creation

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
NC='\033[0m' # No Color

# User info
USERNAME=$(whoami)
USER_HOME="/home/$USERNAME"

echo -e "${PURPLE}🎮 WehttamSnaps Hyprland Gaming & Streaming Setup${NC}"
echo -e "${BLUE}Setting up the ultimate Linux gaming and content creation environment...${NC}"

# Function to print section headers
print_section() {
    echo -e "\n${GREEN}=== $1 ===${NC}"
}

# Function to install packages
install_packages() {
    echo -e "${BLUE}Installing: $*${NC}"
    sudo pacman -S --needed --noconfirm "$@"
}

# Function to install AUR packages
install_aur() {
    echo -e "${BLUE}Installing AUR packages: $*${NC}"
    for pkg in "$@"; do
        if ! pacman -Qi "$pkg" &> /dev/null; then
            yay -S --noconfirm "$pkg"
        fi
    done
}

print_section "System Update & Base Setup"
sudo pacman -Syu --noconfirm

# Install yay AUR helper if not present
if ! command -v yay &> /dev/null; then
    print_section "Installing YAY AUR Helper"
    cd /tmp
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si --noconfirm
    cd ~
fi

print_section "Installing Core Hyprland & Dependencies"
install_packages base-devel git curl wget unzip zip \
    hyprland-git waybar-hyprland-git rofi-lbonn-wayland-git \
    dunst mako libnotify wl-clipboard cliphist \
    xdg-desktop-portal-hyprland qt5-wayland qt6-wayland \
    polkit-gnome python-requests pamixer pavucontrol \
    brightnessctl bluez bluez-utils bluetooth-autoconnect \
    network-manager-applet grim slurp imagemagick \
    ffmpeg viewnior mpv thunar thunar-archive-plugin \
    file-roller btop htop neofetch fastfetch \
    zsh starship lsd eza bat ripgrep fd fzf \
    noto-fonts noto-fonts-emoji ttf-jetbrains-mono-nerd \
    pipewire pipewire-alsa pipewire-pulse pipewire-jack \
    wireplumber alsa-utils

print_section "Installing Gaming Essentials"
# AMD GPU drivers and gaming packages
install_packages mesa lib32-mesa xf86-video-amdgpu vulkan-radeon \
    lib32-vulkan-radeon mesa-vdpau lib32-mesa-vdpau \
    steam lutris heroic-games-launcher-bin mangohud \
    gamemode lib32-gamemode wine winetricks \
    dxvk-bin vkd3d proton-ge-custom-bin \
    gamescope xorg-xwayland

# Enable services for gaming
sudo systemctl enable bluetooth
sudo usermod -aG gamemode "$USERNAME"

print_section "Installing Content Creation Tools"
install_packages obs-studio gimp krita blender \
    audacity kdenlive simplescreenrecorder \
    v4l2loopback-dkms linux-headers

# Load v4l2loopback for OBS virtual camera
echo 'v4l2loopback' | sudo tee /etc/modules-load.d/v4l2loopback.conf
sudo modprobe v4l2loopback

print_section "Installing Theme & Appearance Tools"
install_packages nwg-look azote sddm qt5-graphicaleffects \
    qt5-quickcontrols2 qt5-svg gtk3 gtk4

# AUR packages for enhanced functionality
print_section "Installing AUR Packages"
install_aur eww-wayland fuzzel-git hyprpicker-git \
    swaylock-effects-git swayidle-git wlogout \
    waybar-module-pacman-updates-git \
    sddm-sugar-candy-git nwg-drawer \
    webapp-manager-git photopea-git \
    vesktop-git spotify discord

print_section "Setting up JaKooLit Dotfiles"
# Clone JaKooLit's configuration
cd "$USER_HOME"
if [ ! -d "$USER_HOME/.config" ]; then
    mkdir -p "$USER_HOME/.config"
fi

# Backup existing configs
if [ -d "$USER_HOME/.config/hypr" ]; then
    mv "$USER_HOME/.config/hypr" "$USER_HOME/.config/hypr.backup.$(date +%Y%m%d)"
fi

# Clone the dotfiles
git clone --depth=1 https://github.com/JaKooLit/Hyprland-Dots.git /tmp/Hyprland-Dots
cp -r /tmp/Hyprland-Dots/config/* "$USER_HOME/.config/"
cp -r /tmp/Hyprland-Dots/Pictures "$USER_HOME/"
rm -rf /tmp/Hyprland-Dots

print_section "Configuring AMD Gaming Optimizations"
# Create AMD GPU optimization script
cat > "$USER_HOME/.local/bin/amd-gaming-opts" << 'EOF'
#!/bin/bash
# AMD RX 580 Gaming Optimizations

# Set AMD GPU power profile to high performance
echo "high" | sudo tee /sys/class/drm/card0/device/power_dpm_force_performance_level

# Enable GPU frequency scaling
echo "1" | sudo tee /sys/class/drm/card0/device/pp_power_profile_mode

# Set CPU governor to performance for gaming
echo "performance" | sudo tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor

# Enable FSYNC
export WINEFSYNC=1

# Vulkan optimizations
export VK_ICD_FILENAMES=/usr/share/vulkan/icd.d/radeon_icd.x86_64.json:/usr/share/vulkan/icd.d/radeon_icd.i686.json
export RADV_PERFTEST=aco

echo "AMD Gaming optimizations applied!"
EOF

chmod +x "$USER_HOME/.local/bin/amd-gaming-opts"

# Create Steam launch options helper
cat > "$USER_HOME/.local/bin/steam-launch-opts" << 'EOF'
#!/bin/bash
echo "Recommended Steam Launch Options for AMD RX 580:"
echo ""
echo "For Cyberpunk 2077:"
echo "gamemoderun mangohud RADV_PERFTEST=aco %command%"
echo ""
echo "For The Division 1/2:"
echo "gamemoderun DXVK_ASYNC=1 %command%"
echo ""
echo "For The First Descendant:"
echo "gamemoderun mangohud RADV_PERFTEST=aco DXVK_ASYNC=1 %command%"
echo ""
echo "General gaming:"
echo "gamemoderun mangohud %command%"
EOF

chmod +x "$USER_HOME/.local/bin/steam-launch-opts"

print_section "Setting up SDDM Theme"
# Configure SDDM with Sugar Candy theme
sudo mkdir -p /etc/sddm.conf.d
cat > /tmp/sddm.conf << 'EOF'
[Theme]
Current=sugar-candy

[Users]
MaximumUid=60513
MinimumUid=1000
EOF

sudo mv /tmp/sddm.conf /etc/sddm.conf.d/theme.conf
sudo systemctl enable sddm

print_section "Configuring Zsh & Terminal"
# Install oh-my-zsh
if [ ! -d "$USER_HOME/.oh-my-zsh" ]; then
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" --unattended
fi

# Set zsh as default shell
sudo chsh -s $(which zsh) "$USERNAME"

# Create custom zsh config
cat > "$USER_HOME/.zshrc" << 'EOF'
# WehttamSnaps Zsh Configuration
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"

plugins=(git sudo zsh-autosuggestions zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

# Aliases
alias ls='eza --icons'
alias ll='eza -la --icons'
alias cat='bat'
alias grep='ripgrep'

# Gaming shortcuts
alias steam-opts='steam-launch-opts'
alias amd-boost='amd-gaming-opts'

# Init starship prompt
eval "$(starship init zsh)"

# Neofetch on terminal start
neofetch
EOF

print_section "Creating Custom Waybar Configuration"
# Custom waybar config for WehttamSnaps
mkdir -p "$USER_HOME/.config/waybar"
cat > "$USER_HOME/.config/waybar/config.jsonc" << 'EOF'
{
    "layer": "top",
    "position": "top",
    "height": 35,
    "spacing": 4,
    "margin-top": 5,
    "margin-left": 10,
    "margin-right": 10,
    
    "modules-left": ["custom/arch", "hyprland/workspaces", "hyprland/window"],
    "modules-center": ["custom/spotify"],
    "modules-right": ["custom/pacman", "temperature", "memory", "cpu", "disk", "pulseaudio", "bluetooth", "network", "battery", "custom/power", "clock"],

    "custom/arch": {
        "format": " 󰣇 ",
        "tooltip": false,
        "on-click": "nwg-drawer"
    },
    
    "hyprland/workspaces": {
        "disable-scroll": true,
        "all-outputs": true,
        "format": "{icon}",
        "format-icons": {
            "1": "1",
            "2": "2", 
            "3": "3",
            "4": "4",
            "5": "5",
            "urgent": "",
            "focused": "",
            "default": ""
        }
    },
    
    "hyprland/window": {
        "format": "{}",
        "max-length": 50
    },

    "custom/spotify": {
        "format": " {}",
        "max-length": 40,
        "exec": "$HOME/.config/waybar/scripts/spotify.sh",
        "exec-if": "pgrep spotify",
        "interval": 1,
        "on-click": "playerctl play-pause",
        "on-scroll-up": "playerctl next",
        "on-scroll-down": "playerctl previous"
    },

    "custom/pacman": {
        "format": "󰏖 {}",
        "interval": 3600,
        "exec": "checkupdates | wc -l",
        "on-click": "alacritty -e sudo pacman -Syu"
    },

    "temperature": {
        "thermal-zone": 2,
        "hwmon-path": "/sys/class/hwmon/hwmon2/temp1_input",
        "critical-threshold": 80,
        "format-critical": "{temperatureC}°C ",
        "format": "{temperatureC}°C "
    },

    "memory": {
        "format": "󰍛 {used:0.1f}G"
    },

    "cpu": {
        "format": " {usage}%",
        "tooltip": false
    },

    "disk": {
        "interval": 30,
        "format": "󰋊 {percentage_used}%",
        "path": "/"
    },

    "pulseaudio": {
        "format": "{icon} {volume}%",
        "format-bluetooth": "{volume}% {icon}",
        "format-muted": "婢",
        "format-icons": {
            "headphone": "",
            "hands-free": "",
            "headset": "",
            "phone": "",
            "portable": "",
            "car": "",
            "default": ["", "", ""]
        },
        "on-click": "pavucontrol"
    },

    "bluetooth": {
        "format": "",
        "format-disabled": "",
        "on-click": "blueman-manager"
    },

    "network": {
        "format-wifi": "直 {essid}",
        "format-ethernet": " Wired",
        "format-disconnected": "睊",
        "on-click": "nm-connection-editor"
    },

    "custom/power": {
        "format": "⏻",
        "tooltip": false,
        "on-click": "wlogout"
    },

    "clock": {
        "format": " {:%H:%M}",
        "format-alt": " {:%A, %B %d, %Y (%R)}",
        "tooltip-format": "<tt><small>{calendar}</small></tt>",
        "calendar": {
            "mode": "year",
            "mode-mon-col": 3,
            "weeks-pos": "right",
            "on-scroll": 1,
            "format": {
                "months": "<span color='#ffead3'><b>{}</b></span>",
                "days": "<span color='#ecc6d9'><b>{}</b></span>",
                "weeks": "<span color='#99ffdd'><b>W{}</b></span>",
                "weekdays": "<span color='#ffcc66'><b>{}</b></span>",
                "today": "<span color='#ff6699'><b><u>{}</u></b></span>"
            }
        }
    }
}
EOF

print_section "Creating Game Launcher Widget"
mkdir -p "$USER_HOME/.config/eww"
cat > "$USER_HOME/.config/eww/game-launcher.yuck" << 'EOF'
(defwindow game-launcher
    :monitor 0
    :geometry (geometry :x "50%"
                        :y "50%"
                        :width "400px"
                        :height "300px"
                        :anchor "center")
    :stacking "overlay"
    :reserve (struts :distance "40px" :side "top")
    :windowtype "dialog"
    :wm-ignore false
    (box :class "game-launcher"
         :orientation "v"
         :space-evenly "true"
         :spacing 10
        (box :class "launcher-title"
             (label :text "🎮 WehttamSnaps Gaming"))
        (box :orientation "h"
             :space-evenly "true"
             :spacing 10
            (button :class "game-btn steam-btn"
                    :onclick "steam &"
                    (box :orientation "v"
                         :spacing 5
                        (label :class "game-icon" :text "")
                        (label :class "game-label" :text "Steam")))
            (button :class "game-btn lutris-btn"  
                    :onclick "lutris &"
                    (box :orientation "v"
                         :spacing 5
                        (label :class "game-icon" :text "🍷")
                        (label :class "game-label" :text "Lutris"))))
        (box :orientation "h"
             :space-evenly "true" 
             :spacing 10
            (button :class "game-btn heroic-btn"
                    :onclick "heroic &"
                    (box :orientation "v"
                         :spacing 5
                        (label :class "game-icon" :text "🚀")
                        (label :class "game-label" :text "Heroic")))
            (button :class "game-btn spotify-btn"
                    :onclick "spotify &"
                    (box :orientation "v" 
                         :spacing 5
                        (label :class "game-icon" :text "🎵")
                        (label :class "game-label" :text "Spotify"))))))
EOF

print_section "Setting File Permissions"
find "$USER_HOME/.config" -type f -name "*.sh" -exec chmod +x {} \;
mkdir -p "$USER_HOME/.local/bin"
export PATH="$PATH:$USER_HOME/.local/bin"

print_section "Creating WebApps"
# Create Photopea webapp
mkdir -p "$USER_HOME/.local/share/applications"
cat > "$USER_HOME/.local/share/applications/photopea.desktop" << 'EOF'
[Desktop Entry]
Version=1.0
Type=Application
Name=Photopea
Comment=Online Photo Editor
Exec=firefox --new-window --class=Photopea https://photopea.com
Icon=image-x-generic
Categories=Graphics;Photography;
StartupWMClass=Photopea
EOF

# Create Claude AI webapp
cat > "$USER_HOME/.local/share/applications/claude-ai.desktop" << 'EOF'
[Desktop Entry]
Version=1.0
Type=Application  
Name=Claude AI
Comment=AI Assistant
Exec=firefox --new-window --class=Claude https://claude.ai
Icon=applications-development
Categories=Development;Education;
StartupWMClass=Claude
EOF

print_section "Final Configuration Steps"
# Set proper ownership
sudo chown -R "$USERNAME:$USERNAME" "$USER_HOME/.config"
sudo chown -R "$USERNAME:$USERNAME" "$USER_HOME/.local"

# Enable zram for better gaming performance
echo 'zram' | sudo tee /etc/modules-load.d/zram.conf
echo 'ACTION=="add", KERNEL=="zram0", ATTR{disksize}="4G", RUN="/usr/bin/mkswap /dev/zram0", TAG+="systemd"' | sudo tee /etc/udev/rules.d/99-zram.rules

print_section "Setup Complete!"
echo -e "${GREEN}🎉 WehttamSnaps Hyprland Gaming Setup Complete!${NC}"
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${PURPLE}Next Steps:${NC}"
echo "1. Reboot your system: sudo reboot"
echo "2. Log in with SDDM and select Hyprland"
echo "3. Run 'steam-opts' in terminal for game launch options"
echo "4. Run 'amd-boost' before gaming for performance boost"
echo "5. Press Super+D to open app launcher"
echo "6. Press Super+G to open game launcher"
echo ""
echo -e "${GREEN}Happy Gaming and Streaming, WehttamSnaps! 🎮📸${NC}"
