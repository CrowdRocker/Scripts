# Matt's Arch Installation Guide
*Optimized for i5-4430 + RX 580 Gaming & Streaming Setup*

## 🎯 Phase 1: Base System Installation

### Archinstall Configuration
When running `archinstall`, use these settings:

```
Archinstall Menu Selections:
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Language: English
Keyboard layout: us (or your preference)
Mirror region: United States (or closest to you)

Disk configuration:
└── Use a best-effort default partition layout
    ├── Disk: /dev/sdX (your drive)
    ├── Filesystem: ext4 (reliable for gaming)
    └── Encryption: Optional (your choice)

Bootloader: Grub
Hostname: matty-gaming-rig (or preference)

Root password: [Set strong password]
User account: 
├── Username: matt (or preference)  
├── Password: [Set password]
└── Superuser: Yes

Profile: Minimal
Audio: PipeWire (if available, otherwise skip)
Kernels: linux
Network configuration: NetworkManager

Additional packages:
git vim nano base-devel firefox

Install: Yes
```

### Why These Choices:

**ext4 Filesystem**: 
- More stable for gaming than btrfs
- Better performance for large game files
- Easier recovery if needed

**Grub Bootloader**:
- Better compatibility with gaming
- Easier dual-boot if you want Windows later
- More recovery options

**NetworkManager**:
- GUI tools available later
- Better WiFi support
- Works well with Hyprland

**Minimal Profile**:
- No desktop environment conflicts
- Clean slate for our custom setup
- Faster boot times

---

## 🔧 Phase 2: Post-Install Essentials

### First Boot Setup
```bash
# After archinstall completes and you reboot:

# Update system first
sudo pacman -Syu

# Install yay (AUR helper) - Required for gaming packages
cd /tmp
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si --noconfirm
cd ~

# Install essential graphics drivers
sudo pacman -S --noconfirm \
    xorg-server \
    mesa lib32-mesa \
    vulkan-radeon lib32-vulkan-radeon \
    xf86-video-amdgpu \
    mesa-vdpau lib32-mesa-vdpau

# Test graphics are working
glxinfo | grep "OpenGL renderer"
vulkaninfo --summary
```

### Verify Hardware Detection
```bash
# Check GPU detection
lspci | grep VGA
# Should show: Advanced Micro Devices, Inc. [AMD/ATI] Ellesmere [Radeon RX 470/480/570/570X/580/580X/590]

# Check CPU detection  
lscpu | grep "Model name"
# Should show: Intel(R) Core(TM) i5-4430 CPU @ 3.00GHz

# Check memory
free -h
# Should show your 16GB RAM

# Check audio devices
aplay -l
```

---

## 🎮 Phase 3: Run Custom Setup Script

Now use the comprehensive setup script I created earlier:

```bash
# Download and run the setup script
wget [script-location] -O hyprland-setup.sh
chmod +x hyprland-setup.sh
./hyprland-setup.sh
```

**What the script handles:**
- Complete Hyprland installation with TokyoNight theme
- All gaming optimizations (GameMode, MangoHUD, etc.)  
- Streaming setup (OBS, PipeWire, etc.)
- Development tools and customization
- AMD-specific performance tweaks
- Welcome app and system tools

---

## ⚙️ Phase 4: Hardware-Specific Optimizations

### AMD GPU Optimizations
```bash
# Add to /etc/environment after base install
echo 'RADV_PERFTEST=aco,sam' | sudo tee -a /etc/environment
echo 'AMD_VULKAN_ICD=RADV' | sudo tee -a /etc/environment
echo 'mesa_glthread=true' | sudo tee -a /etc/environment

# Enable early KMS for smoother boot
echo 'MODULES=(amdgpu)' | sudo tee -a /etc/mkinitcpio.conf
sudo mkinitcpio -P
```

### CPU Performance Tuning
```bash
# Install CPU power management
sudo pacman -S cpupower

# Set performance governor for gaming
echo 'GOVERNOR="performance"' | sudo tee /etc/default/cpupower
sudo systemctl enable cpupower.service
```

### Gaming-Specific Kernel Parameters
```bash
# Edit GRUB configuration
sudo nano /etc/default/grub

# Add to GRUB_CMDLINE_LINUX:
GRUB_CMDLINE_LINUX="amd_pstate=active mitigations=off processor.max_cstate=1"

# Regenerate GRUB config
sudo grub-mkconfig -o /boot/grub/grub.cfg
```

---

## 🔊 Phase 5: Audio Setup (Critical for Streaming)

### PipeWire Configuration
```bash
# Install complete PipeWire stack
sudo pacman -S --noconfirm \
    pipewire pipewire-pulse pipewire-jack pipewire-alsa \
    wireplumber pavucontrol alsa-utils

# Enable PipeWire services
systemctl --user enable pipewire pipewire-pulse wireplumber
systemctl --user start pipewire pipewire-pulse wireplumber

# Test audio
speaker-test -c 2
```

### Audio Optimization for Streaming
```bash
# Create PipeWire config directory
mkdir -p ~/.config/pipewire

# Optimize for low-latency gaming and streaming
cat > ~/.config/pipewire/pipewire.conf << 'EOF'
context.properties = {
    default.clock.rate = 48000
    default.clock.quantum = 512
    default.clock.min-quantum = 256
    default.clock.max-quantum = 2048
}
EOF
```

---

## 🖥️ Phase 6: Display Configuration

### Display Manager Setup
```bash
# Install SDDM with TokyoNight theme
sudo pacman -S sddm
yay -S sddm-sugar-candy-git

# Configure SDDM
sudo systemctl enable sddm

# Set up display manager theme (done by main script)
```

### Monitor Optimization
```bash
# For single 1080p monitor (adjust as needed)
# This goes in your Hyprland config:
monitor=,1920x1080@60,0x0,1

# For higher refresh rate if supported:
# monitor=,1920x1080@75,0x0,1
```

---

## 🎯 Phase 7: Gaming-Specific Setup

### Steam Installation & Configuration
```bash
# Enable multilib repository first
sudo nano /etc/pacman.conf
# Uncomment:
# [multilib]
# Include = /etc/pacman.d/mirrorlist

sudo pacman -Syu

# Install gaming essentials (done by main script)
sudo pacman -S steam lutris gamemode mangohud

# Configure Steam for Hyprland
echo 'export STEAM_COMPAT_MOUNTS=/home' >> ~/.bashrc
echo 'export STEAM_COMPAT_CLIENT_INSTALL_PATH=$HOME/.local/share/Steam' >> ~/.bashrc
```

### Game-Specific Directories
```bash
# Create organized game directories
mkdir -p ~/Games/{Steam,Lutris,Heroic,Emulation}
mkdir -p ~/Games/Screenshots
mkdir -p ~/Games/Recordings

# Link to common locations
ln -sf ~/Games/Screenshots ~/.local/share/Steam/screenshots
```

---

## 📊 Phase 8: Performance Verification

### System Performance Test
```bash
# CPU benchmark
sysbench cpu --cpu-max-prime=20000 run

# Memory bandwidth test  
sysbench memory --memory-block-size=1M --memory-total-size=10G run

# GPU test
glxgears -info

# Gaming performance test
mangohud glxgears
```

### Expected Performance Baseline
```
Target Performance (1080p):
- Desktop: Smooth 60fps with effects
- Gaming: 60-90fps depending on game/settings
- Streaming: 10-15% performance impact max

Memory Usage:
- Idle: 1.5-2GB RAM usage
- Gaming: 4-8GB depending on game
- Streaming: Additional 1-2GB for OBS

Temperatures:
- CPU idle: 35-45°C
- CPU gaming: 55-70°C  
- GPU idle: 40-50°C
- GPU gaming: 65-80°C
```

---

## 🔧 Phase 9: Troubleshooting Common Issues

### Boot Issues
```bash
# If you get black screen after GPU driver install:
# Boot with kernel parameter: amdgpu.dc=0
# Then rebuild initramfs: sudo mkinitcpio -P

# If Hyprland won't start:
# Check logs: journalctl -u display-manager
# Try starting manually: Hyprland
```

### Audio Issues
```bash
# No audio device detected:
sudo alsa-info --upload

# Audio crackling/popping:
echo 'default-sample-rate = 48000' >> ~/.config/pipewire/pipewire.conf
systemctl --user restart pipewire
```

### Gaming Issues
```bash
# Steam games won't launch:
# Check Proton version, try different versions
# Verify game files in Steam
# Check launch options

# Poor gaming performance:
# Verify GPU drivers: glxinfo | grep renderer
# Check if gamemode is running: pgrep gamemode
# Monitor temps: sensors
```

---

## 📋 Installation Checklist

### Pre-Installation
- [ ] Backup important data
- [ ] Create Arch installation media  
- [ ] Verify hardware compatibility
- [ ] Note down WiFi credentials if needed

### Base Installation  
- [ ] Boot from installation media
- [ ] Run archinstall with recommended settings
- [ ] Set up user account with sudo privileges
- [ ] Reboot and verify basic functionality

### Graphics & Drivers
- [ ] Install AMD graphics drivers
- [ ] Verify OpenGL and Vulkan work
- [ ] Test display output and resolution
- [ ] Configure early KMS if needed

### Audio Setup
- [ ] Install PipeWire stack
- [ ] Test audio playback
- [ ] Configure for low-latency
- [ ] Verify microphone input

### Gaming Environment
- [ ] Run comprehensive setup script
- [ ] Install Steam and test game launch
- [ ] Configure MangoHUD overlay
- [ ] Set up GameMode optimization

### Hyprland Desktop
- [ ] Verify Hyprland starts correctly
- [ ] Test window management and workspaces
- [ ] Configure waybar and rofi
- [ ] Apply TokyoNight theme

### Streaming Setup
- [ ] Configure OBS with scenes
- [ ] Test video/audio capture
- [ ] Verify hardware encoding works
- [ ] Set up stream overlays

### Final Verification
- [ ] Test complete gaming workflow
- [ ] Verify streaming functionality  
- [ ] Check system performance metrics
- [ ] Create system backup/snapshot

---

## 🚀 Pro Tips for Success

### Installation Day Strategy
1. **Dedicate Full Day**: Don't rush the installation
2. **Stable Internet**: Ensure reliable connection for downloads
3. **Backup Plan**: Keep Windows USB handy just in case
4. **Document Issues**: Note any problems for troubleshooting

### First Week Goals
1. **Test Everything**: All games, OBS, hardware
2. **Backup Configs**: Save working configurations  
3. **Performance Baseline**: Document FPS in your main games
4. **Streaming Test**: Do test streams with friends

### Long-term Success
1. **Regular Updates**: Weekly system updates
2. **Config Management**: Use git for dotfiles
3. **Performance Monitoring**: Track system health
4. **Community Engagement**: Join Arch/Hyprland communities

---

**Remember**: This approach gives you maximum control and understanding of your system, which is crucial for gaming performance and streaming reliability. The base install is minimal, but our setup script transforms it into the perfect gaming/streaming workstation! 🎮📺
