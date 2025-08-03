# SwayFX Configuration - TokyoNight Gaming Setup
# ~/.config/sway/config
# Matt's Custom Configuration (@Crowdrocker)

### Variables
#
# Logo key. Use Mod1 for Alt.
set $mod Mod4

# Home row direction keys, like vim
set $left h
set $down j
set $up k
set $right l

# Your preferred terminal emulator
set $term alacritty

# Your preferred application launcher
set $menu rofi -show drun -theme ~/.config/rofi/tokyonight.rasi

# TokyoNight Color Scheme
set $bg-primary #1a1b26
set $bg-secondary #24283b
set $bg-surface #414868
set $text-primary #c0caf5
set $text-secondary #9aa5ce
set $accent-blue #7aa2f7
set $accent-purple #bb9af7
set $accent-cyan #7dcfff
set $accent-green #9ece6a
set $accent-red #f7768e
set $accent-orange #ff9e64

### Output configuration
#
# Default wallpaper (more resolutions are available in /usr/share/backgrounds/sway/)
output * bg ~/.config/sway/wallpapers/tokyonight-city.jpg fill

# Monitor configuration
# Adjust these for your setup
output HDMI-A-1 resolution 1920x1080 position 1920,0
output DP-1 resolution 1920x1080 position 0,0

### Idle configuration
#
exec swayidle -w \
         timeout 300 'swaylock -f -c $bg-primary' \
         timeout 600 'swaymsg "output * power off"' resume 'swaymsg "output * power on"' \
         before-sleep 'swaylock -f -c $bg-primary'

### Input configuration
#
input "type:touchpad" {
    dwt enabled
    tap enabled
    natural_scroll enabled
    middle_emulation enabled
}

input "type:keyboard" {
    xkb_layout us
    xkb_variant ,nodeadkeys
    xkb_options grp:alt_shift_toggle
}

### SwayFX specific configurations
#
# Enable blur
blur enable
blur_xray disable
blur_passes 3
blur_radius 8

# Enable shadows
shadows enable
shadows_on_csd enable
shadow_blur_radius 20
shadow_color $bg-primary

# Corner radius
corner_radius 12

# Window dimming
default_dim_inactive 0.1
dim_inactive_colors.unfocused $bg-secondary
dim_inactive_colors.urgent $accent-red

# Layer shell effects
layer_effects "waybar" blur enable; shadows enable; corner_radius 12
layer_effects "rofi" blur enable; shadows enable; corner_radius 16
layer_effects "notifications" blur enable; shadows enable; corner_radius 12

### Key bindings
#
# Basics:
#
    # Start a terminal
    bindsym $mod+Return exec $term

    # Kill focused window
    bindsym $mod+Shift+q kill

    # Start your launcher
    bindsym $mod+d exec $menu

    # Drag floating windows by holding down $mod and left mouse button.
    # Resize them with right mouse button + $mod.
    # Despite the name, also works for non-floating windows.
    # Change normal to inverse to use left mouse button for resizing and right
    # mouse button for dragging.
    floating_modifier $mod normal

    # Reload the configuration file
    bindsym $mod+Shift+c reload

    # Exit sway (logs you out of your Wayland session)
    bindsym $mod+Shift+e exec swaynag -t warning -m 'You pressed the exit shortcut. Do you really want to exit sway? This will end your Wayland session.' -B 'Yes, exit sway' 'swaymsg exit'

# Moving around:
#
    # Move your focus around
    bindsym $mod+$left focus left
    bindsym $mod+$down focus down
    bindsym $mod+$up focus up
    bindsym $mod+$right focus right
    # Or use $mod+[up|down|left|right]
    bindsym $mod+Left focus left
    bindsym $mod+Down focus down
    bindsym $mod+Up focus up
    bindsym $mod+Right focus right

    # Move the focused window with the same, but add Shift
    bindsym $mod+Shift+$left move left
    bindsym $mod+Shift+$down move down
    bindsym $mod+Shift+$up move up
    bindsym $mod+Shift+$right move right
    # Ditto, with arrow keys
    bindsym $mod+Shift+Left move left
    bindsym $mod+Shift+Down move down
    bindsym $mod+Shift+Up move up
    bindsym $mod+Shift+Right move right

# Workspaces:
#
    # Switch to workspace
    bindsym $mod+1 workspace number 1:Terminal
    bindsym $mod+2 workspace number 2:Web
    bindsym $mod+3 workspace number 3:Creative
    bindsym $mod+4 workspace number 4:Gaming
    bindsym $mod+5 workspace number 5:Music
    bindsym $mod+6 workspace number 6:Files
    bindsym $mod+7 workspace number 7:Social
    bindsym $mod+8 workspace number 8:VM
    bindsym $mod+9 workspace number 9:Monitor
    bindsym $mod+0 workspace number 10:Misc

    # Move focused container to workspace
    bindsym $mod+Shift+1 move container to workspace number 1:Terminal
    bindsym $mod+Shift+2 move container to workspace number 2:Web
    bindsym $mod+Shift+3 move container to workspace number 3:Creative
    bindsym $mod+Shift+4 move container to workspace number 4:Gaming
    bindsym $mod+Shift+5 move container to workspace number 5:Music
    bindsym $mod+Shift+6 move container to workspace number 6:Files
    bindsym $mod+Shift+7 move container to workspace number 7:Social
    bindsym $mod+Shift+8 move container to workspace number 8:VM
    bindsym $mod+Shift+9 move container to workspace number 9:Monitor
    bindsym $mod+Shift+0 move container to workspace number 10:Misc

# Layout stuff:
#
    # You can "split" the current object of your focus with
    # $mod+b or $mod+v, for horizontal and vertical splits
    # respectively.
    bindsym $mod+b splith
    bindsym $mod+v splitv

    # Switch the current container between different layout styles
    bindsym $mod+s layout stacking
    bindsym $mod+w layout tabbed
    bindsym $mod+e layout toggle split

    # Make the current focus fullscreen
    bindsym $mod+f fullscreen

    # Toggle the current focus between tiling and floating mode
    bindsym $mod+Shift+space floating toggle

    # Swap focus between the tiling area and the floating area
    bindsym $mod+space focus mode_toggle

    # Move focus to the parent container
    bindsym $mod+a focus parent

# Scratchpad:
#
    # Sway has a "scratchpad", which is a bag of holding for windows.
    # You can send windows there and get them back later.

    # Move the currently focused window to the scratchpad
    bindsym $mod+Shift+minus move scratchpad

    # Show the next scratchpad window or hide the focused scratchpad window.
    # If there are multiple scratchpad windows, this command cycles through them.
    bindsym $mod+minus scratchpad show

# Resizing containers:
#
mode "resize" {
    # left will shrink the containers width
    # right will grow the containers width
    # up will shrink the containers height
    # down will grow the containers height
    bindsym $left resize shrink width 10px
    bindsym $down resize grow height 10px
    bindsym $up resize shrink height 10px
    bindsym $right resize grow width 10px

    # Ditto, with arrow keys
    bindsym Left resize shrink width 10px
    bindsym Down resize grow height 10px
    bindsym Up resize shrink height 10px
    bindsym Right resize grow width 10px

    # Return to default mode
    bindsym Return mode "default"
    bindsym Escape mode "default"
}
bindsym $mod+r mode "resize"

# Custom Gaming & Creative Keybindings
#
    # Gaming Mode Toggle
    bindsym $mod+g exec ~/.config/eww/scripts/toggle_gaming_mode.sh

    # Launch Game Launcher
    bindsym $mod+Shift+g exec eww open gamelauncher

    # Close Game Launcher
    bindsym $mod+Escape exec eww close gamelauncher

    # Quick game launches
    bindsym $mod+F1 exec ~/.config/eww/scripts/launch_game.sh division2
    bindsym $mod+F2 exec ~/.config/eww/scripts/launch_game.sh descendant
    bindsym $mod+F3 exec ~/.config/eww/scripts/launch_game.sh cyberpunk

    # Creative workspace shortcuts
    bindsym $mod+p workspace number 3:Creative; exec gimp &
    bindsym $mod+Shift+p workspace number 3:Creative; exec resolve &

    # File manager
    bindsym $mod+n exec thunar

    # Screenshots
    bindsym Print exec grim -g "$(slurp)" - | wl-copy
    bindsym $mod+Print exec grim ~/Pictures/screenshot-$(date +%Y%m%d_%H%M%S).png

    # Audio controls
    bindsym XF86AudioRaiseVolume exec pactl set-sink-volume @DEFAULT_SINK@ +5%
    bindsym XF86AudioLowerVolume exec pactl set-sink-volume @DEFAULT_SINK@ -5%
    bindsym XF86AudioMute exec pactl set-sink-mute @DEFAULT_SINK@ toggle
    bindsym XF86AudioMicMute exec pactl set-source-mute @DEFAULT_SOURCE@ toggle

    # Brightness controls
    bindsym XF86MonBrightnessUp exec brightnessctl set +10%
    bindsym XF86MonBrightnessDown exec brightnessctl set 10%-

    # Lock screen
    bindsym $mod+l exec swaylock -f -c $bg-primary

    # Power menu
    bindsym $mod+Shift+p exec ~/.config/rofi/scripts/powermenu.sh

    # Theme switcher
    bindsym $mod+t exec ~/.config/scripts/theme_switcher.sh

# Window rules and assignments
#
    # Gaming workspace assignments
    assign [app_id="steam"] workspace number 4:Gaming
    assign [class="steam"] workspace number 4:Gaming
    assign [app_id="lutris"] workspace number 4:Gaming
    assign [class="heroic"] workspace number 4:Gaming

    # Creative workspace assignments
    assign [app_id="gimp"] workspace number 3:Creative
    assign [class="Gimp"] workspace number 3:Creative
    assign [class="resolve"] workspace number 3:Creative
    assign [app_id="blender"] workspace number 3:Creative

    # Web workspace
    assign [app_id="firefox"] workspace number 2:Web
    assign [class="firefox"] workspace number 2:Web
    assign [app_id="chromium"] workspace number 2:Web

    # File manager
    assign [app_id="thunar"] workspace number 6:Files

    # Floating windows
    for_window [app_id="pavucontrol"] floating enable
    for_window [app_id="nwg-look"] floating enable
    for_window [app_id="azote"] floating enable
    for_window [title="Picture-in-Picture"] floating enable, sticky enable

    # Gaming optimizations
    for_window [workspace="4:Gaming"] inhibit_idle fullscreen

# Colors and theming
#
# Window borders and colors                border              background          text                indicator           child_border
client.focused                            $accent-blue        $accent-blue        $bg-primary         $accent-purple      $accent-blue
client.focused_inactive                   $bg-surface         $bg-surface         $text-secondary     $bg-surface         $bg-surface
client.unfocused                          $bg-secondary       $bg-secondary       $text-secondary     $bg-secondary       $bg-secondary
client.urgent                             $accent-red         $accent-red         $bg-primary         $accent-red         $accent-red

# Window settings
default_border pixel 2
default_floating_border pixel 2
hide_edge_borders smart
gaps inner 8
gaps outer 4

# Smart gaps (no gaps when only one window)
smart_gaps on
smart_borders on

# Font
font pango:JetBrains Mono Nerd Font 10

# Autostart applications
#
exec_always --no-startup-id {
    # Kill existing processes
    pkill waybar; pkill eww; pkill dunst

    # Start status bar
    waybar &
    
    # Start notification daemon
    dunst &
    
    # Start EWW widgets
    eww daemon &
    sleep 2
    eww open gaming-mode-toggle &
    eww open performance-monitor &
    
    # Start welcome app
    python3 ~/.config/sway/scripts/tokyonight_welcome.py &
    
    # Audio server
    pulseaudio --start &
    
    # Network manager applet
    nm-applet --indicator &
    
    # Bluetooth manager
    blueman-applet &
    
    # Auto-tiling script
    autotiling &
    
    # Clipboard manager
    wl-paste --type text --watch cliphist store &
    wl-paste --type image --watch cliphist store &
}

# AMD GPU optimizations for gaming
exec_always --no-startup-id {
    # Set AMD GPU power profile to high for gaming
    echo "high" | sudo tee /sys/class/drm/card0/device/power_dpm_force_performance_level
    
    # Enable ACO compiler for RADV
    export RADV_PERFTEST=aco
    
    # Enable async DXVK
    export DXVK_ASYNC=1
    
    # Vulkan optimizations
    export AMD_VULKAN_ICD=RADV
    export RADV_DEBUG=nohiz,norbplus
}

# Include additional config files
include /etc/sway/config.d/*
include ~/.config/sway/config.d/*
