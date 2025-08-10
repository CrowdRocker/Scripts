#!/bin/bash
# Fedora Everything -> Hyprland Gaming Setup Script
# Run this after fresh Fedora Everything minimal install

set -e  # Exit on any error

echo "=== Fedora Hyprland Gaming Setup ==="
echo "This script will install Hyprland and gaming essentials"
echo "Press Enter to continue or Ctrl+C to abort"
read

# Update system first
echo "=== Updating System ==="
sudo dnf update -y

# Enable RPM Fusion repositories (needed for Steam, drivers, codecs)
echo "=== Enabling RPM Fusion ==="
sudo dnf install -y https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm
sudo dnf install -y https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

# Install basic system tools
echo "=== Installing Basic System Tools ==="
sudo dnf install -y \
    wget curl git vim nano htop btop \
    unzip zip tar gzip \
    NetworkManager-wifi wpa_supplicant \
    firefox

# Install Hyprland and Wayland essentials
echo "=== Installing Hyprland and Wayland ==="
sudo dnf install -y \
    hyprland \
    waybar \
    wofi rofi-wayland \
    swaylock-effects \
    wlogout \
    mako \
    grim slurp \
    wl-clipboard \
    polkit-gnome \
    xdg-desktop-portal-hyprland \
    qt5-qtwayland qt6-qtwayland

# Install SDDM (Display Manager)
echo "=== Installing SDDM ==="
sudo dnf install -y sddm
sudo systemctl enable sddm

# Install PipeWire Audio
echo "=== Installing PipeWire Audio ==="
sudo dnf install -y \
    pipewire \
    pipewire-alsa \
    pipewire-pulseaudio \
    pipewire-jack-audio-connection-kit \
    wireplumber \
    pavucontrol \
    alsa-utils

# Enable PipeWire services
systemctl --user enable pipewire pipewire-pulse wireplumber

# Install AMD GPU drivers and Vulkan
echo "=== Installing AMD Graphics Drivers ==="
sudo dnf install -y \
    mesa-dri-drivers \
    mesa-vulkan-drivers \
    vulkan-tools \
    mesa-vdpau-drivers \
    mesa-va-drivers

# Install gaming essentials
echo "=== Installing Gaming Tools ==="
sudo dnf install -y \
    steam \
    lutris \
    wine \
    gamemode \
    mangohud \
    goverlay

# Install media codecs
echo "=== Installing Media Codecs ==="
sudo dnf install -y \
    gstreamer1-plugins-{bad-\*,good-\*,base} \
    gstreamer1-plugin-openh264 \
    gstreamer1-libav \
    lame\* \
    --exclude=gstreamer1-plugins-bad-free-devel

sudo dnf install -y \
    gstreamer1-plugins-{bad-\*,good-\*,ugly-\*,base} \
    gstreamer1-plugin-openh264 \
    gstreamer1-libav \
    --exclude=gstreamer1-plugins-bad-free-devel

sudo dnf install -y \
    gstreamer1-plugins-ugly-free \
    mozilla-openh264

# Install fonts
echo "=== Installing Fonts ==="
sudo dnf install -y \
    google-noto-fonts \
    google-noto-emoji-fonts \
    fira-code-fonts \
    liberation-fonts

# Install file manager and basic GUI apps
echo "=== Installing Basic GUI Applications ==="
sudo dnf install -y \
    thunar \
    thunar-archive-plugin \
    thunar-volman \
    gvfs \
    gvfs-mtp \
    gvfs-gphoto2 \
    tumbler \
    kitty \
    mpv

# Create basic Hyprland config directory
echo "=== Setting up Hyprland config directory ==="
mkdir -p ~/.config/hypr
mkdir -p ~/.config/waybar
mkdir -p ~/.config/wofi
mkdir -p ~/.config/mako
mkdir -p ~/.config/kitty

# Enable gamemode service
sudo systemctl enable --now power-profiles-daemon

echo "=== Installation Complete! ==="
echo ""
echo "Next steps:"
echo "1. Reboot your system"
echo "2. Log into Hyprland via SDDM"
echo "3. Configure Hyprland (see configuration checklist)"
echo "4. Install The First Descendant to your SSD!"
echo ""
echo "Reboot now? (y/N)"
read -r response
if [[ "$response" =~ ^[Yy]$ ]]; then
    sudo reboot
fi
