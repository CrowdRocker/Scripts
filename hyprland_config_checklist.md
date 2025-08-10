# Hyprland Post-Installation Configuration Checklist

## After First Boot into Hyprland

### 1. Basic Hyprland Configuration
Create `~/.config/hypr/hyprland.conf`:
```bash
# Copy example config as starting point
cp /usr/share/hyprland/hyprland.conf ~/.config/hypr/hyprland.conf
```

**Key settings to configure:**
- Monitor setup (resolution, refresh rate)
- Input devices (keyboard, mouse sensitivity)
- Startup applications
- Keybindings for your workflow

### 2. Audio Setup
```bash
# Test audio is working
aplay /usr/share/sounds/alsa/Front_Left.wav

# Start PipeWire services if not running
systemctl --user start pipewire pipewire-pulse wireplumber
```

### 3. Gaming Optimizations

**Enable gamemode for Steam games:**
- Right-click game in Steam → Properties → Launch Options
- Add: `gamemoderun %command%`

**MangoHUD for performance overlay:**
- Add to Steam launch options: `mangohud %command%`
- Or combine: `gamemoderun mangohud %command%`

**Test Vulkan is working:**
```bash
vulkaninfo | head -20
```

### 4. Essential Keybindings to Set
Add these to your Hyprland config:
- Terminal: `SUPER + Return`
- App launcher: `SUPER + D`  
- File manager: `SUPER + E`
- Screenshot: `SUPER + SHIFT + S`
- Lock screen: `SUPER + L`

### 5. Steam Setup
1. Launch Steam
2. Enable Proton for Windows games:
   - Steam → Settings → Steam Play
   - Enable "Enable Steam Play for all other titles"
   - Select latest Proton version
3. Install The First Descendant to your SSD!

### 6. System Monitoring Tools
```bash
# Install additional monitoring tools
sudo dnf install nvtop radeontop

# Check GPU usage
radeontop

# Monitor system resources  
btop
```

### 7. Performance Tuning for RX 580

**Set GPU power profile:**
```bash
# Check current profile
cat /sys/class/drm/card*/device/power_dpm_force_performance_level

# Set to high performance (optional)
echo "high" | sudo tee /sys/class/drm/card*/device/power_dpm_force_performance_level
```

### 8. Backup Your Configuration
```bash
# Create backup of working configs
mkdir ~/hyprland-backup
cp -r ~/.config/hypr ~/hyprland-backup/
cp -r ~/.config/waybar ~/hyprland-backup/
cp -r ~/.config/wofi ~/hyprland-backup/
```

## Troubleshooting Common Issues

### If Steam doesn't start:
```bash
# Install 32-bit libraries
sudo dnf install steam
steam --reset  # Reset Steam if issues
```

### If games have poor performance:
1. Check `mangohud` output for bottlenecks
2. Verify gamemode is active: `gamemoded -s`
3. Check GPU clocks with `radeontop`
4. Ensure game is using dedicated GPU, not integrated

### If audio doesn't work:
```bash
# Restart PipeWire
systemctl --user restart pipewire pipewire-pulse wireplumber

# Check audio devices
pactl list short sinks
```

### If Hyprland crashes:
- Check logs: `journalctl -xeu sddm`
- Try basic config from `/usr/share/hyprland/hyprland.conf`

## Quick Commands Reference

**System Info:**
- `neofetch` - System overview
- `lspci | grep VGA` - Graphics card info
- `free -h` - Memory usage
- `df -h` - Disk usage

**Gaming:**
- `steam` - Launch Steam
- `lutris` - Launch Lutris for non-Steam games  
- `mangohud glxgears` - Test MangoHUD overlay
- `gamemoded -s` - Check if gamemode daemon is running

**Hyprland:**
- `SUPER + Q` - Close window (default)
- `SUPER + M` - Exit Hyprland
- `hyprctl reload` - Reload config
- `hyprctl monitors` - List monitors
