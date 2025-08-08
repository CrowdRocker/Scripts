# Fedora Gaming Setup Guide

## 1. Fresh Fedora Install
1. Download Fedora Workstation 40/41
2. Create bootable USB with Fedora Media Writer
3. Install with default settings (ensure you have enough disk space)

## 2. Initial System Setup

### Enable RPM Fusion Repositories
```bash
# Free and Non-free repositories
sudo dnf install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

# Update system
sudo dnf update -y
```

### Install Essential Codecs and Drivers
```bash
# Multimedia codecs
sudo dnf swap ffmpeg-free ffmpeg --allowerasing
sudo dnf groupupdate multimedia --setop="install_weak_deps=False" --exclude=PackageKit-gstreamer-plugin
sudo dnf groupupdate sound-and-video

# AMD GPU drivers (already included but ensure latest Mesa)
sudo dnf install mesa-dri-drivers mesa-vulkan-drivers mesa-vdpau-drivers mesa-va-drivers
```

## 3. Gaming Setup

### Install Gaming Platforms
```bash
# Steam (Flatpak recommended for better sandboxing)
flatpak install flathub com.valvesoftware.Steam

# Lutris
sudo dnf install lutris

# Heroic Games Launcher
flatpak install flathub com.heroicgameslauncher.hgl

# Bottles (for Windows apps)
flatpak install flathub com.usebottles.bottles
```

### Gaming Dependencies
```bash
# Wine and dependencies
sudo dnf install wine winetricks

# GameMode for performance
sudo dnf install gamemode

# MangoHud for performance overlay
sudo dnf install mangohud

# Gamepad support
sudo dnf install steam-devices
```

## 4. JaKoolit Hyprland Setup

### Prerequisites
```bash
# Install git and development tools
sudo dnf groupinstall "Development Tools"
sudo dnf install git curl wget

# Clone JaKoolit's Hyprland setup
git clone --depth=1 https://github.com/JaKooLit/Fedora-Hyprland.git ~/Fedora-Hyprland
cd ~/Fedora-Hyprland
chmod +x install.sh
./install.sh
```

### Run Installation
```bash
# Make script executable
chmod +x install.sh

# Run the installer (will ask for customization options)
./install.sh
```

## 5. Post-Installation Gaming Optimization

### Steam Configuration
1. Open Steam → Settings → Steam Play
2. Enable "Enable Steam Play for supported titles"
3. Enable "Enable Steam Play for all other titles" 
4. Select Proton Experimental as default

### Game-Specific Launch Options
```bash
# General gaming launch option
gamemoderun mangohud %command%

# For Cyberpunk 2077
gamemoderun mangohud %command% -USEALLAVAILABLECORES

# For Division games (if needed)
PROTON_USE_WINE3D=1 gamemoderun mangohud %command%

# For The First Descendant
gamemoderun mangohud %command%
```

### Hyprland Gaming Rules
Add to `~/.config/hypr/hyprland.conf`:
```bash
# Gaming optimizations
windowrulev2 = immediate, class:^(steam_app_).*
windowrulev2 = fullscreen, class:^(steam_app_).*
windowrulev2 = noborder, class:^(steam_app_).*
windowrulev2 = noshadow, class:^(steam_app_).*

# Disable animations for games
windowrulev2 = noanim, class:^(steam_app_).*

# GameMode daemon
exec-once = gamemoded
```

## 6. OBS Studio Setup
```bash
# Install OBS Studio
sudo dnf install obs-studio

# OBS plugins for better streaming
sudo dnf install obs-studio-plugin-browser
sudo dnf install obs-studio-plugin-vlc-video-source
```

## 7. Additional Streaming Tools
```bash
# Spotify
flatpak install flathub com.spotify.Client

# Discord
flatpak install flathub com.discordapp.Discord

# GIMP for overlay editing
sudo dnf install gimp
```

## 8. Performance Tuning

### CPU Governor
```bash
# Install power profiles daemon
sudo dnf install power-profiles-daemon

# Set performance mode for gaming
powerprofilesctl set performance
```

### System Limits
Add to `/etc/security/limits.conf`:
```
@games soft nofile 1048576
@games hard nofile 1048576
```

## 9. Troubleshooting Tips

### If games don't launch:
1. Check Proton logs: `~/.steam/logs/`
2. Try different Proton versions
3. Verify game files in Steam
4. Check ProtonDB for game-specific fixes

### Performance issues:
1. Use MangoHud to monitor temps/usage
2. Ensure GameMode is active
3. Close unnecessary background apps
4. Check if compositor effects are disabled during gaming

## Next Steps
- Fork JaKoolit's repo for your customizations
- Set up EWW widgets for game launcher
- Configure OBS scenes and overlays
- Test your favorite games
