
filesToLinkInHome=(.zshrc .themes)
filesToLinkInConfig=( yazi kitty nvim neofetch starship.toml)

echo "------------------ starting ------------------"



setGnomeConfig() {
    gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
    gsettings set org.gnome.desktop.background picture-uri-dark file:///home/"$USER"/Images/wallpapers/9.jpg

    gsettings set org.gnome.desktop.peripherals.touchpad natural-scroll false
    gsettings set org.gnome.desktop.peripherals.touchpad click-method 'fingers'
    gsettings set org.gnome.desktop.peripherals.touchpad tap-to-click false
    gsettings set org.gnome.desktop.peripherals.touchpad speed 0.238
    gsettings set org.gnome.desktop.peripherals.touchpad edge-scrolling-enabled false

    gsettings set org.gnome.mutter dynamic-workspaces true
    gsettings set org.gnome.mutter edge-tiling true
    gsettings set org.gnome.mutter workspaces-only-on-primary false
    gsettings set org.gnome.mutter attach-modal-dialogs false

    gsettings set org.gnome.desktop.interface gtk-theme 'Tokyonight-Dark-BL-LB"
    gsettings set org.gnome.desktop.interface icon-theme "Tokyonight-Dark"
    gsettings set org.gnome.desktop.interface cursor-theme "Adwaita"
    gsettings set org.gnome.desktop.interface monospace-font-name "Source Code Pro 10"
    # gsettings set org.gnome.desktop.interface document-font-name "Sans 12"
    # gsettings set org.gnome.desktop.interface font-name "Cantarell 12"
    # gsettings set org.gnome.desktop.interface clock-show-date true

    gsettings set org.gnome.desktop.wm.preferences button-layout 'close,minimize,maximize:appmenu'
    # gsettings set org.gnome.desktop.wm.preferences num-workspaces :4
    gsettings set org.gnome.desktop.wm.preferences resize-with-right-button true

    # gsettings set org.gnome.shell.extensions.dash-to-dock dock-position 'BOTTOM'
    # gsettings set org.gnome.shell.extensions.dash-to-dock show-apps-at-top true

    gsettings set org.gnome.shell.extensions.user-theme name "AlphaBlueNeon"
   
    gsettings set org.gnome.shell enabled-extensions "['dash-to-dock@micxgx.gmail.com', 'user-theme@gnome-shell-extensions.gcampax.github.com', 'drive-menu@gnome-shell-extensions.gcampax.github.com', 'caffeine@patapon.info', 'clipboard-indicator@tudmotu.com', 'extension-list@tu.berry', 'color-picker@tuberry', 'mediacontrols@cliffniff.github.com', 'desk-changer@eric.gach.gmail.com', 'top-bar-organizer@julian.gse.jsts.xyz', 'pico-system-monitor@hiddewie', 'tophat@fflewddur.github.io', 'addshutbutton@flioner@jerom@olika.ovh', 'xremap@k0kubun.com', 'native-window-placement@gnome-shell-extensions.gcampax.github.com', 'auto-move-windows@gnome-shell-extensions.gcampax.github.com']"

    gsettings set org.gnome.shell favorite-apps "['firefox.desktop', 'org.gnome.Geary.desktop', 'org.gnome.Calendar.desktop', 'org.gnome.Rhythmbox3.desktop', 'kitty.desktop', 'org.gnome.tweaks.desktop', 'org.gnome.Settings.desktop', 'org.gnome.Extensions.desktop']"
    # gsettings set org.gnome.shell.extensions.dash-to-dock extend-height 
    echo "------------------ gnome config set ------------------"

}


setGnomeConfig


echo "------------------ finished ------------------"
