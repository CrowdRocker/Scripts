# EWW Gaming Widget & OBS Scene Configuration

## EWW Gaming Launcher Widget

### Widget Structure
```scss
// ~/.config/eww/gaming-launcher/gaming-launcher.scss
.gaming-launcher {
  background: rgba(30, 30, 46, 0.95);
  border-radius: 15px;
  border: 2px solid rgba(137, 180, 250, 0.3);
  padding: 20px;
  margin: 10px;
}

.launcher-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 15px;
  
  .title {
    font-size: 18px;
    font-weight: bold;
    color: #cdd6f4;
  }
  
  .system-stats {
    font-size: 12px;
    color: #a6adc8;
  }
}

.game-grid {
  display: grid;
  grid-template-columns: repeat(4, 1fr);
  gap: 15px;
  margin-bottom: 20px;
}

.game-item {
  display: flex;
  flex-direction: column;
  align-items: center;
  padding: 10px;
  border-radius: 10px;
  transition: all 0.3s ease;
  cursor: pointer;
  
  &:hover {
    background: rgba(137, 180, 250, 0.1);
    transform: translateY(-2px);
  }
  
  .game-icon {
    width: 48px;
    height: 48px;
    border-radius: 8px;
    margin-bottom: 8px;
  }
  
  .game-name {
    font-size: 12px;
    text-align: center;
    color: #cdd6f4;
  }
  
  .platform-badge {
    font-size: 10px;
    padding: 2px 6px;
    border-radius: 4px;
    margin-top: 4px;
    
    &.steam { background: #1e2328; color: #66c0f4; }
    &.lutris { background: #2d1b69; color: #ffa500; }
    &.heroic { background: #0f1419; color: #00d4ff; }
  }
}

.quick-tools {
  display: flex;
  justify-content: space-around;
  padding-top: 15px;
  border-top: 1px solid rgba(137, 180, 250, 0.2);
  
  .tool-button {
    padding: 8px 12px;
    border-radius: 8px;
    background: rgba(137, 180, 250, 0.1);
    color: #cdd6f4;
    border: none;
    cursor: pointer;
    font-size: 12px;
    
    &:hover {
      background: rgba(137, 180, 250, 0.2);
    }
    
    &.active {
      background: #89b4fa;
      color: #1e1e2e;
    }
  }
}
```

### Widget Configuration
```lisp
;; ~/.config/eww/gaming-launcher/eww.yuck
(defwidget gaming-launcher []
  (box :class "gaming-launcher"
       :orientation "v"
    (box :class "launcher-header"
      (label :class "title" :text "Gaming Hub")
      (box :class "system-stats"
        (label :text "${cpu-usage}% CPU | ${gpu-temp}°C GPU")))
    
    (box :class "recent-games"
         :orientation "v"
      (label :text "Recently Played" :class "section-title")
      (box :class "game-grid"
        (for game in recent-games
          (button :class "game-item"
                  :onclick "scripts/launch-game.sh '${game.command}'"
            (image :class "game-icon" :path "${game.icon}")
            (label :class "game-name" :text "${game.name}")
            (label :class "platform-badge ${game.platform}" :text "${game.platform}")))))
    
    (box :class "all-platforms"
         :orientation "v"
      (label :text "Platforms" :class "section-title")
      (box :class "game-grid"
        (button :class "game-item" :onclick "steam"
          (image :class "game-icon" :path "~/.config/eww/icons/steam.png")
          (label :class "game-name" :text "Steam"))
        
        (button :class "game-item" :onclick "lutris"
          (image :class "game-icon" :path "~/.config/eww/icons/lutris.png")
          (label :class "game-name" :text "Lutris"))
        
        (button :class "game-item" :onclick "heroic"
          (image :class "game-icon" :path "~/.config/eww/icons/heroic.png")
          (label :class "game-name" :text "Heroic"))
        
        (button :class "game-item" :onclick "spotify"
          (image :class "game-icon" :path "~/.config/eww/icons/spotify.png")
          (label :class "game-name" :text "Spotify"))))
    
    (box :class "quick-tools"
      (button :class "tool-button gamemode-toggle"
              :onclick "scripts/toggle-gamemode.sh"
              :text "GameMode")
      (button :class "tool-button performance-toggle"
              :onclick "scripts/toggle-performance.sh"  
              :text "Performance")
      (button :class "tool-button stream-toggle"
              :onclick "scripts/toggle-streaming.sh"
              :text "Stream Mode"))))

;; Window definition
(defwindow gaming-launcher
  :monitor 0
  :geometry (geometry :x "20px" :y "20px" :width "400px" :height "600px")
  :stacking "overlay"
  :reserve (struts :distance "40px" :side "left")
  :windowtype "dock"
  :wm-ignore false
  (gaming-launcher))
```

## OBS Scene Structure & Templates

### Scene Layout Plan
```
├── MAIN SCENES
│   ├── Just Chatting
│   │   ├── Webcam (720p, centered)
│   │   ├── Chat overlay (right side)
│   │   ├── Background (GIMP template)
│   │   └── Audio visualizer
│   │
│   └── Game Play
│       ├── Game capture (fullscreen)
│       ├── Webcam (small, corner)
│       ├── Chat overlay (minimal)
│       ├── MangoHud overlay
│       └── Game audio + mic
│
├── AFK SCENES
│   ├── Start Scene
│   │   ├── Animated logo/intro
│   │   ├── "Stream Starting Soon"
│   │   ├── Countdown timer
│   │   └── Background music
│   │
│   ├── Intermission
│   │   ├── "Taking a Break"
│   │   ├── Chat overlay
│   │   ├── Background playlist
│   │   └── Return timer
│   │
│   ├── BRB Scene  
│   │   ├── "Be Right Back"
│   │   ├── Animated background
│   │   └── Chat overlay
│   │
│   └── End Scene
│       ├── "Thanks for Watching"
│       ├── Follow/Subscribe prompts
│       ├── Credits roll
│       └── Outro music
│
└── NESTED SCENES
    ├── Audio
    │   ├── Microphone (with noise gate)
    │   ├── Desktop audio
    │   ├── Game audio
    │   ├── Music/background
    │   └── Alert sounds
    │
    └── Screens
        ├── Primary display capture
        ├── Game capture source
        ├── Webcam source
        └── Browser sources (chat, alerts)
```

### GIMP Template Specifications

#### Base Canvas Settings
- **Resolution**: 1920x1080 (1080p)
- **Color Mode**: RGB
- **Background**: Transparent PNG for overlays

#### Template Files to Create
```
~/obs-templates/
├── backgrounds/
│   ├── just-chatting-bg.xcf
│   ├── gaming-overlay-bg.xcf
│   ├── intermission-bg.xcf
│   └── brb-bg.xcf
├── overlays/
│   ├── webcam-frame.png
│   ├── chat-background.png
│   ├── alert-frame.png
│   └── social-banner.png
└── logos/
    ├── stream-logo.png
    ├── game-logos/
    └── social-icons/
```

### OBS Hotkey Setup
```
Scene Switching:
F1 - Just Chatting
F2 - Game Play  
F3 - BRB Scene
F4 - Intermission
F5 - Start Scene
F6 - End Scene

Quick Actions:
F7 - Toggle GameMode overlay
F8 - Mute/Unmute Mic
F9 - Start/Stop Recording
F10 - Start/Stop Stream
```

### Helper Scripts

#### Launch Game Script
```bash
#!/bin/bash
# ~/.config/eww/scripts/launch-game.sh

GAME_COMMAND="$1"

# Enable GameMode
gamemode-launch() {
    gamemoderun $GAME_COMMAND
}

# Switch to game scene in OBS if streaming
if pgrep obs > /dev/null; then
    # Use obs-cli or websocket to switch scene
    echo "Switching to Game Play scene"
fi

# Launch game
gamemode-launch &
```

#### Performance Toggle Script  
```bash
#!/bin/bash
# ~/.config/eww/scripts/toggle-performance.sh

if [[ $(powerprofilesctl get) == "performance" ]]; then
    powerprofilesctl set balanced
    notify-send "Performance Mode" "Switched to Balanced"
else
    powerprofilesctl set performance
    notify-send "Performance Mode" "Switched to Performance"
fi
```

### Integration Notes
- EWW widgets can trigger OBS scene changes via OBS WebSocket
- Use MangoHud for in-game performance overlay
- Create modular overlays in GIMP that can be mixed and matched
- Set up hotkeys for quick scene switching during gameplay
- Use nested scenes for easy audio/video source management
