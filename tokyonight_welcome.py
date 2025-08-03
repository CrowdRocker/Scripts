#!/usr/bin/env python3
"""
TokyoNight SwayFX Welcome & Control Center
By Matt (@Crowdrocker) - Custom Gaming/Creative Workstation Setup
"""

import gi
gi.require_version('Gtk', '4.0')
gi.require_version('Adw', '1')
from gi.repository import Gtk, Adw, GLib, Gio
import subprocess
import os
import json
from pathlib import Path

class TokyoNightWelcome(Adw.Application):
    def __init__(self):
        super().__init__(application_id='com.crowdrocker.tokyonight-welcome')
        self.setup_css()
        
    def setup_css(self):
        """Apply TokyoNight theme styling"""
        css_provider = Gtk.CssProvider()
        css_data = """
        /* TokyoNight Color Scheme */
        .tokyo-bg { background: #1a1b26; }
        .tokyo-surface { background: #24283b; }
        .tokyo-blue { background: #7aa2f7; color: #1a1b26; }
        .tokyo-purple { background: #bb9af7; color: #1a1b26; }
        .tokyo-cyan { background: #7dcfff; color: #1a1b26; }
        .tokyo-green { background: #9ece6a; color: #1a1b26; }
        .tokyo-red { background: #f7768e; color: #1a1b26; }
        .tokyo-orange { background: #ff9e64; color: #1a1b26; }
        
        .welcome-card {
            background: #24283b;
            border-radius: 12px;
            margin: 8px;
            padding: 16px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.3);
        }
        
        .feature-button {
            background: linear-gradient(135deg, #7aa2f7, #bb9af7);
            border-radius: 8px;
            padding: 12px;
            margin: 4px;
            color: #1a1b26;
            font-weight: bold;
        }
        
        .gaming-button {
            background: linear-gradient(135deg, #f7768e, #ff9e64);
        }
        
        .creative-button {
            background: linear-gradient(135deg, #9ece6a, #7dcfff);
        }
        
        .system-status {
            background: #414868;
            border-radius: 6px;
            padding: 8px;
            margin: 4px;
            color: #c0caf5;
        }
        """
        css_provider.load_from_data(css_data.encode())
        Gtk.StyleContext.add_provider_for_display(
            self.get_display(),
            css_provider,
            Gtk.STYLE_PROVIDER_PRIORITY_APPLICATION
        )

    def do_activate(self):
        window = self.create_main_window()
        window.present()

    def create_main_window(self):
        """Create the main welcome window"""
        window = Adw.ApplicationWindow(application=self)
        window.set_title("TokyoNight Control Center")
        window.set_default_size(900, 700)
        
        # Header Bar
        header = Adw.HeaderBar()
        header.set_title_widget(Gtk.Label(label="🌃 TokyoNight SwayFX"))
        window.set_content(self.create_main_content())
        
        return window

    def create_main_content(self):
        """Create main content area"""
        main_box = Gtk.Box(orientation=Gtk.Orientation.VERTICAL, spacing=12)
        main_box.set_margin_top(20)
        main_box.set_margin_bottom(20)
        main_box.set_margin_start(20)
        main_box.set_margin_end(20)
        
        # Welcome header
        welcome_label = Gtk.Label()
        welcome_label.set_markup('<span size="x-large" weight="bold">Welcome back, Matt! 🎮📸</span>')
        main_box.append(welcome_label)
        
        # System status row
        status_box = self.create_system_status()
        main_box.append(status_box)
        
        # Main content grid
        content_grid = Gtk.Grid()
        content_grid.set_column_spacing(12)
        content_grid.set_row_spacing(12)
        content_grid.set_column_homogeneous(True)
        
        # Gaming section
        gaming_card = self.create_gaming_section()
        content_grid.attach(gaming_card, 0, 0, 1, 1)
        
        # Creative section
        creative_card = self.create_creative_section()
        content_grid.attach(creative_card, 1, 0, 1, 1)
        
        # System section
        system_card = self.create_system_section()
        content_grid.attach(system_card, 0, 1, 1, 1)
        
        # Theme section
        theme_card = self.create_theme_section()
        content_grid.attach(theme_card, 1, 1, 1, 1)
        
        main_box.append(content_grid)
        
        # Keybindings reference
        keybind_expander = self.create_keybind_reference()
        main_box.append(keybind_expander)
        
        scrolled = Gtk.ScrolledWindow()
        scrolled.set_child(main_box)
        scrolled.add_css_class("tokyo-bg")
        
        return scrolled

    def create_system_status(self):
        """Create system status indicator bar"""
        status_box = Gtk.Box(orientation=Gtk.Orientation.HORIZONTAL, spacing=12)
        status_box.add_css_class("system-status")
        
        # CPU info
        cpu_info = self.get_cpu_info()
        cpu_label = Gtk.Label(label=f"🖥️ {cpu_info}")
        status_box.append(cpu_label)
        
        # GPU info
        gpu_label = Gtk.Label(label="🎮 AMD RX 580")
        status_box.append(gpu_label)
        
        # Updates available
        updates_label = Gtk.Label(label="📦 Updates: Checking...")
        status_box.append(updates_label)
        
        # Gaming mode status
        gaming_status = Gtk.Label(label="⚡ Gaming Mode: OFF")
        status_box.append(gaming_status)
        
        return status_box

    def create_gaming_section(self):
        """Create gaming control section"""
        card = Gtk.Box(orientation=Gtk.Orientation.VERTICAL, spacing=8)
        card.add_css_class("welcome-card")
        
        title = Gtk.Label()
        title.set_markup('<span size="large" weight="bold">🎮 Gaming Hub</span>')
        card.append(title)
        
        # Game launchers
        steam_btn = Gtk.Button(label="Launch Steam")
        steam_btn.add_css_class("feature-button")
        steam_btn.add_css_class("gaming-button")
        steam_btn.connect('clicked', lambda x: self.launch_app('steam'))
        card.append(steam_btn)
        
        lutris_btn = Gtk.Button(label="Launch Lutris")
        lutris_btn.add_css_class("feature-button")
        lutris_btn.add_css_class("gaming-button")
        lutris_btn.connect('clicked', lambda x: self.launch_app('lutris'))
        card.append(lutris_btn)
        
        heroic_btn = Gtk.Button(label="Heroic Games")
        heroic_btn.add_css_class("feature-button")
        heroic_btn.add_css_class("gaming-button")
        heroic_btn.connect('clicked', lambda x: self.launch_app('heroic'))
        card.append(heroic_btn)
        
        # Gaming optimizations
        gamemode_btn = Gtk.Button(label="Toggle Gaming Mode")
        gamemode_btn.add_css_class("feature-button")
        gamemode_btn.connect('clicked', self.toggle_gaming_mode)
        card.append(gamemode_btn)
        
        # Quick game access
        fav_games = Gtk.Label()
        fav_games.set_markup('<span size="small">🎯 Favorites: Division 2, First Descendant, Cyberpunk</span>')
        card.append(fav_games)
        
        return card

    def create_creative_section(self):
        """Create creative tools section"""
        card = Gtk.Box(orientation=Gtk.Orientation.VERTICAL, spacing=8)
        card.add_css_class("welcome-card")
        
        title = Gtk.Label()
        title.set_markup('<span size="large" weight="bold">📸 Creative Suite</span>')
        card.append(title)
        
        # Photo editing
        photo_btn = Gtk.Button(label="Launch GIMP/RawTherapee")
        photo_btn.add_css_class("feature-button")
        photo_btn.add_css_class("creative-button")
        photo_btn.connect('clicked', lambda x: self.launch_app('gimp'))
        card.append(photo_btn)
        
        # Video editing  
        video_btn = Gtk.Button(label="Launch DaVinci Resolve")
        video_btn.add_css_class("feature-button")
        video_btn.add_css_class("creative-button")
        video_btn.connect('clicked', lambda x: self.launch_app('resolve'))
        card.append(video_btn)
        
        # Color profile switching
        profile_btn = Gtk.Button(label="Switch Color Profile")
        profile_btn.add_css_class("feature-button")
        profile_btn.connect('clicked', self.switch_color_profile)
        card.append(profile_btn)
        
        # Project workspace
        workspace_btn = Gtk.Button(label="Open Project Workspace")
        workspace_btn.add_css_class("feature-button")
        workspace_btn.connect('clicked', self.open_project_workspace)
        card.append(workspace_btn)
        
        return card

    def create_system_section(self):
        """Create system management section"""
        card = Gtk.Box(orientation=Gtk.Orientation.VERTICAL, spacing=8)
        card.add_css_class("welcome-card")
        
        title = Gtk.Label()
        title.set_markup('<span size="large" weight="bold">⚙️ System Control</span>')
        card.append(title)
        
        # System updates
        update_btn = Gtk.Button(label="Check Updates")
        update_btn.add_css_class("feature-button")
        update_btn.connect('clicked', self.check_updates)
        card.append(update_btn)
        
        # SwayFX settings
        sway_btn = Gtk.Button(label="SwayFX Settings")
        sway_btn.add_css_class("feature-button")
        sway_btn.connect('clicked', self.open_sway_settings)
        card.append(sway_btn)
        
        # Waybar settings
        waybar_btn = Gtk.Button(label="Configure Waybar")
        waybar_btn.add_css_class("feature-button")
        waybar_btn.connect('clicked', self.configure_waybar)
        card.append(waybar_btn)
        
        # AMD GPU settings
        amd_btn = Gtk.Button(label="AMD GPU Control")
        amd_btn.add_css_class("feature-button")
        amd_btn.connect('clicked', self.open_amd_settings)
        card.append(amd_btn)
        
        return card

    def create_theme_section(self):
        """Create theme management section"""
        card = Gtk.Box(orientation=Gtk.Orientation.VERTICAL, spacing=8)
        card.add_css_class("welcome-card")
        
        title = Gtk.Label()
        title.set_markup('<span size="large" weight="bold">🎨 Theme Manager</span>')
        card.append(title)
        
        # Theme variants
        theme_combo = Gtk.ComboBoxText()
        theme_combo.append_text("TokyoNight Storm")
        theme_combo.append_text("TokyoNight Night")
        theme_combo.append_text("TokyoNight Day")
        theme_combo.set_active(0)
        card.append(theme_combo)
        
        # Apply theme
        apply_btn = Gtk.Button(label="Apply Theme")
        apply_btn.add_css_class("feature-button")
        apply_btn.connect('clicked', lambda x: self.apply_theme(theme_combo.get_active_text()))
        card.append(apply_btn)
        
        # Wallpaper manager
        wall_btn = Gtk.Button(label="Change Wallpaper")
        wall_btn.add_css_class("feature-button")
        wall_btn.connect('clicked', lambda x: self.launch_app('azote'))
        card.append(wall_btn)
        
        # GTK theme settings
        gtk_btn = Gtk.Button(label="GTK Theme Settings")
        gtk_btn.add_css_class("feature-button")
        gtk_btn.connect('clicked', lambda x: self.launch_app('nwg-look'))
        card.append(gtk_btn)
        
        return card

    def create_keybind_reference(self):
        """Create keybinding reference section"""
        expander = Gtk.Expander()
        expander.set_label("⌨️  SwayFX Keybindings Reference")
        
        keybind_box = Gtk.Box(orientation=Gtk.Orientation.VERTICAL, spacing=4)
        
        keybinds = [
            ("Super + Return", "Launch Terminal (Alacritty)"),
            ("Super + D", "Application Launcher (Rofi)"),
            ("Super + Shift + Q", "Close Window"),
            ("Super + F", "Toggle Fullscreen"),
            ("Super + Space", "Toggle Floating"),
            ("Super + 1-9", "Switch Workspace"),
            ("Super + Shift + 1-9", "Move to Workspace"),
            ("Super + H/J/K/L", "Navigate Windows (Vim keys)"),
            ("Super + Shift + H/J/K/L", "Move Windows"),
            ("Super + R", "Resize Mode"),
            ("Super + Shift + R", "Reload SwayFX Config"),
            ("Super + Shift + E", "Exit SwayFX"),
            ("Super + P", "Power Menu"),
            ("Super + L", "Lock Screen"),
            ("XF86AudioRaiseVolume", "Volume Up"),
            ("XF86AudioLowerVolume", "Volume Down"),
            ("XF86AudioMute", "Toggle Mute"),
            ("Print", "Screenshot"),
            ("Super + G", "Gaming Mode Toggle"),
            ("Super + T", "Theme Switcher")
        ]
        
        for key, desc in keybinds:
            keybind_row = Gtk.Box(orientation=Gtk.Orientation.HORIZONTAL, spacing=12)
            key_label = Gtk.Label(label=key)
            key_label.add_css_class("system-status")
            key_label.set_size_request(200, -1)
            desc_label = Gtk.Label(label=desc)
            keybind_row.append(key_label)
            keybind_row.append(desc_label)
            keybind_box.append(keybind_row)
        
        expander.set_child(keybind_box)
        return expander

    # Action methods
    def get_cpu_info(self):
        try:
            with open('/proc/cpuinfo', 'r') as f:
                for line in f:
                    if 'model name' in line:
                        return line.split(':')[1].strip()
        except:
            return "i5-4430"
        return "CPU Info Unavailable"

    def launch_app(self, app):
        """Launch applications"""
        app_commands = {
            'steam': 'steam',
            'lutris': 'lutris',
            'heroic': 'heroic',
            'gimp': 'gimp',
            'resolve': 'resolve',
            'azote': 'azote',
            'nwg-look': 'nwg-look'
        }
        if app in app_commands:
            subprocess.Popen([app_commands[app]], start_new_session=True)

    def toggle_gaming_mode(self, button):
        """Toggle gaming optimizations"""
        # This would toggle gamemode, CPU governor, notifications, etc.
        subprocess.run(['notify-send', 'Gaming Mode', 'Toggling gaming optimizations...'])

    def switch_color_profile(self, button):
        """Switch color profiles for photography"""
        subprocess.run(['notify-send', 'Color Profile', 'Switching to photography profile...'])

    def open_project_workspace(self, button):
        """Open project-specific workspace"""
        subprocess.run(['swaymsg', 'workspace', '3:Creative'])

    def check_updates(self, button):
        """Check for system updates"""
        subprocess.run(['notify-send', 'System Updates', 'Checking for updates...'])

    def open_sway_settings(self, button):
        """Open SwayFX configuration"""
        subprocess.run(['alacritty', '-e', 'nano', '~/.config/sway/config'])

    def configure_waybar(self, button):
        """Configure Waybar"""
        subprocess.run(['alacritty', '-e', 'nano', '~/.config/waybar/config'])

    def open_amd_settings(self, button):
        """Open AMD GPU settings"""
        subprocess.run(['alacritty', '-e', 'radeontop'])

    def apply_theme(self, theme_name):
        """Apply selected theme variant"""
        subprocess.run(['notify-send', 'Theme Manager', f'Applying {theme_name}...'])

if __name__ == '__main__':
    app = TokyoNightWelcome()
    app.run()
