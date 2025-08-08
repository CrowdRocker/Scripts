# DaVinci Resolve Installation Guide for Fedora

## Method 1: Automated Script (Recommended)

### Step 1: Download DaVinci Resolve
1. Go to [BlackMagic Design website](https://www.blackmagicdesign.com/products/davinciresolve)
2. Create a free account if you don't have one
3. Download **DaVinci Resolve 19** (free version) - Linux version
4. Save the .zip file to your Downloads folder

### Step 2: Install Prerequisites
```bash
# Update system first
sudo dnf update -y

# Install essential dependencies
sudo dnf install -y \
    mesa-libOpenCL \
    apr apr-util \
    mesa-dri-drivers \
    mesa-vulkan-drivers \
    opencl-headers \
    ocl-icd \
    git \
    unzip

# AMD GPU specific (for your RX 580)
sudo dnf install -y rocm-opencl rocm-clinfo
```

### Step 3: Use Automated Installation Script
```bash
# Clone the fedora-resolve repository
git clone https://github.com/yioannides/fedora-resolve.git
cd fedora-resolve

# Make the script executable
chmod +x install-resolve.sh

# Run the installer (it will guide you through the process)
./install-resolve.sh
```

**What the script does:**
- Automatically extracts DaVinci Resolve
- Fixes library compatibility issues
- Sets up proper permissions
- Creates desktop shortcuts
- Handles AMD GPU optimizations

### Step 4: Post-Installation Setup
```bash
# Add your user to the video group (required for GPU access)
sudo usermod -a -G video $USER

# Reboot to apply group changes
sudo reboot
```

## Method 2: Manual Installation (If script fails)

### Step 1: Extract and Prepare
```bash
# Go to your Downloads folder
cd ~/Downloads

# Extract DaVinci Resolve
unzip DaVinci_Resolve_*_Linux.zip

# Make installer executable
chmod +x DaVinci_Resolve_*_Linux.run
```

### Step 2: Install with Package Check Skip
```bash
# Install DaVinci Resolve (skip package checks for Fedora)
sudo SKIP_PACKAGE_CHECK=1 ./DaVinci_Resolve_*_Linux.run
```

### Step 3: Fix Library Issues
```bash
# Create symbolic links for missing libraries
sudo ln -sf /usr/lib64/libcrypto.so.3 /opt/resolve/libs/libcrypto.so.1.1
sudo ln -sf /usr/lib64/libssl.so.3 /opt/resolve/libs/libssl.so.1.1

# Fix APR library
sudo ln -sf /usr/lib64/libapr-1.so.0 /opt/resolve/libs/libapr-1.so.0
sudo ln -sf /usr/lib64/libaprutil-1.so.0 /opt/resolve/libs/libaprutil-1.so.0
```

## AMD GPU Optimization for RX 580

### ROCm Setup (Optional but recommended)
```bash
# Install ROCm for better AMD GPU performance
sudo dnf config-manager --add-repo https://repo.radeon.com/rocm/centos8/4.5.2/repo/
sudo dnf install rocm-dev rocm-libs

# Add ROCm to PATH
echo 'export PATH=/opt/rocm/bin:$PATH' >> ~/.bashrc
source ~/.bashrc
```

### DaVinci Resolve GPU Settings
1. Open DaVinci Resolve
2. Go to **DaVinci Resolve → Preferences**
3. Navigate to **System → Memory and GPU**
4. Set **GPU Processing Mode** to "OpenCL"
5. Enable **Use display GPU for compute** (if available)
6. Set **GPU Memory** to maximum available

## Troubleshooting Common Issues

### Issue: DaVinci Resolve won't start
**Solution:**
```bash
# Check if you're in the video group
groups $USER

# If video group is missing, add it:
sudo usermod -a -G video $USER
sudo reboot
```

### Issue: Poor performance or crashes
**Solutions:**
```bash
# Check GPU compatibility
clinfo

# Verify OpenCL is working
/opt/rocm/bin/rocm-smi

# If issues persist, try launching with specific flags:
/opt/resolve/bin/resolve --disable-gpu
```

### Issue: Audio/Video sync problems
**Solution:**
1. In Project Settings → Master Settings
2. Set **Timeline resolution** to match your footage
3. Enable **Use optimized media** for better performance

### Issue: Can't import certain video formats
**Solution:**
```bash
# Install additional codecs
sudo dnf install ffmpeg ffmpeg-libs
sudo dnf groupupdate multimedia
```

## Performance Tips for Your RX 580

### Optimized Project Settings
- **Timeline Resolution**: 1080p for most work, 4K only when necessary
- **Timeline Frame Rate**: Match your source footage
- **Optimized Media Format**: DNxHR LB for proxy workflows
- **Render Cache**: Smart cache enabled

### System Optimization
```bash
# Increase file limits for DaVinci
echo "* soft nofile 65536" | sudo tee -a /etc/security/limits.conf
echo "* hard nofile 65536" | sudo tee -a /etc/security/limits.conf

# Set performance governor when editing
sudo cpupower frequency-set -g performance
```

### Storage Recommendations
- Use SSD for DaVinci Resolve database and cache
- Store media files on fast storage (SSD preferred)
- Enable proxy media for large files

## Alternative: Native Linux Editors

If DaVinci Resolve proves too challenging, consider these native alternatives:

### Kdenlive (Professional features)
```bash
sudo dnf install kdenlive
```

### OpenShot (User-friendly)
```bash
sudo dnf install openshot
```

### Blender (For motion graphics)
```bash
sudo dnf install blender
```

## Post-Installation Checklist

- [ ] DaVinci Resolve launches without errors
- [ ] GPU is recognized in preferences
- [ ] Can create new project
- [ ] Can import test footage
- [ ] Playback is smooth
- [ ] Rendering works
- [ ] Audio levels are correct

## Getting Help

If you encounter issues:
1. Check DaVinci Resolve logs: `~/.local/share/DaVinciResolve/logs/`
2. Fedora-specific help: GitHub issues on the fedora-resolve repo
3. General DaVinci help: BlackMagic Design forums
4. Hardware compatibility: Check if RX 580 is listed in supported GPUs

Remember: The free version of DaVinci Resolve is very capable for most editing needs, including your streaming content creation!
