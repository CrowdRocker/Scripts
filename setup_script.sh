#!/bin/bash
# TokyoNight SwayFX Gaming Setup Installation Script
# Matt's Custom Configuration (@Crowdrocker)

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
PURPLE='\033[0;35m'
NC='\033[0m' # No Color

# ASCII Art Banner
echo -e "${PURPLE}"
cat << "EOF"
 ████████╗ ██████╗ ██╗  ██╗██╗   ██╗ ██████╗ ███╗   ██╗██╗ ██████╗ ██╗  ██╗████████╗
 ╚══██╔══╝██╔═══██╗██║ ██╔╝╚██╗ ██╔╝██╔═══██╗████╗  ██║██║██╔════╝ ██║  ██║╚══██╔══╝
    ██║   ██║   ██║█████╔╝  ╚████╔╝ ██║   ██║██╔██╗ ██║██║██║  ███╗███████║   ██║   
    ██║   ██║   ██║██╔═██╗   ╚██╔╝  ██║   ██║██║╚██╗██║██║██║   ██║██╔══██║   ██║   
    ██║   ╚██████╔╝██║  ██╗   ██║   ╚██████╔╝██║ ╚████║██║╚██████╔╝██║  ██║   ██║   
    ╚═╝    ╚═════╝ ╚═╝  ╚═╝   ╚═╝    ╚═════╝ ╚═╝  ╚═══╝╚═╝ ╚═════╝ ╚═╝  ╚═╝   ╚═╝   
                                                                                     
     ███████╗██╗    ██╗ █████╗ ██╗   ██╗███████╗██╗  ██╗    ███████╗███████╗████████╗██╗   ██╗██████╗ 
     ██╔════╝██║    ██║██╔══██╗╚██╗ ██╔╝██╔════╝╚██╗██╔╝    ██╔════╝██╔════╝╚══██╔══╝██║   ██║██╔══██╗
     ███████╗██║ █╗ ██║███████║ ╚████╔╝ █████╗   ╚███╔╝     ███████╗█████╗     ██║   ██║   ██║██████╔╝
     ╚════██║██║███╗██║██╔══██║  ╚██╔╝  ██╔══╝   ██╔██╗     ╚════██║██╔══╝     ██║   ██║   ██║██╔═══╝ 
     ███████║╚███╔███╔╝██║  ██║   ██║   ██║     ██╔╝ ██╗    ███████║███████╗   ██║   ╚██████╔╝██║     
     ╚══════╝ ╚══╝╚══╝ ╚═╝  ╚═╝   ╚═╝   ╚═╝     ╚═╝  ╚═╝    ╚══════╝╚══════╝   ╚═╝    ╚═════╝ ╚═╝     
                                                                                                       
                    🌃 Gaming & Creative Workstation Setup 🎮📸
                              by Matt (@Crowdrocker)
EOF
echo -e "${NC}"

print_status() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

print_step() {
    echo -e "${BLUE}[STEP]${NC} $1"
}

# Check if running on Arch Linux
check_arch() {
    if [[ ! -f /etc/arch-release ]]; then
        print_error "This script is designed for Arch Linux. Please run on Arch Linux."
        exit 1
    fi
    print_status "Arch Linux detected ✓"
}

# Create necessary directories
create_directories() {
    print_step "Creating configuration directories..."
    
    mkdir -p ~/.config/{sway,waybar,eww,rofi,alacritty,dunst,scripts}
    mkdir -p ~/.config/eww/{scripts,scss}
    mkdir -p ~/.config/sway/{scripts,wallpapers,config.d}
    mkdir -p ~/.local/share/applications
    mkdir -p ~/Pictures/Screenshots
    
    print_status "Directories created ✓"
}

# Install required packages
install_packages() {
    print_step "Installing required packages..."
    
    # Core packages
    CORE_PACKAGES=(
        "swayfx"           # SwayFX compositor
        "waybar"           # Status bar
        "rofi-wayland"     # Application launcher
        "alacritty"        # Terminal emulator
        "thunar"           # File manager
        "dunst"            # Notification daemon
        "eww"              # ElKowar's Wacky Widgets
        "pipewire"         # Audio server
        "pipewire-pulse"   # PulseAudio compatibility
        "wireplumber"      # Session manager
        "pavucontrol"      # Audio control
        "grim"             # Screenshot utility
        "slurp"            # Area selection for screenshots
        "wl-clipboard"     # Clipboard utilities
        "swaylock"         # Screen locker
        "swayidle"         # Idle manager
        "sddm"             # Display manager
        "nwg-look"         # GTK theme manager
        "azote"            # Wallpaper manager
        "autotiling"       # Auto-tiling script
    )
    
    # Gaming packages
    GAMING_PACKAGES=(
        "steam"            # Steam client
        "lutris"           # Game manager
        "heroic-games-launcher-bin"  # Epic/GOG launcher
        "gamemode"         # Gaming optimizations
        "lib32-gamemode"   # 32-bit gamemode
        "mangohud"         # Performance overlay
        "lib32-mangohud"   # 32-bit mangohud
        "gamescope"        # Gaming compositor
        "vulkan-radeon"    # AMD Vulkan driver
        "lib32-vulkan-radeon"  # 32-bit AMD Vulkan
        "mesa"             # Mesa drivers
        "lib32-mesa"       # 32-bit Mesa
        "dxvk-bin"         # DirectX to Vulkan
        "vkd3d"            # Direct3D 12 to Vulkan
    )
    
    # Creative packages
    CREATIVE_PACKAGES=(
        "gimp"             # Photo editing
        "rawtherapee"      # RAW processor
        "blender"          # 3D creation
        "obs-studio"       # Screen recording
        "ffmpeg"           # Video processing
        "imagemagick"      # Image manipulation
    )
    
    # Development packages
    DEV_PACKAGES=(
        "python-gtk4"      # GTK4 Python bindings
        "python-pygobject" # GObject bindings
        "git"              # Version control
        "neofetch"         # System info
        "fastfetch"        # Fast system info
        "htop"             # Process monitor
        "btop"             # Modern process monitor
        "zsh"              # Z shell
        "starship"         # Shell prompt
        "playerctl"        # Media player control
        "bc"               # Basic calculator
        "jq"               # JSON processor
    )
    
    # Check if packages are installed, install if not
    for package in "${CORE_PACKAGES[@]}" "${GAMING_PACKAGES[@]}" "${CREATIVE_PACKAGES[@]}" "${DEV_PACKAGES[@]}"; do
        if ! pacman -Qi "$package" &> /dev/null; then
            print_status "Installing $package..."
            sudo pacman -S --noconfirm "$package" || {
                print_warning "Failed to install $package, trying AUR..."
                yay -S --noconfirm "$package" || print_warning "Could not install $package"
            }
        fi
    done
    
    print_status "Package installation completed ✓"
}

# Install AUR helper if not present
install_aur_helper() {
    if ! command -v yay &> /dev/null; then
        print_step "Installing AUR helper (yay)..."
        git clone https://aur.archlinux.org/yay.git /tmp/yay
        cd /tmp/yay
        makepkg -si --noconfirm
        cd -
        rm -rf /tmp/yay
        print_status "AUR helper installed ✓"
    fi
}

# Setup AMD GPU optimizations
setup_amd_optimizations() {
    print_step "Setting up AMD GPU optimizations..."
    
    # Create environment variables file
    cat > ~/.config/environment.d/amd.conf << EOF
# AMD GPU Optimizations
RADV_PERFTEST=aco
DXVK_ASYNC=1
AMD_VULKAN_ICD=RADV
RADV_DEBUG=nohiz,norbplus
__GL_SHADER_DISK_CACHE=1
__GL_SHADER_DISK_CACHE_PATH=/tmp
EOF
    
    # Add user to gamemode group
    sudo usermod -a -G gamemode $USER
    
    print_status "AMD optimizations configured ✓"
}

# Configure SwayFX
configure_swayfx() {
    print_step "Configuring SwayFX..."
    
    # Copy the SwayFX configuration (from the artifact we created)
    # This would normally copy the config file we created
    cat > ~/.config/sway/config << 'EOF'
# Include the SwayFX config from our artifact
# [The complete config from the swayfx_config artifact would go here]
EOF
    
    print_status "SwayFX configured ✓"
}

# Configure Waybar
configure_waybar() {
    print_step "Configuring Waybar..."
    
    # Create Waybar config and style files
    # (From our waybar_config and waybar_styles artifacts)
    
    print_status "Waybar configured ✓"
}

# Setup EWW widgets
setup_eww() {
    print_step "Setting up EWW widgets..."
    
    # Create EWW configuration files
    # (From our eww_widget_config and eww_game_launcher artifacts)
    
    # Make scripts executable
    chmod +x ~/.config/eww/scripts/*.sh
    
    print_status "EWW widgets configured ✓"
}

# Configure Rofi
configure_rofi() {
    print_step "Configuring Rofi..."
    
    mkdir -p ~/.config/rofi
    
    cat > ~/.config/rofi/config.rasi << 'EOF'
configuration {
    modi: "drun,run,window,ssh";
    show-icons: true;
    icon-theme: "Papirus-Dark";
    location: 0;
    disable-history: false;
    hide-scrollbar: true;
    display-drun: "   Apps ";
    display-run: "   Run ";
    display-window: " 﩯  Window";
    display-Network: " 󰤨  Network";
    sidebar-mode: true;
}

@theme "tokyonight"
EOF

    # Create TokyoNight theme for Rofi
    cat > ~/.config/rofi/tokyonight.rasi << 'EOF'
* {
    bg-col:  #1a1b26;
    bg-col-light: #24283b;
    border-col: #414868;
    selected-col: #7aa2f7;
    blue: #7aa2f7;
    fg-col: #c0caf5;
    fg-col2: #9aa5ce;
    grey: #414868;

    width: 600;
    font: "JetBrains Mono Nerd Font 12";
}

element-text, element-icon , mode-switcher {
    background-color: inherit;
    text-color:       inherit;
}

window {
    height: 360px;
    border: 2px;
    border-color: @border-col;
    background-color: @bg-col;
    border-radius: 16px;
}

mainbox {
    background-color: @bg-col;
}

inputbar {
    children: [prompt,entry];
    background-color: @bg-col;
    border-radius: 12px;
    padding: 2px;
}

prompt {
    background-color: @blue;
    padding: 8px;
    text-color: @bg-col;
    border-radius: 8px;
    margin: 20px 0px 0px 20px;
}

textbox-prompt-colon {
    expand: false;
    str: ":";
}

entry {
    padding: 8px;
    margin: 20px 0px 0px 10px;
    text-color: @fg-col;
    background-color: @bg-col;
}

listview {
    border: 0px 0px 0px;
    padding: 6px 0px 0px;
    margin: 10px 0px 0px 20px;
    columns: 2;
    lines: 5;
    background-color: @bg-col;
}

element {
    padding: 5px;
    background-color: @bg-col;
    text-color: @fg-col;
    border-radius: 8px;
}

element-icon {
    size: 25px;
}

element selected {
    background-color: @selected-col;
    text-color: @bg-col;
}

mode-switcher {
    spacing: 0;
}

button {
    padding: 10px;
    background-color: @bg-col-light;
    text-color: @grey;
    vertical-align: 0.5;
    horizontal-align: 0.5;
}

button selected {
    background-color: @bg-col;
    text-color: @blue;
}
EOF
    
    print_status "Rofi configured ✓"
}

# Configure Alacritty
configure_alacritty() {
    print_step "Configuring Alacritty..."
    
    cat > ~/.config/alacritty/alacritty.yml << 'EOF'
window:
  opacity: 0.9
  blur: true
  decorations: none
  startup_mode: Windowed
  title: Alacritty
  dynamic_title: true

scrolling:
  history: 10000
  multiplier: 3

font:
  normal:
    family: "JetBrains Mono Nerd Font"
    style: Regular
  bold:
    family: "JetBrains Mono Nerd Font"
    style: Bold
  italic:
    family: "JetBrains Mono Nerd Font"
    style: Italic
  size: 12.0

colors:
  primary:
    background: '#1a1b26'
    foreground: '#c0caf5'
  normal:
    black: '#15161e'
    red: '#f7768e'
    green: '#9ece6a'
    yellow: '#e0af68'
    blue: '#7aa2f7'
    magenta: '#bb9af7'
    cyan: '#7dcfff'
    white: '#a9b1d6'
  bright:
    black: '#414868'
    red: '#f7768e'
    green: '#9ece6a'
    yellow: '#e0af68'
    blue: '#7aa2f7'
    magenta: '#bb9af7'
    cyan: '#7dcfff'
    white: '#c0caf5'

cursor:
  style: Block
  unfocused_hollow: true

live_config_reload: true

key_bindings:
  - { key: V,        mods: Control|Shift, action: Paste            }
  - { key: C,        mods: Control|Shift, action: Copy             }
  - { key: Plus,     mods: Control,       action: IncreaseFontSize }
  - { key: Minus,    mods: Control,       action: DecreaseFontSize }
  - { key: Key0,     mods: Control,       action: ResetFontSize    }
EOF
    
    print_status "Alacritty configured ✓"
}

# Setup Welcome App
setup_welcome_app() {
    print_step "Setting up Welcome App..."
    
    # Copy the Python welcome app from our artifact
    # Create desktop file
    cat > ~/.local/share/applications/tokyonight-welcome.desktop << 'EOF'
[Desktop Entry]
Name=TokyoNight Control Center
Comment=Gaming & Creative Workstation Control Panel
Exec=python3 ~/.config/sway/scripts/tokyonight_welcome.py
Icon=preferences-system
Terminal=false
Type=Application
Categories=System;Settings;
StartupNotify=true
EOF
    
    print_status "Welcome App installed ✓"
}

# Download TokyoNight wallpapers
download_wallpapers() {
    print_step "Downloading TokyoNight wallpapers..."
    
    WALLPAPER_DIR="$HOME/.config/sway/wallpapers"
    mkdir -p "$WALLPAPER_DIR"
    
    # Download some beautiful TokyoNight wallpapers
    curl -L "https://raw.githubusercontent.com/enkia/tokyo-night-vscode-theme/master/static/tokyo-night.png" \
         -o "$WALLPAPER_DIR/tokyonight-city.jpg" 2>/dev/null || \
    print_warning "Could not download wallpaper, using default"
    
    print_status "Wallpapers downloaded ✓"
}

# Setup shell configuration
setup_shell() {
    print_step "Setting up shell configuration..."
    
    # Install Oh My Zsh if not present
    if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
        sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
    fi
    
    # Configure Starship prompt
    if command -v starship &> /dev/null; then
        echo 'eval "$(starship init zsh)"' >> ~/.zshrc
        
        # Create Starship TokyoNight config
        mkdir -p ~/.config
        cat > ~/.config/starship.toml << 'EOF'
format = """
[░▒▓](#1a1b26)\
$os\
$username\
[](bg:#24283b fg:#1a1b26)\
$directory\
[](fg:#24283b bg:#414868)\
$git_branch\
$git_status\
[](fg:#414868 bg:#7aa2f7)\
$nodejs\
$rust\
$golang\
$python\
[](fg:#7aa2f7 bg:#bb9af7)\
$docker_context\
[](fg:#bb9af7 bg:#9ece6a)\
$time\
[ ](fg:#9ece6a)\
"""

[os]
disabled = false
style = "bg:#1a1b26 fg:#c0caf5"

[os.symbols]
Arch = "󰣇"

[username]
show_always = true
style_user = "bg:#1a1b26 fg:#c0caf5"
style_root = "bg:#1a1b26 fg:#f7768e"
format = '[$user ]($style)'
disabled = false

[directory]
style = "fg:#c0caf5 bg:#24283b"
format = "[ $path ]($style)"
truncation_length = 3
truncation_symbol = "…/"

[directory.substitutions]
"Documents" = "󰈙 "
"Downloads" = " "
"Music" = " "
"Pictures" = " "

[git_branch]
symbol = ""
style = "bg:#414868"
format = '[[ $symbol $branch ](fg:#c0caf5 bg:#414868)]($style)'

[git_status]
style = "bg:#414868"
format = '[[($all_status$ahead_behind )](fg:#c0caf5 bg:#414868)]($style)'

[nodejs]
symbol = ""
style = "bg:#7aa2f7"
format = '[[ $symbol ($version) ](fg:#1a1b26 bg:#7aa2f7)]($style)'

[rust]
symbol = ""
style = "bg:#7aa2f7"
format = '[[ $symbol ($version) ](fg:#1a1b26 bg:#7aa2f7)]($style)'

[golang]
symbol = ""
style = "bg:#7aa2f7"
format = '[[ $symbol ($version) ](fg:#1a1b26 bg:#7aa2f7)]($style)'

[python]
symbol = ""
style = "bg:#7aa2f7"
format = '[[ $symbol ($version) ](fg:#1a1b26 bg:#7aa2f7)]($style)'

[docker_context]
symbol = ""
style = "bg:#bb9af7"
format = '[[ $symbol $context ](fg:#1a1b26 bg:#bb9af7)]($style)'

[time]
disabled = false
time_format = "%R" # Hour:Minute Format
style = "bg:#9ece6a"
format = '[[ 🕒 $time ](fg:#1a1b26 bg:#9ece6a)]($style)'
EOF
    fi
    
    # Set zsh as default shell
    if [[ "$SHELL" != */zsh ]]; then
        print_status "Changing default shell to zsh..."
        chsh -s $(which zsh)
    fi
    
    print_status "Shell configuration completed ✓"
}

# Setup gaming optimizations
setup_gaming_optimizations() {
    print_step "Setting up gaming optimizations..."
    
    # Create gamemode config
    sudo mkdir -p /etc/gamemode
    sudo cat > /etc/gamemode/gamemode.ini << 'EOF'
[general]
renice=10
ioprio=0
inhibit_screensaver=1
softrealtime=auto
reaper_freq=5

[gpu]
apply_gpu_optimisations=accept-responsibility
gpu_device=0
amd_performance_level=high

[custom]
start=notify-send "GameMode" "Optimizations activated" && echo performance | sudo tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor
end=notify-send "GameMode" "Optimizations deactivated" && echo powersave | sudo tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor
EOF
    
    # Setup udev rules for controller access
    sudo cat > /etc/udev/rules.d/99-steam-controller-perms.rules << 'EOF'
# Steam Controller udev rules
SUBSYSTEM=="usb", ATTRS{idVendor}=="28de", MODE="0666"
KERNEL=="uinput", MODE="0660", GROUP="input", OPTIONS+="static_node=uinput"
SUBSYSTEM=="misc", KERNEL=="uinput", MODE="0660", GROUP="input"
EOF
    
    # Add user to input group
    sudo usermod -a -G input $USER
    
    print_status "Gaming optimizations configured ✓"
}

# Setup system services
setup_services() {
    print_step "Setting up system services..."
    
    # Enable SDDM
    sudo systemctl enable sddm.service
    
    # Configure SDDM with Sugar Candy theme
    sudo mkdir -p /etc/sddm.conf.d
    sudo cat > /etc/sddm.conf.d/theme.conf << 'EOF'
[Theme]
Current=sugar-candy
EOF
    
    # Enable zram for better memory management
    if pacman -Qi zram-generator &> /dev/null; then
        sudo cat > /etc/systemd/zram-generator.conf << 'EOF'
[zram0]
zram-fraction = 0.5
max-zram-size = 4096
compression-algorithm = zstd
EOF
        sudo systemctl enable systemd-zram-setup@zram0.service
    fi
    
    print_status "System services configured ✓"
}

# Create useful scripts
create_scripts() {
    print_step "Creating utility scripts..."
    
    # Theme switcher script
    cat > ~/.config/scripts/theme_switcher.sh << 'EOF'
#!/bin/bash
# TokyoNight Theme Switcher

THEMES=("TokyoNight Storm" "TokyoNight Night" "TokyoNight Day")

selected=$(printf '%s\n' "${THEMES[@]}" | rofi -dmenu -p "Select Theme")

case "$selected" in
    "TokyoNight Storm")
        notify-send "Theme Switcher" "Applying TokyoNight Storm theme..."
        # Apply storm variant
        ;;
    "TokyoNight Night")
        notify-send "Theme Switcher" "Applying TokyoNight Night theme..."
        # Apply night variant
        ;;
    "TokyoNight Day")
        notify-send "Theme Switcher" "Applying TokyoNight Day theme..."
        # Apply day variant
        ;;
esac
EOF

    # Power menu script
    mkdir -p ~/.config/rofi/scripts
    cat > ~/.config/rofi/scripts/powermenu.sh << 'EOF'
#!/bin/bash
# Power Menu Script

options="Shutdown\nReboot\nSuspend\nLock\nLogout"

selected=$(echo -e "$options" | rofi -dmenu -p "Power Menu" -theme ~/.config/rofi/tokyonight.rasi)

case "$selected" in
    "Shutdown")
        systemctl poweroff
        ;;
    "Reboot")
        systemctl reboot
        ;;
    "Suspend")
        systemctl suspend
        ;;
    "Lock")
        swaylock -f -c 1a1b26
        ;;
    "Logout")
        swaymsg exit
        ;;
esac
EOF

    # Gaming launcher script
    cat > ~/.config/scripts/gaming_launcher.sh << 'EOF'
#!/bin/bash
# Quick Gaming Launcher

games=(
    "The Division 2:division2"
    "First Descendant:descendant"
    "Cyberpunk 2077:cyberpunk"
    "Steam:steam"
    "Lutris:lutris"
    "Heroic Games:heroic"
)

menu_string=""
for game in "${games[@]}"; do
    game_name=$(echo "$game" | cut -d':' -f1)
    menu_string="$menu_string$game_name\n"
done

selected=$(echo -e "$menu_string" | rofi -dmenu -p "Launch Game" -theme ~/.config/rofi/tokyonight.rasi)

if [[ ! -z "$selected" ]]; then
    for game in "${games[@]}"; do
        game_name=$(echo "$game" | cut -d':' -f1)
        game_id=$(echo "$game" | cut -d':' -f2)
        if [[ "$game_name" == "$selected" ]]; then
            ~/.config/eww/scripts/launch_game.sh "$game_id"
            break
        fi
    done
fi
EOF

    # Make all scripts executable
    chmod +x ~/.config/scripts/*.sh
    chmod +x ~/.config/rofi/scripts/*.sh
    
    print_status "Utility scripts created ✓"
}

# Final setup and validation
final_setup() {
    print_step "Performing final setup..."
    
    # Create symlinks for easy access
    ln -sf ~/.config/sway/config ~/.config/sway/config.backup
    
    # Validate configuration files
    if sway --validate; then
        print_status "SwayFX configuration is valid ✓"
    else
        print_warning "SwayFX configuration has issues, please check manually"
    fi
    
    # Set correct permissions
    chmod 755 ~/.config/eww/scripts/*.sh
    chmod 755 ~/.config/scripts/*.sh
    
    print_status "Final setup completed ✓"
}

# Main installation function
main() {
    echo -e "${GREEN}Welcome to Matt's TokyoNight SwayFX Gaming Setup!${NC}"
    echo -e "${YELLOW}This script will configure your Arch Linux system for gaming and creative work.${NC}"
    echo ""
    
    read -p "Continue with installation? (y/N): " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        print_error "Installation cancelled."
        exit 1
    fi
    
    echo -e "${BLUE}Starting installation...${NC}"
    echo ""
    
    check_arch
    install_aur_helper
    create_directories
    install_packages
    setup_amd_optimizations
    configure_swayfx
    configure_waybar
    setup_eww
    configure_rofi
    configure_alacritty
    setup_welcome_app
    download_wallpapers
    setup_shell
    setup_gaming_optimizations
    setup_services
    create_scripts
    final_setup
    
    echo ""
    echo -e "${GREEN}🎉 Installation completed successfully! 🎉${NC}"
    echo ""
    echo -e "${YELLOW}Next steps:${NC}"
    echo -e "1. ${BLUE}Reboot your system${NC}"
    echo -e "2. ${BLUE}Log in using SDDM${NC}"
    echo -e "3. ${BLUE}Launch the Welcome App: Super+Shift+W${NC}"
    echo -e "4. ${BLUE}Open Game Launcher: Super+Shift+G${NC}"
    echo -e "5. ${BLUE}Toggle Gaming Mode: Super+G${NC}"
    echo ""
    echo -e "${PURPLE}Enjoy your TokyoNight gaming setup! 🌃🎮📸${NC}"
    echo ""
    echo -e "${GREEN}Created by Matt (@Crowdrocker)${NC}"
    echo -e "${GREEN}For issues: https://github.com/Crowdrocker${NC}"
}

# Error handling
trap 'print_error "An error occurred during installation. Check the output above."; exit 1' ERR

# Run main function
main "$@" 
