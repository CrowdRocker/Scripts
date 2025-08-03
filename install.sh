#!/bin/bash
#
# ████████╗ ██████╗ ██╗  ██╗██╗   ██╗     ██╗███╗   ██╗██╗   ██╗
# ╚══██╔══╝██╔═══██╗██║  ██║╚██╗ ██╔╝     ██║████╗  ██║╚██╗ ██╔╝
#    ██║   ██║   ██║███████║ ╚████╔╝      ██║██╔██╗ ██║ ╚████╔╝
#    ██║   ██║   ██║██╔══██║  ╚██╔╝       ██║██║╚██╗██║  ╚██╔╝
#    ██║   ╚██████╔╝██║  ██║   ██║        ██║██║ ╚████║   ██║
#    ╚═╝    ╚═════╝ ╚═╝  ╚═╝   ╚═╝        ╚═╝╚═╝  ╚═══╝   ╚═╝
# TokyoNight on SwayFX - Install Script for Matt (Crowdrocker)
#

set -e # Exit immediately if a command exits with a non-zero status.

echo "================================================================="
echo " Starting TokyoNight SwayFX Setup for Matt (Crowdrocker) "
echo "================================================================="

#-------------------------------------------------------------------------
# SCRIPT-WIDE VARIABLES
#-------------------------------------------------------------------------
# List of official repository packages
PACMAN_PACKAGES=(
    # --- Core Wayland & SwayFX ---
    "swaybg"
    "waybar"
    "rofi" # Can be used as a backup/alternative to fuzzel
    "fuzzel"
    "mako" # Notification daemon (alternative to dunst)
    "dunst"
    "sddm"
    "qt5-graphicaleffects" "qt5-quickcontrols2" "qt5-svg" # For SDDM theme
    "polkit-kde-agent" # For authentication dialogs
    "azote" # Wallpaper manager
    "nwg-look" # To set GTK themes

    # --- File Manager & Terminal ---
    "thunar" "thunar-volman" "gvfs"
    "xfce4-terminal"

    # --- Audio ---
    "pipewire" "pipewire-pulse" "pipewire-jack" "wireplumber" "pavucontrol"

    # --- Performance & Gaming ---
    "gamemode" "gamescope" "mangohud" "steam" "lutris"
    "vulkan-radeon" "lib32-vulkan-radeon" # AMD Vulkan drivers
    "libva-mesa-driver" "lib32-libva-mesa-driver" # Video acceleration
    
    # --- System Utilities ---
    "zsh"
    "btop" "htop"
    "fastfetch" "neofetch"
    "starship"
    "pacman-contrib" # For `checkupdates` script in waybar
    "bluez" "bluez-utils" # Bluetooth
    "brightnessctl"
    
    # --- Fonts ---
    "ttf-jetbrains-mono-nerd" # A good Nerd Font for icons
    "noto-fonts-emoji"
)

# List of AUR packages
AUR_PACKAGES=(
    "swayfx-git" # The star of the show
    "eww-wayland" # The Elkowars Wacky Widgets
    "sddm-theme-sugarcandy-git" # SDDM theme
    "nwg-drawer" # App drawer for Waybar
    "autotiling" # Automatic tiling for sway
    "systemd-zram-generator" # For easy ZRAM setup
)

#-------------------------------------------------------------------------
# FUNCTION DEFINITIONS
#-------------------------------------------------------------------------

# Function to install yay (AUR Helper)
install_yay() {
    if ! command -v yay &> /dev/null; then
        echo "-----------------------------------------------------"
        echo "-> Installing AUR Helper (yay)..."
        echo "-----------------------------------------------------"
        sudo pacman -S --needed --noconfirm git base-devel
        git clone https://aur.archlinux.org/yay.git
        (cd yay && makepkg -si --noconfirm)
        rm -rf yay
        echo "-> yay installed."
    else
        echo "-> yay is already installed."
    fi
}

# Function to install packages
install_packages() {
    echo "-----------------------------------------------------"
    echo "-> Installing official repository packages..."
    echo "-----------------------------------------------------"
    sudo pacman -Syu --needed --noconfirm "${PACMAN_PACKAGES[@]}"
    
    echo "-----------------------------------------------------"
    echo "-> Installing AUR packages with yay..."
    echo "-----------------------------------------------------"
    yay -S --needed --noconfirm "${AUR_PACKAGES[@]}"
}

# Function to enable system services
enable_services() {
    echo "-----------------------------------------------------"
    echo "-> Enabling essential system services..."
    echo "-----------------------------------------------------"
    sudo systemctl enable sddm.service
    sudo systemctl enable NetworkManager.service
    sudo systemctl enable bluetooth.service
    sudo systemctl enable gamemoded.service
    echo "-> Services enabled."
}

# Function to set up Zsh and Starship
setup_shell() {
    echo "-----------------------------------------------------"
    echo "-> Setting up Zsh and Starship prompt..."
    echo "-----------------------------------------------------"
    if [ -f "$HOME/.zshrc" ]; then
        echo "~/.zshrc already exists. Backing up to ~/.zshrc.bak"
        mv "$HOME/.zshrc" "$HOME/.zshrc.bak"
    fi
    # Set Zsh as default shell for the current user
    chsh -s $(which zsh)
    # Create a basic .zshrc to source starship
    echo 'eval "$(starship init zsh)"' >> "$HOME/.zshrc"
    echo "-> Zsh with Starship is now configured."
}


#-------------------------------------------------------------------------
# SCRIPT EXECUTION
#-------------------------------------------------------------------------

main() {
    install_yay
    install_packages
    enable_services
    setup_shell
    
    echo "================================================================="
    echo " ✅ Installation Complete!"
    echo "================================================================="
    echo " "
    echo "下一步 (Next Steps):"
    echo "1. Clone your dotfiles repository into your home directory."
    echo "   git clone https://github.com/Crowdrocker/dotfiles.git ~"
    echo "2. The script has enabled SDDM. Please REBOOT your system now."
    echo "   sudo reboot"
    echo " "
}

# Run the main function
main
