source ~/.dotfiles/script/colors.sh

# echo -e "------------------${color2} ¤${colorEnd} ${color3}| set gnome configuration |${colorEnd}---"

setGnomeConfig() {
    # echo -e "${color4}- Setting Gnome config ---------------------------------------- ${colorEnd}"
    echo -e "------------------${color2} ¤${colorEnd} ${color3}| Setting Gnome config |${colorEnd}---"
    gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
    gsettings set org.gnome.desktop.background picture-uri-dark file:///home/"$USER"/Images/wallpapers/1.jpg
    gsettings set org.gnome.desktop.peripherals.touchpad natural-scroll false
    gsettings set org.gnome.desktop.peripherals.touchpad click-method 'fingers'
    gsettings set org.gnome.desktop.peripherals.touchpad tap-to-click false
    gsettings set org.gnome.desktop.peripherals.touchpad speed 0.238
    gsettings set org.gnome.desktop.peripherals.touchpad edge-scrolling-enabled false
    gsettings set org.gnome.desktop.interface gtk-theme "Yaru-magenta-dark"
    gsettings set org.gnome.desktop.interface icon-theme "Yaru-sage-dark"
    gsettings set org.gnome.desktop.interface cursor-theme "Adwaita"
    gsettings set org.gnome.desktop.interface monospace-font-name "Source Code Pro 10"
    gsettings set org.gnome.desktop.wm.preferences button-layout 'close,minimize,maximize:appmenu'
    gsettings set org.gnome.desktop.wm.preferences resize-with-right-button true
    gsettings set org.gnome.shell.extensions.user-theme name "AlphaBlueNeon"
    gsettings set org.gnome.shell favorite-apps "['org.gnome.Nautilus.desktop', 'kitty.desktop', 'windsurf.desktop', 'firefox_firefox.desktop', 'com.mattjakeman.ExtensionManager.desktop', 'org.gnome.Rhythmbox3.desktop', 'org.gnome.tweaks.desktop', 'org.gnome.Settings.desktop']"
    gsettings set org.gnome.shell.extensions.auto-move-windows application-list "['firefox.desktop:2']"
    gsettings set org.gnome.shell.extensions.ding show-home false
    gsettings set org.gnome.shell.app-switcher current-workspace-only true
    gsettings set org.gnome.shell enabled-extensions "['dash-to-dock@micxgx.gmail.com', 'user-theme@gnome-shell-extensions.gcampax.github.com', 'drive-menu@gnome-shell-extensions.gcampax.github.com', 'caffeine@patapon.info', 'clipboard-indicator@tudmotu.com', 'extension-list@tu.berry', 'color-picker@tuberry', 'mediacontrols@cliffniff.github.com', 'desk-changer@eric.gach.gmail.com', 'top-bar-organizer@julian.gse.jsts.xyz', 'pico-system-monitor@hiddewie', 'tophat@fflewddur.github.io', 'addshutbutton@flioner@jerom@olika.ovh', 'xremap@k0kubun.com', 'native-window-placement@gnome-shell-extensions.gcampax.github.com', 'auto-move-windows@gnome-shell-extensions.gcampax.github.com', 'x11gestures@joseexposito.github.io', 'ding@rastersoft.com', 'ubuntu-dock@ubuntu.com', 'tiling-assistant@ubuntu.com', 'Vitals@CoreCoding.com']"
    gsettings set org.gnome.shell.extensions.dash-to-dock extend-height false
    gsettings set org.gnome.shell.extensions.dash-to-dock dock-position BOTTOM
    gsettings set org.gnome.shell.extensions.dash-to-dock dash-max-icon-size 38
    gsettings set org.gnome.shell.extensions.dash-to-dock dock-fixed false
    gsettings set org.gnome.desktop.notifications show-banners false

    # gsettings set org.gnome.settings-daemon.plugins.power sleep-display-ac 600

    rfkill block bluetooth
}

# setGnomeConfig

# echo -e "------------------${color2} ¤${colorEnd} ${color3}| Gnome config done |${colorEnd}---"

# gsettings set org.gnome.nautilus.icon-view default-zoom-level 'large'
# icon_size=$(gsettings get org.gnome.nautilus.icon-view default-zoom-level)
# echo "Icon size in Nautilus: $icon_size"