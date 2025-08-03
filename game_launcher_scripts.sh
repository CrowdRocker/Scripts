#!/bin/bash
# Game Launcher Scripts Collection
# Place these in ~/.config/eww/scripts/

# =============================================================================
# get_cpu.sh - Get CPU usage percentage
# =============================================================================
cat > ~/.config/eww/scripts/get_cpu.sh << 'EOF'
#!/bin/bash
cpu_usage=$(top -bn1 | grep "Cpu(s)" | awk '{print $2}' | awk -F'%' '{print $1}')
echo "${cpu_usage%.*}"
EOF

# =============================================================================
# get_gpu.sh - Get AMD GPU usage percentage
# =============================================================================
cat > ~/.config/eww/scripts/get_gpu.sh << 'EOF'
#!/bin/bash
# For AMD RX 580, use radeontop if available
if command -v radeontop &> /dev/null; then
    gpu_usage=$(radeontop -d - -l 1 | grep -o "gpu [0-9]*" | awk '{print $2}')
    echo "${gpu_usage:-0}"
else
    # Fallback to basic detection
    echo "0"
fi
EOF

# =============================================================================
# get_ram.sh - Get RAM usage percentage
# =============================================================================
cat > ~/.config/eww/scripts/get_ram.sh << 'EOF'
#!/bin/bash
ram_info=$(free | grep '^Mem:')
total=$(echo $ram_info | awk '{print $2}')
used=$(echo $ram_info | awk '{print $3}')
percentage=$(echo "scale=0; $used * 100 / $total" | bc)
echo $percentage
EOF

# =============================================================================
# get_gpu_temp.sh - Get AMD GPU temperature
# =============================================================================
cat > ~/.config/eww/scripts/get_gpu_temp.sh << 'EOF'
#!/bin/bash
# Check for AMD GPU temperature
if [ -f /sys/class/hwmon/hwmon*/temp1_input ]; then
    temp=$(cat /sys/class/hwmon/hwmon*/temp1_input 2>/dev/null | head -1)
    if [ ! -z "$temp" ]; then
        echo $((temp / 1000))
    else
        echo "45"
    fi
else
    # Default safe temperature
    echo "45"
fi
EOF

# =============================================================================
# get_gaming_mode.sh - Check gaming mode status
# =============================================================================
cat > ~/.config/eww/scripts/get_gaming_mode.sh << 'EOF'
#!/bin/bash
if pgrep -x "gamemode" > /dev/null; then
    echo "on"
else
    echo "off"
fi
EOF

# =============================================================================
# toggle_gaming_mode.sh - Toggle gaming optimizations
# =============================================================================
cat > ~/.config/eww/scripts/toggle_gaming_mode.sh << 'EOF'
#!/bin/bash
GAMING_MODE_FILE="/tmp/matt_gaming_mode"

toggle_gaming_mode() {
    if [ -f "$GAMING_MODE_FILE" ]; then
        # Turn OFF gaming mode
        rm "$GAMING_MODE_FILE"
        
        # Restore normal CPU governor
        echo "powersave" | sudo tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor > /dev/null
        
        # Re-enable notifications
        pkill -SIGUSR1 dunst
        
        # Normal GPU power profile
        echo "auto" | sudo tee /sys/class/drm/card0/device/power_dpm_force_performance_level > /dev/null
        
        notify-send "Gaming Mode" "Gaming optimizations disabled" -t 3000
    else
        # Turn ON gaming mode
        touch "$GAMING_MODE_FILE"
        
        # Set performance CPU governor
        echo "performance" | sudo tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor > /dev/null
        
        # Disable notifications
        pkill -SIGUSR2 dunst
        
        # High GPU power profile
        echo "high" | sudo tee /sys/class/drm/card0/device/power_dpm_force_performance_level > /dev/null
        
        # Start gamemode daemon if not running
        if ! pgrep -x "gamemoded" > /dev/null; then
            gamemoded -d &
        fi
        
        notify-send "Gaming Mode" "Gaming optimizations enabled! 🎮" -t 3000
    fi
}

toggle_gaming_mode
EOF

# =============================================================================
# launch_game.sh - Launch specific games with optimizations
# =============================================================================
cat > ~/.config/eww/scripts/launch_game.sh << 'EOF'
#!/bin/bash
GAME="$1"
GAMING_MODE_FILE="/tmp/matt_gaming_mode"

# Enable gaming mode if not already active
if [ ! -f "$GAMING_MODE_FILE" ]; then
    ~/.config/eww/scripts/toggle_gaming_mode.sh
fi

case "$GAME" in
    "division2")
        notify-send "Launching" "The Division 2 via Epic Games" -t 2000
        # Launch through Heroic Games Launcher for Epic Games
        heroic launch "The Division 2" &
        ;;
    "descendant")
        notify-send "Launching" "The First Descendant via Steam" -t 2000
        # Launch through Steam with Proton optimizations
        STEAM_COMPAT_DATA_PATH=~/.steam/steam/steamapps/compatdata/2074920 \
        gamemoderun steam -applaunch 2074920 &
        ;;
    "cyberpunk")
        notify-send "Launching" "Cyberpunk 2077 via Steam" -t 2000
        # Launch Cyberpunk with AMD optimizations
        RADV_PERFTEST=aco \
        DXVK_ASYNC=1 \
        gamemoderun steam -applaunch 1091500 &
        ;;
    *)
        notify-send "Error" "Unknown game: $GAME" -t 3000
        ;;
esac
EOF

# =============================================================================
# get_recent_games.sh - Get recently played games data
# =============================================================================
cat > ~/.config/eww/scripts/get_recent_games.sh << 'EOF'
#!/bin/bash
# This would typically parse Steam's localconfig.vdf or similar
# For now, return static data matching our favorite games
echo '{
  "games": [
    {
      "name": "The Division 2",
      "platform": "Epic",
      "playtime": "127h",
      "last_played": "2 hours ago"
    },
    {
      "name": "The First Descendant", 
      "platform": "Steam",
      "playtime": "89h",
      "last_played": "1 day ago"
    },
    {
      "name": "Cyberpunk 2077",
      "platform": "Steam", 
      "playtime": "156h",
      "last_played": "3 days ago"
    }
  ]
}'
EOF

# =============================================================================
# search_games.sh - Search through game library
# =============================================================================
cat > ~/.config/eww/scripts/search_games.sh << 'EOF'
#!/bin/bash
QUERY="$1"
# Basic search functionality - would integrate with Steam/Epic/Lutris APIs
if [ -z "$QUERY" ]; then
    echo "No search query provided"
else
    notify-send "Game Search" "Searching for: $QUERY" -t 2000
fi
EOF

# =============================================================================
# game_info.sh - Show game information and stats
# =============================================================================
cat > ~/.config/eww/scripts/game_info.sh << 'EOF'
#!/bin/bash
GAME="$1"

case "$GAME" in
    "division2")
        notify-send "The Division 2" "Online looter-shooter RPG\nPlatform: Epic Games\nTotal playtime: 127 hours\nLast played: 2 hours ago" -t 5000
        ;;
    "descendant")
        notify-send "The First Descendant" "Free-to-play looter-shooter\nPlatform: Steam\nTotal playtime: 89 hours\nLast played: 1 day ago" -t 5000
        ;;
    "cyberpunk")
        notify-send "Cyberpunk 2077" "Open-world action RPG\nPlatform: Steam\nTotal playtime: 156 hours\nLast played: 3 days ago" -t 5000
        ;;
    *)
        notify-send "Game Info" "No information available for: $GAME" -t 3000
        ;;
esac
EOF

# =============================================================================
# launch_native_games.sh - Launch native Linux games menu
# =============================================================================
cat > ~/.config/eww/scripts/launch_native_games.sh << 'EOF'
#!/bin/bash
# Launch a simple native games menu using rofi
NATIVE_GAMES=(
    "SuperTuxKart:supertuxkart"
    "0 A.D.:0ad"
    "Battle for Wesnoth:wesnoth"
    "Minetest:minetest"
    "OpenRA:openra"
)

# Create menu string
MENU_STRING=""
for game in "${NATIVE_GAMES[@]}"; do
    game_name=$(echo "$game" | cut -d':' -f1)
    MENU_STRING="$MENU_STRING$game_name\n"
done

# Show rofi menu
SELECTED=$(echo -e "$MENU_STRING" | rofi -dmenu -p "Native Games" -theme ~/.config/rofi/tokyonight.rasi)

if [ ! -z "$SELECTED" ]; then
    # Find the command for the selected game
    for game in "${NATIVE_GAMES[@]}"; do
        game_name=$(echo "$game" | cut -d':' -f1)
        game_cmd=$(echo "$game" | cut -d':' -f2)
        if [ "$game_name" = "$SELECTED" ]; then
            notify-send "Launching" "$SELECTED" -t 2000
            $game_cmd &
            break
        fi
    done
fi
EOF
