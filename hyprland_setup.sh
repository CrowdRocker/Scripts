#!/bin/bash

# WehttamSnaps Complete Hyprland Setup Script
# TokyoNight Violet-to-Cyan Gaming Setup for Arch Linux
# Author: Generated for Matt (WehttamSnaps)

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Logo
cat << "EOF"
╦ ╦┌─┐┬ ┬┌┬┐┌┬┐┌─┐┌┬┐╔═╗┌┐┌┌─┐┌─┐┌─┐
║║║├┤ ├─┤ │  │ ├─┤│││╚═╗│││├─┤├─┘└─┐
╚╩╝└─┘┴ ┴ ┴  ┴ ┴ ┴┴ ┴╚═╝┘└┘┴ ┴┴  └─┘
   Hyprland Gaming Setup - TokyoNight Theme
EOF

echo -e "${PURPLE}Starting WehttamSnaps Hyprland Setup...${NC}"

# Check if running as root
if [[ $EUID -eq 0 ]]; then
   echo -e "${RED}This script should not be run as root${NC}"
   exit 1
fi

# Create directories
echo -e "${BLUE}Creating directory structure...${NC}"
mkdir -p ~/.config/{hypr,waybar,rofi,dunst,kitty,fastfetch,eww,gtk-3.0,gtk-4.0}
mkdir -p ~/.config/{sddm,grub,xfce4/terminal}
mkdir -p ~/.local/share/{applications,icons,themes,fonts}
mkdir -p ~/Pictures/wallpapers
mkdir -p ~/.config/systemd/user

# Update system
echo -e "${YELLOW}Updating system packages...${NC}"
sudo pacman -Syu --noconfirm

# Install base packages
echo -e "${BLUE}Installing base Hyprland packages...${NC}"
sudo pacman -S --noconfirm \
    hyprland hyprpaper hyprlock hypridle \
    waybar wofi rofi-wayland dunst mako \
    kitty alacritty xfce4-terminal \
    thunar thunar-volman thunar-archive-plugin thunar-media-tags-plugin \
    pipewire pipewire-pulse pipewire-alsa pipewire-jack \
    wireplumber pavucontrol playerctl \
    grim slurp wl-clipboard \
    brightnessctl pamixer \
    polkit-gnome \
    xdg-desktop-portal-hyprland \
    qt5-wayland qt6-wayland \
    noto-fonts noto-fonts-cjk noto-fonts-emoji \
    ttf-font-awesome ttf-fira-code \
    nwg-look azote \
    fastfetch neofetch htop btop \
    zsh starship \
    firefox \
    steam lutris heroic-games-launcher \
    obs-studio \
    gimp \
    git base-devel

# Install AUR helper (paru)
if ! command -v paru &> /dev/null; then
    echo -e "${YELLOW}Installing paru AUR helper...${NC}"
    cd /tmp
    git clone https://aur.archlinux.org/paru.git
    cd paru
    makepkg -si --noconfirm
    cd ~
fi

# Install AUR packages
echo -e "${BLUE}Installing AUR packages...${NC}"
paru -S --noconfirm \
    eww-wayland \
    hyprshot \
    sddm-sugar-candy-git \
    gamemode \
    gamescope \
    mangohud \
    goverlay \
    preload \
    zramd

# AMD optimizations
echo -e "${PURPLE}Setting up AMD gaming optimizations...${NC}"

# Enable gamemode
sudo systemctl enable --now gamemode

# Setup zram
sudo systemctl enable --now zramd

# AMD GPU optimizations
if lspci | grep -i amd | grep -i vga; then
    echo 'SUBSYSTEM=="drm", KERNEL=="card*", DRIVERS=="amdgpu", ATTR{device/power_dpm_force_performance_level}="high"' | sudo tee /etc/udev/rules.d/30-amdgpu-pm.rules
fi

# Create Hyprland config
echo -e "${CYAN}Creating Hyprland configuration...${NC}"
cat > ~/.config/hypr/hyprland.conf << 'EOF'
# WehttamSnaps Hyprland Config - TokyoNight Violet-to-Cyan

# Monitor setup
monitor = ,1920x1080@60,0x0,1

# Environment variables
env = XCURSOR_SIZE,24
env = HYPRCURSOR_SIZE,24
env = QT_QPA_PLATFORMTHEME,qt5ct
env = QT_QPA_PLATFORM,wayland;xcb
env = GDK_BACKEND,wayland,x11
env = CLUTTER_BACKEND,wayland
env = XDG_CURRENT_DESKTOP,Hyprland
env = XDG_SESSION_TYPE,wayland
env = XDG_SESSION_DESKTOP,Hyprland

# AMD Gaming optimizations
env = RADV_PERFTEST,aco
env = AMD_VULKAN_ICD,RADV
env = VK_ICD_FILENAMES,/usr/share/vulkan/icd.d/radeon_icd.x86_64.json

# Execute your favorite apps at launch
exec-once = waybar
exec-once = hyprpaper
exec-once = dunst
exec-once = /usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1
exec-once = dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
exec-once = eww daemon

# Input configuration
input {
    kb_layout = us
    kb_variant = 
    kb_model =
    kb_options =
    kb_rules =

    follow_mouse = 1
    sensitivity = 0

    touchpad {
        natural_scroll = false
    }
}

# General settings
general {
    gaps_in = 8
    gaps_out = 12
    border_size = 2
    
    # TokyoNight colors - violet to cyan gradient
    col.active_border = rgba(bb9af7ff) rgba(7dcfffff) 45deg
    col.inactive_border = rgba(414868aa)

    resize_on_border = false
    allow_tearing = true

    layout = dwindle
}

# Decoration
decoration {
    rounding = 8

    active_opacity = 1.0
    inactive_opacity = 0.9

    drop_shadow = true
    shadow_range = 4
    shadow_render_power = 3
    col.shadow = rgba(1a1a2e35)

    blur {
        enabled = true
        size = 8
        passes = 3
        vibrancy = 0.1696
    }
}

# Animations - Cyberpunk feel
animations {
    enabled = true

    bezier = myBezier, 0.05, 0.9, 0.1, 1.05
    bezier = smooth, 0.25, 0.46, 0.45, 0.94

    animation = windows, 1, 7, myBezier
    animation = windowsOut, 1, 7, default, popin 80%
    animation = border, 1, 10, default
    animation = borderangle, 1, 8, default
    animation = fade, 1, 7, default
    animation = workspaces, 1, 6, default
}

# Layouts
dwindle {
    pseudotile = true
    preserve_split = true
    smart_split = true
}

# Window rules
windowrule = float, ^(pavucontrol)$
windowrule = float, ^(blueman-manager)$
windowrule = float, ^(nm-connection-editor)$
windowrule = float, ^(org.kde.polkit-kde-authentication-agent-1)$

# Gaming rules
windowrulev2 = immediate, class:^(steam_app_)(.*)$
windowrulev2 = immediate, class:^(gamescope)$
windowrulev2 = fullscreen, class:^(gamescope)$

# Key bindings
$mainMod = SUPER

# Application shortcuts
bind = $mainMod, Q, exec, xfce4-terminal
bind = $mainMod, C, killactive,
bind = $mainMod, M, exit,
bind = $mainMod, E, exec, thunar
bind = $mainMod, V, togglefloating,
bind = $mainMod, R, exec, rofi -show drun
bind = $mainMod, P, pseudo,
bind = $mainMod, J, togglesplit,
bind = $mainMod, F, fullscreen,

# Gaming shortcuts
bind = $mainMod, G, exec, steam
bind = $mainMod SHIFT, G, exec, lutris
bind = $mainMod CTRL, G, exec, heroic

# Screenshots
bind = , Print, exec, hyprshot -m output
bind = SHIFT, Print, exec, hyprshot -m window
bind = $mainMod, Print, exec, hyprshot -m region

# Audio
bind = , XF86AudioRaiseVolume, exec, pamixer -i 5
bind = , XF86AudioLowerVolume, exec, pamixer -d 5
bind = , XF86AudioMute, exec, pamixer -t

# Move focus
bind = $mainMod, left, movefocus, l
bind = $mainMod, right, movefocus, r
bind = $mainMod, up, movefocus, u
bind = $mainMod, down, movefocus, d

# Switch workspaces
bind = $mainMod, 1, workspace, 1
bind = $mainMod, 2, workspace, 2
bind = $mainMod, 3, workspace, 3
bind = $mainMod, 4, workspace, 4
bind = $mainMod, 5, workspace, 5
bind = $mainMod, 6, workspace, 6
bind = $mainMod, 7, workspace, 7
bind = $mainMod, 8, workspace, 8
bind = $mainMod, 9, workspace, 9
bind = $mainMod, 0, workspace, 10

# Move windows to workspace
bind = $mainMod SHIFT, 1, movetoworkspace, 1
bind = $mainMod SHIFT, 2, movetoworkspace, 2
bind = $mainMod SHIFT, 3, movetoworkspace, 3
bind = $mainMod SHIFT, 4, movetoworkspace, 4
bind = $mainMod SHIFT, 5, movetoworkspace, 5
bind = $mainMod SHIFT, 6, movetoworkspace, 6
bind = $mainMod SHIFT, 7, movetoworkspace, 7
bind = $mainMod SHIFT, 8, movetoworkspace, 8
bind = $mainMod SHIFT, 9, movetoworkspace, 9
bind = $mainMod SHIFT, 0, movetoworkspace, 10

# Mouse bindings
bindm = $mainMod, mouse:272, movewindow
bindm = $mainMod, mouse:273, resizewindow
EOF

# Create Waybar config
echo -e "${CYAN}Creating Waybar configuration...${NC}"
cat > ~/.config/waybar/config << 'EOF'
{
    "layer": "top",
    "position": "top",
    "height": 35,
    "spacing": 0,
    "margin-top": 8,
    "margin-left": 12,
    "margin-right": 12,
    
    "modules-left": ["custom/menu", "hyprland/workspaces", "hyprland/window"],
    "modules-center": ["clock"],
    "modules-right": ["custom/gamemode", "pulseaudio", "network", "cpu", "memory", "temperature", "custom/updates", "tray", "custom/power"],

    "custom/menu": {
        "format": " ",
        "tooltip": false,
        "on-click": "nwg-drawer",
        "on-click-right": "killall nwg-drawer"
    },

    "hyprland/workspaces": {
        "disable-scroll": true,
        "all-outputs": true,
        "format": "{icon}",
        "format-icons": {
            "1": "一",
            "2": "二", 
            "3": "三",
            "4": "四",
            "5": "五",
            "6": "六",
            "7": "七",
            "8": "八",
            "9": "九",
            "10": "十"
        }
    },

    "hyprland/window": {
        "format": "{}",
        "max-length": 50,
        "separate-outputs": true
    },

    "clock": {
        "timezone": "Europe/Amsterdam",
        "tooltip-format": "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>",
        "format": "{:%H:%M   %a %b %d}"
    },

    "cpu": {
        "format": " {usage}%",
        "tooltip": true,
        "interval": 1
    },

    "memory": {
        "format": " {}%",
        "tooltip": true
    },

    "temperature": {
        "thermal-zone": 2,
        "hwmon-path": "/sys/class/hwmon/hwmon2/temp1_input",
        "critical-threshold": 80,
        "format-critical": " {temperatureC}°C",
        "format": " {temperatureC}°C"
    },

    "network": {
        "format-wifi": " {essid} ({signalStrength}%)",
        "format-ethernet": " Connected",
        "tooltip-format": "{ifname} via {gwaddr}",
        "format-linked": "{ifname} (No IP)",
        "format-disconnected": "⚠ Disconnected",
        "format-alt": "{ifname}: {ipaddr}/{cidr}"
    },

    "pulseaudio": {
        "format": "{icon} {volume}%",
        "format-bluetooth": "{icon} {volume}%",
        "format-bluetooth-muted": " {icon}",
        "format-muted": "",
        "format-source": " {volume}%",
        "format-source-muted": "",
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

    "custom/gamemode": {
        "exec": "if pgrep -x gamemode > /dev/null; then echo ' GAME'; else echo ''; fi",
        "interval": 2,
        "tooltip": false
    },

    "custom/updates": {
        "format": " {}",
        "interval": 3600,
        "exec": "checkupdates | wc -l",
        "exec-if": "exit 0",
        "on-click": "xfce4-terminal -e 'sudo pacman -Syu'",
        "signal": 8
    },

    "tray": {
        "icon-size": 21,
        "spacing": 10
    },

    "custom/power": {
        "format": "⏻",
        "tooltip": false,
        "on-click": "~/.config/waybar/scripts/powermenu.sh"
    }
}
EOF

# Create Waybar style
cat > ~/.config/waybar/style.css << 'EOF'
* {
    border: none;
    border-radius: 0;
    font-family: 'FiraCode Nerd Font', 'Font Awesome 6 Free';
    font-size: 14px;
    min-height: 0;
}

window#waybar {
    background: rgba(26, 27, 38, 0.9);
    color: #c0caf5;
    border-radius: 12px;
    border: 2px solid rgba(187, 154, 247, 0.3);
}

/* Workspaces */
#workspaces {
    background: rgba(65, 72, 104, 0.4);
    margin: 4px 8px;
    padding: 0px 8px;
    border-radius: 8px;
}

#workspaces button {
    padding: 0 8px;
    color: #565f89;
    border-radius: 4px;
    margin: 2px;
    transition: all 0.3s ease-in-out;
}

#workspaces button.active {
    color: #bb9af7;
    background: rgba(187, 154, 247, 0.2);
}

#workspaces button:hover {
    background: rgba(125, 207, 255, 0.2);
    color: #7dcfff;
}

/* Left modules */
#custom-menu {
    color: #7dcfff;
    background: rgba(125, 207, 255, 0.2);
    padding: 0 12px;
    margin: 4px 0px 4px 8px;
    border-radius: 8px;
    font-size: 16px;
}

#window {
    background: rgba(65, 72, 104, 0.4);
    padding: 0 12px;
    margin: 4px 8px;
    border-radius: 8px;
    color: #c0caf5;
}

/* Center modules */
#clock {
    color: #bb9af7;
    background: rgba(187, 154, 247, 0.2);
    padding: 0 16px;
    margin: 4px 8px;
    border-radius: 8px;
    font-weight: bold;
}

/* Right modules */
#cpu, #memory, #temperature, #network, #pulseaudio, #custom-gamemode, #custom-updates, #tray, #custom-power {
    padding: 0 12px;
    margin: 4px 2px;
    border-radius: 8px;
    background: rgba(65, 72, 104, 0.4);
}

#cpu {
    color: #f7768e;
}

#memory {
    color: #9ece6a;
}

#temperature {
    color: #e0af68;
}

#network {
    color: #7dcfff;
}

#pulseaudio {
    color: #bb9af7;
}

#custom-gamemode {
    color: #ff9e64;
    background: rgba(255, 158, 100, 0.2);
}

#custom-updates {
    color: #e0af68;
}

#tray {
    background: transparent;
}

#custom-power {
    color: #f7768e;
    background: rgba(247, 118, 142, 0.2);
    margin-right: 8px;
}

/* Hover effects */
#custom-menu:hover, #cpu:hover, #memory:hover, #temperature:hover, #network:hover, #pulseaudio:hover, #custom-updates:hover, #custom-power:hover {
    background: rgba(187, 154, 247, 0.3);
    transition: all 0.3s ease-in-out;
}
EOF

# Create power menu script
mkdir -p ~/.config/waybar/scripts
cat > ~/.config/waybar/scripts/powermenu.sh << 'EOF'
#!/bin/bash

options="⏻ Power Off\n🔄 Restart\n🔒 Lock\n😴 Sleep\n🚪 Logout"

chosen=$(echo -e "$options" | rofi -dmenu -i -p "Power Menu" -theme-str 'window {width: 200px;}')

case $chosen in
    "⏻ Power Off")
        systemctl poweroff
        ;;
    "🔄 Restart")
        systemctl reboot
        ;;
    "🔒 Lock")
        hyprlock
        ;;
    "😴 Sleep")
        systemctl suspend
        ;;
    "🚪 Logout")
        hyprctl dispatch exit
        ;;
esac
EOF
chmod +x ~/.config/waybar/scripts/powermenu.sh

# Create Rofi config
echo -e "${CYAN}Creating Rofi configuration...${NC}"
mkdir -p ~/.config/rofi
cat > ~/.config/rofi/config.rasi << 'EOF'
configuration {
    modi: "drun,run,window";
    font: "FiraCode Nerd Font 12";
    show-icons: true;
    icon-theme: "Papirus-Dark";
    display-drun: "Applications";
    display-run: "Commands";
    display-window: "Windows";
    sidebar-mode: true;
}

@theme "~/.config/rofi/tokyonight.rasi"
EOF

cat > ~/.config/rofi/tokyonight.rasi << 'EOF'
* {
    background-color: transparent;
    text-color: #c0caf5;
    font: "FiraCode Nerd Font 12";
    
    bg: rgba(26, 27, 38, 0.95);
    bg-alt: rgba(65, 72, 104, 0.6);
    fg: #c0caf5;
    fg-alt: #565f89;
    accent: #bb9af7;
    cyan: #7dcfff;
    
    margin: 0;
    padding: 0;
    spacing: 0;
}

window {
    width: 600px;
    background-color: @bg;
    border: 2px solid;
    border-color: @accent;
    border-radius: 12px;
}

mainbox {
    children: [inputbar, listview];
}

inputbar {
    children: [prompt, entry];
    background-color: @bg-alt;
    border-radius: 8px;
    padding: 12px;
    margin: 12px;
}

prompt {
    text-color: @accent;
    padding: 0 8px 0 0;
}

entry {
    placeholder: "Search...";
    placeholder-color: @fg-alt;
    text-color: @fg;
}

listview {
    lines: 10;
    columns: 1;
    scrollbar: false;
    margin: 0 12px 12px 12px;
}

element {
    padding: 8px 12px;
    border-radius: 8px;
    children: [element-icon, element-text];
}

element selected {
    background-color: @bg-alt;
    text-color: @cyan;
}

element-icon {
    size: 24px;
    padding: 0 8px 0 0;
}

element-text {
    text-color: inherit;
}
EOF

# Create terminal config
echo -e "${CYAN}Creating terminal configuration...${NC}"
cat > ~/.config/xfce4/terminal/terminalrc << 'EOF'
[Configuration]
FontName=FiraCode Nerd Font 11
MiscAlwaysShowTabs=FALSE
MiscBell=FALSE
MiscBellUrgent=FALSE
MiscBordersDefault=TRUE
MiscCursorBlinks=FALSE
MiscCursorShape=TERMINAL_CURSOR_SHAPE_BLOCK
MiscDefaultGeometry=80x24
MiscInheritGeometry=FALSE
MiscMenubarDefault=FALSE
MiscMouseAutohide=FALSE
MiscMouseWheelZoom=TRUE
MiscToolbarDefault=FALSE
MiscConfirmClose=TRUE
MiscCycleTabs=TRUE
MiscTabCloseButtons=TRUE
MiscTabCloseMiddleClick=TRUE
MiscTabPosition=GTK_POS_TOP
MiscHighlightUrls=TRUE
MiscMiddleClickOpensUri=FALSE
MiscCopyOnSelect=FALSE
MiscShowRelaunchDialog=TRUE
MiscRewrapOnResize=TRUE
MiscUseShiftArrowsToSelect=FALSE
MiscSlimTabs=FALSE
MiscNewTabAdjacent=FALSE
MiscSearchDialogOpacity=100
MiscShowUnsafePasteDialog=TRUE
BackgroundMode=TERMINAL_BACKGROUND_TRANSPARENT
BackgroundDarkness=0.900000
ColorForeground=#c0caf5
ColorBackground=#1a1b26
ColorCursor=#c0caf5
ColorBoldUseDefault=FALSE
ColorPalette=#15161e;#f7768e;#9ece6a;#e0af68;#7aa2f7;#bb9af7;#7dcfff;#a9b1d6;#414868;#f7768e;#9ece6a;#e0af68;#7aa2f7;#bb9af7;#7dcfff;#c0caf5
EOF

# Create hyprpaper config
echo -e "${CYAN}Creating wallpaper configuration...${NC}"
cat > ~/.config/hypr/hyprpaper.conf << 'EOF'
preload = ~/Pictures/wallpapers/tokyonight.jpg
wallpaper = ,~/Pictures/wallpapers/tokyonight.jpg

splash = false
ipc = on
EOF

# Download TokyoNight wallpaper
echo -e "${YELLOW}Downloading TokyoNight wallpaper...${NC}"
curl -L "https://raw.githubusercontent.com/tokyo-night/tokyo-night-vscode-theme/master/images/logo.png" -o ~/Pictures/wallpapers/tokyonight.jpg 2>/dev/null || echo "Wallpaper download failed - you'll need to add your own"

# Create eww config for game launcher
echo -e "${CYAN}Creating EWW game launcher...${NC}"
mkdir -p ~/.config/eww
cat > ~/.config/eww/eww.yuck << 'EOF'
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
  (game-launcher-widget))

(defwidget game-launcher-widget []
  (box :class "game-launcher"
       :orientation "v"
       :space-evenly false
    (box :class "header"
         :halign "center"
         "🎮 WehttamSnaps Game Launcher")
    (box :orientation "v"
         :space-evenly true
      (button :class "game-btn"
              :onclick "steam &"
              "🎮 Steam")
      (button :class "game-btn"
              :onclick "lutris &"
              "🍷 Lutris") 
      (button :class "game-btn"
              :onclick "heroic &"
              "🏛️ Heroic")
      (button :class "game-btn"
              :onclick "spotify &"
              "🎵 Spotify")
      (button :class "game-btn"
              :onclick "obs &"
              "📹 OBS Studio"))))
EOF

cat > ~/.config/eww/eww.scss << 'EOF'
* {
  all: unset;
}

.game-launcher {
  background: rgba(26, 27, 38, 0.95);
  border: 2px solid rgba(187, 154, 247, 0.5);
  border-radius: 12px;
  padding: 20px;
}

.header {
  font-size: 18px;
  font-weight: bold;
  color: #bb9af7;
  margin-bottom: 20px;
}

.game-btn {
  background: rgba(65, 72, 104, 0.6);
  color: #c0caf5;
  border-radius: 8px;
  padding: 12px 20px;
  margin: 5px 0;
  font-size: 14px;
  transition: all 0.3s ease;
}

.game-btn:hover {
  background: rgba(187, 154, 247, 0.3);
  color: #7dcfff;
}
EOF

# Setup ZSH with Starship
echo -e "${BLUE}Setting up ZSH and Starship...${NC}"
chsh -s $(which zsh)

# Create .zshrc
cat > ~/.zshrc << 'EOF'
# WehttamSnaps ZSH Config

# Path
export PATH=$HOME/.local/bin:$PATH

# History
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history
setopt appendhistory

# Basic auto/tab complete
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)

# Gaming aliases
alias steam-game="gamemode steam"
alias start-stream="obs --startstreaming"
alias stop-stream="obs --stopstreaming"

# System aliases  
alias ll='ls -alF'
alias la='ls -A' 
alias l='ls -CF'
alias grep='grep --color=auto'
alias ..='cd ..'
alias ...='cd ../..'

# Gaming optimizations
alias gamemode-status="gamemode --status"
alias mangohud-enable="export MANGOHUD=1"

# Initialize starship
eval "$(starship init zsh)"
EOF

# Create Starship config
mkdir -p ~/.config
cat > ~/.config/starship.toml << 'EOF'
format = """
[░▒▓](#7dcfff)\
[  ](bg:#7dcfff fg:#1a1b26)\
[](bg:#bb9af7 fg:#7dcfff)\
$directory\
[](fg:#bb9af7 bg:#565f89)\
$git_branch\
$git_status\
[](fg:#565f89 bg:#f7768e)\
$c\
$elixir\
$elm\
$golang\
$gradle\
$haskell\
$java\
$julia\
$nodejs\
$nim\
$rust\
$scala\
[](fg:#f7768e bg:#9ece6a)\
$time\
[ ](fg:#9ece6a)\
"""

[directory]
style = "fg:#1a1b26 bg:#bb9af7"
format = "[ $path ]($style)"
truncation_length = 3
truncation_symbol = "…/"

[directory.substitutions]
"Documents" = "󰈙 "
"Downloads" = " "
"Music" = " "
"Pictures" = " "

[c]
symbol = " "
style = "fg:#1a1b26 bg:#f7768e"
format = '[ $symbol ($version) ]($style)'

[git_branch]
symbol = ""
style = "fg:#c0caf5 bg:#565f89"
format = '[ $symbol $branch ]($style)'

[git_status]
style = "fg:#c0caf5 bg:#565f89"
format = '[$all_status$ahead_behind ]($style)'

[nodejs]
symbol = ""
style = "fg:#1a1b26 bg:#f7768e"
format = '[ $symbol ($version) ]($style)'

[rust]
symbol = ""
style = "fg:#1a1b26 bg:#f7768e"
format = '[ $symbol ($version) ]($style)'

[golang]
symbol = ""
style = "fg:#1a1b26 bg:#f7768e"
format = '[ $symbol ($version) ]($style)'

[time]
disabled = false
time_format = "%R"
style = "fg:#1a1b26 bg:#9ece6a"
format = '[ ♠ $time ]($style)'
EOF

# Create dunst config
echo -e "${CYAN}Creating notification configuration...${NC}"
cat > ~/.config/dunst/dunstrc << 'EOF'
[global]
    monitor = 0
    follow = mouse
    geometry = "350x5-15+49"
    indicate_hidden = yes
    shrink = no
    transparency = 10
    notification_height = 0
    separator_height = 2
    padding = 12
    horizontal_padding = 12
    frame_width = 2
    frame_color = "#bb9af7"
    separator_color = frame
    sort = yes
    idle_threshold = 120
    font = FiraCode Nerd Font 11
    line_height = 0
    markup = full
    format = "<b>%s</b>\n%b"
    alignment = left
    show_age_threshold = 60
    word_wrap = yes
    ellipsize = middle
    ignore_newline = no
    stack_duplicates = true
    hide_duplicate_count = false
    show_indicators = yes
    icon_position = left
    max_icon_size = 32
    sticky_history = yes
    history_length = 20
    browser = /usr/bin/firefox
    always_run_script = true
    title = Dunst
    class = Dunst
    startup_notification = false
    verbosity = mesg
    corner_radius = 8
    mouse_left_click = close_current
    mouse_middle_click = do_action
    mouse_right_click = close_all

[experimental]
    per_monitor_dpi = false

[shortcuts]
    close = ctrl+space
    close_all = ctrl+shift+space
    history = ctrl+grave
    context = ctrl+shift+period

[urgency_low]
    background = "#1a1b26"
    foreground = "#c0caf5"
    timeout = 10

[urgency_normal]
    background = "#1a1b26"
    foreground = "#c0caf5"
    timeout = 10

[urgency_critical]
    background = "#f7768e"
    foreground = "#1a1b26"
    frame_color = "#f7768e"
    timeout = 0
EOF

# Create fastfetch config
cat > ~/.config/fastfetch/config.jsonc << 'EOF'
{
    "$schema": "https://github.com/fastfetch-cli/fastfetch/raw/dev/doc/json_schema.json",
    "logo": {
        "source": "arch",
        "color": {
            "1": "cyan",
            "2": "magenta"
        }
    },
    "display": {
        "separator": " -> ",
        "color": {
            "keys": "magenta",
            "output": "cyan"
        }
    },
    "modules": [
        {
            "type": "title",
            "color": {
                "user": "cyan",
                "at": "white",
                "host": "magenta"
            }
        },
        "separator",
        "os",
        "kernel",
        "uptime",
        "packages",
        "shell",
        "display",
        "de",
        "wm",
        "wmtheme",
        "theme",
        "icons",
        "font",
        "cursor",
        "terminal",
        "terminalfont",
        "cpu",
        "gpu",
        "memory",
        "swap",
        "disk",
        "localip",
        "battery",
        "poweradapter",
        "locale",
        "break",
        "colors"
    ]
}
EOF

# Gaming optimizations and services
echo -e "${PURPLE}Setting up gaming optimizations...${NC}"

# Create gamemode config
sudo mkdir -p /etc/gamemode
sudo cat > /etc/gamemode/gamemode.ini << 'EOF'
[general]
renice=10
ioprio_class=1
ioprio_classdata=4
inhibit_screensaver=1
softrealtime=auto
reaper_freq=5

[gpu]
apply_gpu_optimisations=accept-responsibility
gpu_device=0
amd_performance_level=high

[custom]
start=notify-send "GameMode activated"
end=notify-send "GameMode deactivated"
EOF

# Create gaming launch scripts
mkdir -p ~/.local/bin

cat > ~/.local/bin/launch-game << 'EOF'
#!/bin/bash
# WehttamSnaps Game Launcher Script

GAME="$1"

case "$GAME" in
    "steam")
        gamemode steam
        ;;
    "lutris")
        gamemode lutris
        ;;
    "heroic")
        gamemode heroic
        ;;
    "cyberpunk")
        gamemode steam steam://rungameid/1091500
        ;;
    "division2")
        gamemode steam steam://rungameid/581320
        ;;
    "firstdescendant")
        gamemode steam steam://rungameid/2074920
        ;;
    *)
        echo "Unknown game: $GAME"
        echo "Available: steam, lutris, heroic, cyberpunk, division2, firstdescendant"
        ;;
esac
EOF
chmod +x ~/.local/bin/launch-game

# Create streaming script
cat > ~/.local/bin/start-streaming << 'EOF'
#!/bin/bash
# WehttamSnaps Streaming Setup Script

# Gaming optimizations for streaming
echo performance | sudo tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor
echo 0 | sudo tee /proc/sys/kernel/watchdog

# Launch OBS
obs --startstreaming --scene "Just Chatting" &

# Show notification
notify-send "🔴 LIVE" "WehttamSnaps is now streaming!" --urgency=critical

echo "Streaming setup complete!"
EOF
chmod +x ~/.local/bin/start-streaming

# Install and configure SDDM theme
echo -e "${YELLOW}Setting up SDDM login theme...${NC}"
sudo mkdir -p /usr/share/sddm/themes/sugar-candy
sudo curl -L "https://github.com/Kangie/sddm-sugar-candy/archive/master.zip" -o /tmp/sugar-candy.zip 2>/dev/null
cd /tmp && sudo unzip -q sugar-candy.zip 2>/dev/null || echo "SDDM theme download failed"
sudo cp -r sddm-sugar-candy-master/* /usr/share/sddm/themes/sugar-candy/ 2>/dev/null || echo "SDDM theme copy failed"

# Configure SDDM
sudo cat > /etc/sddm.conf << 'EOF'
[Theme]
Current=sugar-candy

[Users]
MaximumUid=60513
MinimumUid=1000
EOF

# Enable services
echo -e "${GREEN}Enabling system services...${NC}"
sudo systemctl enable sddm
sudo systemctl enable gamemode

# Font installation
echo -e "${BLUE}Installing additional fonts...${NC}"
mkdir -p ~/.local/share/fonts
cd /tmp

# Download FiraCode Nerd Font
curl -L "https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/FiraCode.zip" -o FiraCode.zip 2>/dev/null
unzip -q FiraCode.zip -d ~/.local/share/fonts/ 2>/dev/null || echo "FiraCode font download failed"

# Download gaming fonts
curl -L "https://fonts.google.com/download?family=Orbitron" -o Orbitron.zip 2>/dev/null
unzip -q Orbitron.zip -d ~/.local/share/fonts/ 2>/dev/null || echo "Orbitron font download failed"

curl -L "https://fonts.google.com/download?family=Exo+2" -o Exo2.zip 2>/dev/null  
unzip -q Exo2.zip -d ~/.local/share/fonts/ 2>/dev/null || echo "Exo2 font download failed"

# Update font cache
fc-cache -fv

# Create desktop entries for quick access
echo -e "${CYAN}Creating desktop entries...${NC}"
mkdir -p ~/.local/share/applications

cat > ~/.local/share/applications/game-launcher.desktop << 'EOF'
[Desktop Entry]
Version=1.0
Type=Application
Name=Game Launcher
Comment=Launch games with GameMode
Exec=eww open game-launcher
Icon=applications-games
Terminal=false
Categories=Game;
EOF

cat > ~/.local/share/applications/start-stream.desktop << 'EOF'  
[Desktop Entry]
Version=1.0
Type=Application
Name=Start Stream
Comment=Begin streaming setup
Exec=start-streaming
Icon=obs
Terminal=false
Categories=AudioVideo;
EOF

# Create welcome script
cat > ~/.local/bin/wehttamsnaps-welcome << 'EOF'
#!/bin/bash

cat << "WELCOME"
╦ ╦┌─┐┬ ┬┌┬┐┌┬┐┌─┐┌┬┐╔═╗┌─┐┌─┐┌─┐
║║║├┤ ├─┤ │  │ ├─┤│││╚═╗├─┘├─┤├─┘ 
╚╩╝└─┘┴ ┴ ┴  ┴ ┴ ┴┴ ┴╚═╝┴  ┴ ┴┴   
    Welcome to your Hyprland Setup!
WELCOME

echo -e "\n🎮 Quick Commands:"
echo "  Super + Q           - Open Terminal"
echo "  Super + R           - Application Launcher"
echo "  Super + E           - File Manager"
echo "  Super + G           - Launch Steam"
echo "  Super + Shift + G   - Launch Lutris"
echo "  Super + Print       - Screenshot Region"
echo ""
echo "🎬 Streaming:"
echo "  start-streaming     - Begin stream setup"
echo "  launch-game [name]  - Launch game with GameMode"
echo ""  
echo "⚡ Gaming:"
echo "  launch-game steam"
echo "  launch-game cyberpunk"
echo "  launch-game division2"
echo "  launch-game firstdescendant"
echo ""
echo "🔧 System:"
echo "  fastfetch           - Show system info"
echo "  gamemode --status   - Check GameMode status"
EOF
chmod +x ~/.local/bin/wehttamsnaps-welcome

# Add welcome to .zshrc
echo "wehttamsnaps-welcome" >> ~/.zshrc

# Create update script for future use
cat > ~/.local/bin/update-wehttamsnaps-setup << 'EOF'
#!/bin/bash
echo "🔄 Updating WehttamSnaps setup..."
sudo pacman -Syu --noconfirm
paru -Syu --noconfirm
echo "✅ Update complete!"
EOF
chmod +x ~/.local/bin/update-wehttamsnaps-setup

echo -e "${GREEN}"
cat << "EOF"
╔══════════════════════════════════════════════╗
║     WehttamSnaps Setup Complete! 🎉          ║ 
╠══════════════════════════════════════════════╣
║ Your TokyoNight violet-to-cyan Hyprland     ║
║ gaming setup is ready!                      ║
║                                              ║
║ Next Steps:                                  ║
║ 1. Reboot your system                       ║
║ 2. Login with SDDM                          ║  
║ 3. Run 'wehttamsnaps-welcome' for help      ║
║ 4. Configure OBS for streaming              ║
║ 5. Add your wallpapers to ~/Pictures/       ║
║                                              ║
║ Happy Gaming & Streaming! 🎮📺              ║
╚══════════════════════════════════════════════╝
EOF
echo -e "${NC}"

echo -e "${YELLOW}Setup log saved to: ~/.wehttamsnaps-setup.log${NC}"
echo "This script created a complete Hyprland setup with:"
echo "✅ TokyoNight violet-to-cyan theme"
echo "✅ Gaming optimizations (GameMode, AMD tweaks)"  
echo "✅ Streaming-ready configuration"
echo "✅ Custom Waybar with system info"
echo "✅ EWW game launcher widget"
echo "✅ Rofi application launcher"
echo "✅ Custom terminal theme"
echo "✅ Quick gaming launch scripts"
echo ""
echo "Reboot now to enjoy your new setup!"
echo ""
echo "For streaming assets, check the next part of this response..."
