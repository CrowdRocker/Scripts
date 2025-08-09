#!/bin/bash

# WehttamSnaps OBS Studio Configuration Script
# Creates complete streaming setup with scenes and optimizations

set -e

USERNAME=$(whoami)
USER_HOME="/home/$USERNAME"
OBS_CONFIG="$USER_HOME/.config/obs-studio"

# Colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
NC='\033[0m'

echo -e "${PURPLE}🎬 Setting up WehttamSnaps OBS Studio Configuration${NC}"

# Create OBS config directories
mkdir -p "$OBS_CONFIG"/{basic/scenes,basic/profiles/WehttamSnaps,plugin_config}

# Create optimized OBS profile for AMD RX 580
cat > "$OBS_CONFIG/basic/profiles/WehttamSnaps/basic.ini" << 'EOF'
[AdvOut]
FFOutputToFile=true
FFFilePath=/home/wehttamsnaps/Videos
FFFormat=
FFFormatMimeType=
FFVEncoder=h264_nvenc
FFVRescale=false
FFVRescaleRes=1280x720
FFVBitrate=2500
FFVGOPSize=120
FFVColorRange=1
FFVColorSpace=1
FFVTonemap=0
FFVRC=CBR
FFVCustom=
FFAEncoder=aac
FFABitrate=160
FFACustom=
FFAMixes=1

RecFormat=mp4
RecEncoder=x264
RecRescale=false
RecRescaleRes=1920x1080
RecColorRange=1
RecColorSpace=1
RecTracks=1
RecMuxerCustom=
RecCustom=
RecRB=false
RecRBTime=20
RecRBSize=512
RecQuality=0
RecDir=/home/wehttamsnaps/Videos

[Output]
Mode=Advanced

[Video]
BaseCX=1920
BaseCY=1080
OutputCX=1920
OutputCY=1080
FPSType=0
FPSCommon=60/1
ScaleType=bicubic
ColorFormat=NV12
ColorSpace=709
ColorRange=1

[Audio]
SampleRate=48000
ChannelSetup=Stereo

[Stream1]
Server=rtmp://live.twitch.tv/live
key=YOUR_STREAM_KEY_HERE
EOF

# Create scene collection with all required scenes
cat > "$OBS_CONFIG/basic/scenes/WehttamSnaps.json" << 'EOF'
{
    "current_scene": "🎮 Gameplay",
    "current_program_scene": "🎮 Gameplay", 
    "scene_order": [
        {
            "name": "🎬 Start Scene"
        },
        {
            "name": "💬 Just Chatting"  
        },
        {
            "name": "🎮 Gameplay"
        },
        {
            "name": "⏸️ BRB Scene"
        },
        {
            "name": "🎵 Intermission"
        },
        {
            "name": "😴 AFK"
        },
        {
            "name": "🔚 End Scene"
        },
        {
            "name": "🎧 Audio Only"
        },
        {
            "name": "🖥️ Screen Share"
        }
    ],
    "name": "WehttamSnaps",
    "sources": [
        {
            "balance": 0.5,
            "deinterlace_field_order": 0,
            "deinterlace_mode": 0,
            "enabled": true,
            "flags": 0,
            "hotkeys": {},
            "id": "image_source",
            "mixers": 255,
            "monitoring_type": 0,
            "muted": false,
            "name": "WehttamSnaps Logo",
            "prev_ver": 469762049,
            "private_settings": {},
            "push-to-mute": false,
            "push-to-mute-delay": 0,
            "push-to-talk": false,
            "push-to-talk-delay": 0,
            "settings": {
                "file": "/home/wehttamsnaps/Pictures/wehttamsnaps_logo.png",
                "linear_alpha": false,
                "unload": false
            },
            "sync": 0,
            "volume": 1.0
        },
        {
            "balance": 0.5,
            "deinterlace_field_order": 0,
            "deinterlace_mode": 0,
            "enabled": true,
            "flags": 0,
            "hotkeys": {},
            "id": "v4l2_input",
            "mixers": 255,
            "monitoring_type": 0,
            "muted": false,
            "name": "Webcam",
            "prev_ver": 469762049,
            "private_settings": {},
            "push-to-mute": false,
            "push-to-mute-delay": 0,
            "push-to-talk": false,
            "push-to-talk-delay": 0,
            "settings": {
                "device_id": "/dev/video0",
                "resolution": "1920x1080",
                "framerate": "30"
            },
            "sync": 0,
            "volume": 1.0
        },
        {
            "balance": 0.5,
            "deinterlace_field_order": 0,
            "deinterlace_mode": 0,
            "enabled": true,
            "flags": 0,
            "hotkeys": {},
            "id": "pulse_input_capture",
            "mixers": 255,
            "monitoring_type": 0,
            "muted": false,
            "name": "Microphone",
            "prev_ver": 469762049,
            "private_settings": {},
            "push-to-mute": false,
            "push-to-mute-delay": 0,
            "push-to-talk": false,
            "push-to-talk-delay": 0,
            "settings": {
                "device_id": "default"
            },
            "sync": 0,
            "volume": 1.0
        },
        {
            "balance": 0.5,
            "deinterlace_field_order": 0,
            "deinterlace_mode": 0,
            "enabled": true,
            "flags": 0,
            "hotkeys": {},
            "id": "pulse_output_capture",
            "mixers": 255,
            "monitoring_type": 0,
            "muted": false,
            "name": "Desktop Audio",
            "prev_ver": 469762049,
            "private_settings": {},
            "push-to-mute": false,
            "push-to-mute-delay": 0,
            "push-to-talk": false,
            "push-to-talk-delay": 0,
            "settings": {
                "device_id": "default"
            },
            "sync": 0,
            "volume": 1.0
        },
        {
            "balance": 0.5,
            "deinterlace_field_order": 0,
            "deinterlace_mode": 0,
            "enabled": true,
            "flags": 0,
            "hotkeys": {},
            "id": "xshm_input",
            "mixers": 255,
            "monitoring_type": 0,
            "muted": false,
            "name": "Screen Capture",
            "prev_ver": 469762049,
            "private_settings": {},
            "push-to-mute": false,
            "push-to-mute-delay": 0,
            "push-to-talk": false,
            "push-to-talk-delay": 0,
            "settings": {
                "show_cursor": true
            },
            "sync": 0,
            "volume": 1.0
        },
        {
            "balance": 0.5,
            "deinterlace_field_order": 0,
            "deinterlace_mode": 0,
            "enabled": true,
            "flags": 0,
            "hotkeys": {},
            "id": "text_gdiplus_v2",
            "mixers": 255,
            "monitoring_type": 0,
            "muted": false,
            "name": "Stream Info Text",
            "prev_ver": 469762049,
            "private_settings": {},
            "push-to-mute": false,
            "push-to-mute-delay": 0,
            "push-to-talk": false,
            "push-to-talk-delay": 0,
            "settings": {
                "text": "WehttamSnaps | Photography & Gaming | twitch.tv/WehttamSnaps",
                "font": {
                    "face": "JetBrains Mono",
                    "size": 24,
                    "flags": 0
                },
                "color": 4294967295,
                "opacity": 100
            },
            "sync": 0,
            "volume": 1.0
        }
    ],
    "transitions": [
        {
            "id": "fade_transition",
            "name": "Fade",
            "settings": {}
        },
        {
            "id": "cut_transition", 
            "name": "Cut",
            "settings": {}
        },
        {
            "id": "slide_transition",
            "name": "Slide",
            "settings": {
                "direction": "left"
            }
        }
    ],
    "current_transition": "Fade"
}
EOF

# Create streaming optimization script
cat > "$USER_HOME/.local/bin/obs-optimize" << 'EOF'
#!/bin/bash

# WehttamSnaps OBS Optimization Script
# Optimizes system for streaming with AMD RX 580

echo "🎬 Optimizing system for OBS streaming..."

# Set CPU governor to performance
echo "performance" | sudo tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor

# Disable CPU frequency scaling during stream
sudo cpupower frequency-set -g performance

# Set AMD GPU to high performance mode
echo "high" | sudo tee /sys/class/drm/card0/device/power_dpm_force_performance_level

# Increase process priority for OBS
sudo renice -10 $(pgrep obs)

# Set up NVENC-like encoding for AMD
export FFMPEG_VAAPI=1

# Disable compositing for better performance (if using X11 fallback)
if [ "$XDG_SESSION_TYPE" = "x11" ]; then
    killall picom 2>/dev/null || true
fi

# Enable low-latency audio
echo "default-sample-rate = 48000" >> ~/.config/pulse/daemon.conf
echo "default-sample-format = s16le" >> ~/.config/pulse/daemon.conf
echo "default-fragments = 4" >> ~/.config/pulse/daemon.conf
echo "default-fragment-size-msec = 25" >> ~/.config/pulse/daemon.conf

pulseaudio -k && pulseaudio --start

echo "✅ OBS optimization complete! Stream performance should be improved."
EOF

chmod +x "$USER_HOME/.local/bin/obs-optimize"

# Create Twitch stream setup script
cat > "$USER_HOME/.local/bin/start-stream" << 'EOF'
#!/bin/bash

# WehttamSnaps Stream Startup Script
echo "🎮 Starting WehttamSnaps Stream Setup..."

# Run optimizations
obs-optimize

# Start required services
systemctl --user start pipewire-pulse

# Launch OBS with optimized settings
obs --profile WehttamSnaps --collection WehttamSnaps &

# Give OBS time to start
sleep 3

# Open additional tools
discord &
spotify &

echo "🚀 Stream setup complete! Ready to go live!"
EOF

chmod +x "$USER_HOME/.local/bin/start-stream"

# Create scene transition hotkeys config
mkdir -p "$OBS_CONFIG/basic/profiles/WehttamSnaps"
cat > "$OBS_CONFIG/basic/profiles/WehttamSnaps/hotkeys.json" << 'EOF'
{
    "OBSBasic.SelectScene": [
        {
            "key": "OBS_KEY_F1",
            "scene": "🎬 Start Scene"
        },
        {
            "key": "OBS_KEY_F2", 
            "scene": "💬 Just Chatting"
        },
        {
            "key": "OBS_KEY_F3",
            "scene": "🎮 Gameplay"
        },
        {
            "key": "OBS_KEY_F4",
            "scene": "⏸️ BRB Scene"
        },
        {
            "key": "OBS_KEY_F5",
            "scene": "🎵 Intermission"
        },
        {
            "key": "OBS_KEY_F6",
            "scene": "😴 AFK"
        },
        {
            "key": "OBS_KEY_F7",
            "scene": "🔚 End Scene"
        }
    ],
    "OBSBasic.StartStreaming": [
        {
            "key": "OBS_KEY_F9"
        }
    ],
    "OBSBasic.StopStreaming": [
        {
            "key": "OBS_KEY_F10"
        }
    ],
    "OBSBasic.StartRecording": [
        {
            "key": "OBS_KEY_F11"
        }
    ],
    "OBSBasic.StopRecording": [
        {
            "key": "OBS_KEY_F12"
        }
    ]
}
EOF

# Create custom CSS for OBS browser sources
mkdir -p "$USER_HOME/Documents/OBS/browser-sources"
cat > "$USER_HOME/Documents/OBS/browser-sources/chat-overlay.css" << 'EOF'
/* WehttamSnaps Chat Overlay CSS */
body {
    background: transparent;
    margin: 0;
    padding: 10px;
    font-family: 'JetBrains Mono', monospace;
}

.chat-message {
    background: linear-gradient(135deg, #1a1b26 0%, #24283b 100%);
    border-left: 4px solid #7aa2f7;
    border-radius: 8px;
    padding: 8px 12px;
    margin: 5px 0;
    box-shadow: 0 2px 8px rgba(0,0,0,0.3);
    animation: slideIn 0.3s ease-out;
}

.chat-username {
    color: #bb9af7;
    font-weight: bold;
}

.chat-text {
    color: #c0caf5;
    margin-top: 4px;
}

@keyframes slideIn {
    from {
        transform: translateX(-100%);
        opacity: 0;
    }
    to {
        transform: translateX(0);
        opacity: 1;
    }
}
EOF

# Create stream overlay HTML template
cat > "$USER_HOME/Documents/OBS/browser-sources/stream-overlay.html" << 'EOF'
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>WehttamSnaps Stream Overlay</title>
    <style>
        body {
            background: transparent;
            margin: 0;
            padding: 0;
            font-family: 'JetBrains Mono', monospace;
            overflow: hidden;
        }
        
        .overlay-container {
            position: relative;
            width: 1920px;
            height: 1080px;
        }
        
        .stream-info {
            position: absolute;
            bottom: 20px;
            left: 20px;
            background: linear-gradient(135deg, #1a1b26ee 0%, #24283bee 100%);
            border: 2px solid #7aa2f7;
            border-radius: 15px;
            padding: 15px 25px;
            backdrop-filter: blur(10px);
        }
        
        .streamer-name {
            color: #bb9af7;
            font-size: 24px;
            font-weight: bold;
            margin-bottom: 5px;
        }
        
        .stream-title {
            color: #c0caf5;
            font-size: 16px;
            max-width: 400px;
        }
        
        .social-info {
            position: absolute;
            top: 20px;
            right: 20px;
            background: linear-gradient(135deg, #1a1b26ee 0%, #24283bee 100%);
            border: 2px solid #f7768e;
            border-radius: 15px;
            padding: 10px 20px;
            text-align: center;
            backdrop-filter: blur(10px);
        }
        
        .social-handle {
            color: #f7768e;
            font-size: 18px;
            font-weight: bold;
        }
        
        .webcam-frame {
            position: absolute;
            top: 50px;
            left: 50px;
            width: 320px;
            height: 240px;
            border: 3px solid #7dcfff;
            border-radius: 20px;
            background: #1a1b26;
            box-shadow: 0 8px 32px rgba(125, 207, 255, 0.3);
        }
        
        .pulse-animation {
            animation: pulse 2s infinite;
        }
        
        @keyframes pulse {
            0% { box-shadow: 0 0 0 0 rgba(125, 207, 255, 0.7); }
            70% { box-shadow: 0 0 0 10px rgba(125, 207, 255, 0); }
            100% { box-shadow: 0 0 0 0 rgba(125, 207, 255, 0); }
        }
    </style>
</head>
<body>
    <div class="overlay-container">
        <div class="stream-info">
            <div class="streamer-name">WehttamSnaps</div>
            <div class="stream-title">Photography & Gaming | !socials !setup</div>
        </div>
        
        <div class="social-info">
            <div class="social-handle">@WehttamSnaps</div>
        </div>
        
        <div class="webcam-frame pulse-animation"></div>
    </div>
</body>
</html>
EOF

# Create gaming performance profile for streaming
cat > "$USER_HOME/.local/bin/gaming-stream-mode" << 'EOF'
#!/bin/bash

# Gaming + Streaming Performance Mode
echo "🎮 Enabling Gaming + Streaming mode..."

# Set CPU to performance mode
sudo cpupower frequency-set -g performance

# Set GPU to high performance  
echo "high" | sudo tee /sys/class/drm/card0/device/power_dpm_force_performance_level

# Enable gamemode
pkill -f gamemode || true
gamemoded &

# Optimize memory
echo 1 > /proc/sys/vm/drop_caches
echo 10 > /proc/sys/vm/swappiness

# Set OBS process priority
if pgrep obs > /dev/null; then
    sudo renice -5 $(pgrep obs)
fi

# Set game process priorities (when they start)
cat > /tmp/game-priority.sh << 'GAME_EOF'
#!/bin/bash
while true; do
    # Division series
    for proc in TheDivision2 TheDivision; do
        if pgrep "$proc" > /dev/null; then
            sudo renice -10 $(pgrep "$proc")
        fi
    done
    
    # Cyberpunk 2077
    if pgrep Cyberpunk2077 > /dev/null; then
        sudo renice -10 $(pgrep Cyberpunk2077)
    fi
    
    # The First Descendant
    if pgrep FirstDescendant > /dev/null; then
        sudo renice -10 $(pgrep FirstDescendant)
    fi
    
    sleep 5
done
GAME_EOF

chmod +x /tmp/game-priority.sh
/tmp/game-priority.sh &

echo "✅ Gaming + Streaming optimization active!"
EOF

chmod +x "$USER_HOME/.local/bin/gaming-stream-mode"

# Create Twitch chat integration
cat > "$USER_HOME/Documents/OBS/browser-sources/twitch-chat.html" << 'EOF'
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Twitch Chat - WehttamSnaps</title>
    <style>
        body {
            background: transparent;
            margin: 0;
            padding: 0;
            font-family: 'JetBrains Mono', monospace;
        }
        iframe {
            border: none;
            width: 400px;
            height: 600px;
            border-radius: 10px;
            background: rgba(26, 27, 38, 0.9);
        }
    </style>
</head>
<body>
    <!-- Replace 'wehttamsnaps' with your actual Twitch username -->
    <iframe src="https://www.twitch.tv/embed/wehttamsnaps/chat?parent=localhost&parent=127.0.0.1"></iframe>
</body>
</html>
EOF

echo -e "${GREEN}📁 Creating Asset Directories${NC}"
mkdir -p "$USER_HOME/Pictures/OBS-Assets"/{logos,backgrounds,overlays,alerts}
mkdir -p "$USER_HOME/Videos/Recordings"
mkdir -p "$USER_HOME/Videos/Stream-Highlights"

# Create asset download script
cat > "$USER_HOME/.local/bin/download-obs-assets" << 'EOF'
#!/bin/bash

# Download free streaming assets
ASSETS_DIR="$HOME/Pictures/OBS-Assets"

echo "📥 Downloading free OBS assets..."

# Create sample assets (you can replace these with actual downloads)
cd "$ASSETS_DIR/backgrounds"

# Download some free backgrounds (replace with actual sources)
echo "Creating sample backgrounds..."
convert -size 1920x1080 gradient:purple-blue background1.png
convert -size 1920x1080 gradient:blue-cyan background2.png

cd "$ASSETS_DIR/overlays"
echo "Creating sample overlays..."
convert -size 1920x1080 xc:none -fill 'rgba(26,27,38,0.8)' -draw 'roundrectangle 20,20 400,150 15,15' webcam-frame.png

echo "✅ Sample assets created! Add your own assets to:"
echo "  - Logos: $ASSETS_DIR/logos/"
echo "  - Backgrounds: $ASSETS_DIR/backgrounds/" 
echo "  - Overlays: $ASSETS_DIR/overlays/"
echo "  - Alerts: $ASSETS_DIR/alerts/"
EOF

chmod +x "$USER_HOME/.local/bin/download-obs-assets"

echo -e "${GREEN}🎬 OBS Studio Configuration Complete!${NC}"
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${PURPLE}Usage:${NC}"
echo "• start-stream          - Launch complete streaming setup"
echo "• obs-optimize          - Optimize system for streaming"  
echo "• gaming-stream-mode    - Enable gaming + streaming mode"
echo "• download-obs-assets   - Download/create sample assets"
echo ""
echo -e "${PURPLE}Scene Hotkeys:${NC}"
echo "• F1 - Start Scene      • F2 - Just Chatting"
echo "• F3 - Gameplay         • F4 - BRB Scene"  
echo "• F5 - Intermission     • F6 - AFK"
echo "• F7 - End Scene"
echo "• F9 - Start Stream     • F10 - Stop Stream"
echo "• F11 - Start Recording • F12 - Stop Recording"
echo ""
echo -e "${GREEN}Ready to stream, WehttamSnaps! 🎮📺${NC}"
