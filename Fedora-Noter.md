I have an i5-4430 with rx 580 and was wondering what would be be for me. I like either swayfx or hyprland. I don’t know whether to use fedora or arch for gaming.

I’ve used arch once but tried to ask the same question on Reddit.  They just say stick with arch it’s the best and fedora sucks and it’s to hard to configure

I was ok I just had a base set up of hyprland. Then I went on hyprland wiki and found preconfigured ones. So I tried jakoolit and ml4w. Pretty much the same but jaykoolit felt snappier and lighter. If fedora is easier then I’ll go with it

I reached out to jaykoolit and he said I would be able to tailor it for other stuff I wanted. He said that if I fork it and could add other things  gaming related toggle gamemode or eww widgets game launcher

Perfect! Those are some demanding games, especially Cyberpunk and The First Descendant, so optimization will definitely help with your hardware.

For your specific games:

    Division 1 & 2: Run great on Linux with Proton
    The First Descendant: Should work well with Proton Experimental
    Cyberpunk 2077: Excellent Linux support, benefits from FSR

EWW Widget ideas for your gaming launcher:

    Grid layout with game icons + platform badges
    Recently played section at top
    Quick toggles for GameMode, performance profiles
    System stats (temps/usage) that auto-hide during games

OBS optimization for Hyprland: Since you want GIMP-editable scenes, I'd suggest:

    Use PNG overlays for backgrounds/frames (GIMP-friendly)
    Create modular overlay templates you can swap
    Set up hotkeys for scene switching
    Use OBS filters for smooth transitions between your scenes

Hyprland gaming optimizations:
# Add to your hyprland.conf for gaming
windowrulev2 = immediate, class:^(steam_app_).*
windowrulev2 = fullscreen, class:^(steam_app_).*
exec-once = gamemode -d # Auto-enable gamemode daemon

Steam launch options for your setup:

    General: gamemoderun %command%
    Cyberpunk: Add -USEALLAVAILABLECORES
    Division games: May benefit from PROTON_USE_WINE3D=1

Want me to help you plan out the specific EWW widget layout or OBS scene structure? I could also help with some Hyprland gaming rules for better performance.


Perfect! Let me help you with both the Fedora setup and then the EWW widgets/OBS planning.


There you have it! Here's what we've covered:
Fedora Setup: Complete step-by-step guide from fresh install to gaming-ready system with JaKoolit's Hyprland setup.
EWW Gaming Widget: A sleek launcher that shows:

Recently played games with platform badges
Quick access to Steam, Lutris, Heroic, Spotify
System performance toggles (GameMode, Performance mode)
Real-time CPU/GPU stats

OBS Scene Structure: Professional streaming setup with:

Clean scene organization for different stream types
GIMP-editable templates and overlays
Hotkey assignments for quick switching
Modular nested scenes for easy management

Key Features for Your Setup:

GameMode integration for better performance on your i5-4430
MangoHud overlay for monitoring temps/FPS
Optimized Hyprland rules for your games (Division, First Descendant, Cyberpunk)
Stream-ready OBS configuration

Once you get Fedora installed and JaKoolit's setup running, you can fork his repo and start adding these gaming-specific customizations. The EWW widget will integrate nicely with his existing setup since he already uses EWW for his system widgets.

There's your complete DaVinci Resolve installation guide! The automated script method is definitely your best bet - it handles most of the compatibility issues automatically and includes specific fixes for AMD GPUs like your RX 580.
Key points for your setup:

Your RX 580 should work well with OpenCL in DaVinci Resolve
The automated script handles the tricky library compatibility stuff
You'll want to make sure you're in the video group for GPU access
Performance will be decent for 1080p editing, though 4K might be pushing it

Pro tip: Once you get it installed, create some proxy media for smoother editing if you're working with high-resolution footage from your games. DaVinci Resolve can generate optimized media that's easier for your system to handle during editing.
This will be perfect for editing your streaming highlights from Division, First Descendant, and Cyberpunk! The color grading tools in DaVinci are particularly good for making game footage look cinematic.
Want me to add anything specific to the guide, or shall we move on to testing your setup once you get Fedora installed?




















