# WehttamSnaps Gaming Optimization Guide
*Ultimate Linux gaming setup for AMD RX 580 with Hyprland*

## 🎮 Steam Launch Options

### The Division 2
```bash
gamemoderun mangohud DXVK_ASYNC=1 DXVK_FRAME_RATE=60 %command%
```
**Why these settings:**
- `gamemoderun`: Optimizes CPU/GPU for gaming
- `mangohud`: Shows FPS, GPU/CPU usage overlay
- `DXVK_ASYNC=1`: Reduces stuttering in DirectX games
- `DXVK_FRAME_RATE=60`: Caps frame rate for stable performance

### The Division 1
```bash
gamemoderun DXVK_ASYNC=1 RADV_PERFTEST=aco %command%
```
**Why these settings:**
- `RADV_PERFTEST=aco`: Uses AMD's faster shader compiler
- Works well with older DirectX 11 games

### Cyberpunk 2077
```bash
gamemoderun mangohud RADV_PERFTEST=aco DXVK_ASYNC=1 VKD3D_CONFIG=dxr %command%
```
**Why these settings:**
- `VKD3D_CONFIG=dxr`: Better DirectX 12 compatibility
- Essential for modern AAA games

### The First Descendant
```bash
gamemoderun mangohud RADV_PERFTEST=aco DXVK_ASYNC=1 DXVK_HUD=fps %command%
```
**Why these settings:**
- `DXVK_HUD=fps`: Lightweight FPS counter
- Good for competitive online games

## 🚀 System Optimization Commands

### Before Gaming Session
```bash
# Run the AMD optimization script
amd-gaming-opts

# Enable gaming + streaming mode (if streaming)
gaming-stream-mode

# Manual CPU boost
sudo cpupower frequency-set -g performance
```

### In-Game Performance Monitoring
```bash
# Show detailed system info
mangohud steam

# Monitor temperatures while gaming  
watch sensors

# Check GPU usage
watch -n 1 'cat /sys/class/drm/card0/device/gpu_busy_percent'
```

## ⚙️ AMD RX 580 Specific Optimizations

### GPU Settings
```bash
# Set GPU to maximum performance
echo "high" | sudo tee /sys/class/drm/card0/device/power_dpm_force_performance_level

# Enable GPU overclocking (advanced users)
echo "manual" | sudo tee /sys/class/drm/card0/device/power_dpm_force_performance_level
echo "s 7 1100" | sudo tee /sys/class/drm/card0/device/pp_od_clk_voltage
echo "c" | sudo tee /sys/class/drm/card0/device/pp_od_clk_voltage
```

### Memory Optimization
```bash
# Enable ZRAM for better performance
sudo modprobe zram num_devices=1
echo lz4 | sudo tee /sys/block/zram0/comp_algorithm
echo 4G | sudo tee /sys/block/zram0/disksize
sudo mkswap /dev/zram0
sudo swapon /dev/zram0
```

## 🎯 Game-Specific Tweaks

### Cyberpunk 2077 Optimization
- **Graphics Settings**: Medium-High preset
- **Ray Tracing**: OFF (RX 580 doesn't support it well)
- **DLSS Alternative**: Use FSR (AMD FidelityFX Super Resolution)
- **Resolution**: 1920x1080 for 60fps, 1600x900 for higher frame rates

### The Division 2 Optimization  
- **Graphics Settings**: High preset
- **Volumetric Fog**: Medium
- **Particle Detail**: Medium  
- **Expected Performance**: 45-60 FPS at 1080p

### The First Descendant Optimization
- **Graphics Settings**: Medium-High
- **Anti-Aliasing**: TAA
- **Texture Quality**: High
- **Expected Performance**: 50-70 FPS at 1080p

## 📊 Performance Monitoring Setup

### MangoHud Configuration
Create `~/.config/MangoHud/MangoHud.conf`:
```ini
# WehttamSnaps MangoHud Config
fps_limit=0
vsync=0
gl_vsync=0

# Display Settings
position=top-right
font_size=20
text_color=FFFFFF
background_alpha=0.4

# Metrics to Show
fps
frametime
gpu_temp
gpu_core_clock
gpu_mem_clock
gpu_power
gpu_text=RX580
cpu_temp
cpu_power
cpu_text=i5-4430
ram
vram

# Graph
fps_graph
histogram

# Logging for performance analysis
log_duration=60
autostart_log=1
log_file=/home/wehttamsnaps/mangohud_logs/performance
```

### Temperature Monitoring
```bash
# Install and configure sensors
sudo sensors-detect
sensors

# AMD GPU temperature specifically  
watch -n 1 'sensors | grep "temp1"'
```

## 🎮 Gamemode Configuration
Create `~/.config/gamemode.ini`:
```ini
[general]
renice=10
ioprio=1
inhibit_screensaver=1
desiredgov=performance

[gpu]
apply_gpu_optimisations=accept-responsibility
amd_performance_level=high

[custom]
start=notify-send "GameMode: ON" "Optimizations activated"
end=notify-send "GameMode: OFF" "Back to normal performance"
```

## 🌡️ Thermal Management

### Keep Your RX 580 Cool
```bash
# Check fan curves
sudo pwmconfig

# Manual fan control (if needed)
echo 1 | sudo tee /sys/class/hwmon/hwmon*/pwm1_enable
echo 200 | sudo tee /sys/class/hwmon/hwmon*/pwm1  # 78% fan speed
```

### CPU Thermal Throttling Prevention
```bash
# Monitor CPU temperature
watch -n 1 'cat /sys/class/thermal/thermal_zone*/temp'

# Set aggressive CPU fan curve in BIOS
# Target: Keep CPU under 75°C while gaming
```

## 📈 Performance Targets (1080p)

### Expected FPS with RX 580 + i5-4430:

| Game | Settings | Target FPS | Streaming FPS |
|------|----------|------------|---------------|
| The Division 2 | High | 45-60 | 35-50 |
| The Division 1 | Ultra | 60-75 | 50-65 |
| Cyberpunk 2077 | Medium | 35-50 | 30-45 |
| The First Descendant | High | 50-70 | 40-55 |

## 🎬 Streaming Optimizations

### When Streaming + Gaming
```bash
# Use these launch options for streaming
gamemoderun mangohud DXVK_FRAME_RATE=45 %command%

# Limit game FPS to reserve resources for OBS
# Cap at 45 FPS instead of 60 when streaming
```

### OBS Settings for RX 580
- **Encoder**: x264 (software encoding)
- **Rate Control**: CBR
- **Bitrate**: 2500-3500 kbps for Twitch
- **Keyframe Interval**: 2 seconds
- **CPU Usage Preset**: veryfast (for streaming)
- **Profile**: main
- **Tune**: zerolatency

## 🔧 Troubleshooting Common Issues

### Low FPS Solutions
1. Check if GPU is being used: `watch -n 1 radeontop`
2. Verify gamemode is active: `gamemoded -s`
3. Check for thermal throttling: `sensors`
4. Disable compositor: `hyprctl dispatch exec "killall waybar"`

### Stuttering Solutions
1. Enable DXVK_ASYNC in launch options
2. Increase VRAM allocation: `echo "512M" | sudo tee /sys/kernel/mm/hugepages/hugepages-2048kB/nr_hugepages`
3. Use Gamemode: `gamemoderun %command%`

### Audio Issues
1. Check PipeWire status: `systemctl --user status pipewire`
2. Restart audio: `systemctl --user restart pipewire`
3. Use Pulse for game audio: `pavucontrol`

## 📝 Quick Reference Commands

```bash
# Performance monitoring
htop                    # CPU usage
radeontop              # GPU usage  
sensors                # Temperatures
mangohud steam         # Gaming overlay

# Optimization
amd-gaming-opts        # AMD optimization script
gaming-stream-mode     # Gaming + streaming mode
obs-optimize          # OBS optimization

# Steam commands
steam-opts             # Show launch options
steam -console         # Steam with console for debugging
```

## 🎯 Pro Tips for WehttamSnaps

1. **Stream Quality vs Performance**: When streaming, limit game FPS to 45 to maintain 30 FPS stream
2. **Temperature Management**: Your RX 580 performs best under 80°C
3. **Memory Usage**: Close unnecessary browsers/apps while gaming  
4. **Recording**: Use hardware encoding when possible to save CPU for games
5. **Scene Switching**: Use the F1-F7 hotkeys for quick OBS scene transitions

---

*Happy Gaming and Streaming! 🎮📸*
*Follow @WehttamSnaps on Twitch for live gaming and photography content!*
