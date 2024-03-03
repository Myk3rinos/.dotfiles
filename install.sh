
filesToLinkInHome=(.zshrc .themes)
filesToLinkInConfig=( yazi kitty nvim neofetch starship.toml)

echo "------------------ starting ------------------"

createSymlinks() {
    if [ -f $1 ] || [ -r $1 ]; then # check if file exists
       rm ~/"$2""$1"
       ln -s $(pwd)/$1 ~/"$2""$1"
        echo "$1 config linked."
    else
        echo "WARNING: no $1 config found; can't link for now."
    fi
}

copieNixosConfig() {
    if [ -f $1 ]; then
      # rm /etc/nixos/configuration.nix
      sudo cp configuration.nix /etc/nixos/configuration.nix
        echo "nixos config copied."
    else
        echo "WARNING: no $1 config found; can't copie for now."
    fi
    echo "------------------ nixos config copied ------------------"
}

gitinit() { 
    echo "Do you want to connect to your github? (y/n)"
    select yn in "Yes" "No"; do
        case $yn in
            Yes ) gh auth login; break;;
            No ) break;; #exit;;
        esac
    done
}

createAllSymlink() {
    echo "------------------ create symlinks ------------------" 
    for file in "${filesToLinkInHome[@]}"; do
       createSymlinks $file ""
    done
    for file in "${filesToLinkInConfig[@]}"; do
       createSymlinks $file ".config/"
    done
    echo "------------- creation off symlink done -------------" 
}


setGnomeConfig() {
    gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
    gsettings set org.gnome.desktop.background picture-uri-dark file:///home/"$USER"/Images/wallpaper/2.jpg

    gsettings set org.gnome.desktop.peripherals.touchpad natural-scroll false
    gsettings set org.gnome.desktop.peripherals.touchpad click-method 'fingers'
    gsettings set org.gnome.desktop.peripherals.touchpad tap-to-click false
    gsettings set org.gnome.desktop.peripherals.touchpad speed 0.238
    gsettings set org.gnome.desktop.peripherals.touchpad edge-scrolling-enabled false

    gsettings set org.gnome.mutter dynamic-workspaces true
    gsettings set org.gnome.mutter edge-tiling true
    gsettings set org.gnome.mutter workspaces-only-on-primary false
    gsettings set org.gnome.mutter attach-modal-dialogs false

    gsettings set org.gnome.desktop.interface gtk-theme "Nightfox-Dusk-BL-LB"
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
    
    gsettings set org.gnome.shell enabled-extensions "['dash-to-dock@micxgx.gmail.com', 'user-theme@gnome-shell-extensions.gcampax.github.com', 'drive-menu@gnome-shell-extensions.gcampax.github.com', 'auto-move-windows@gnome-shell-extensions.gcampax.github.com', 'caffeine@patapon.info', 'clipboard-indicator@tudmotu.com', 'extension-list@tu.berry', 'color-picker@tuberry', 'top-bar-organizer@julian.gse.jsts.xyz', 'Vitals@CoreCoding.com', 'mediacontrols@cliffniff.github.com', 'desk-changer@eric.gach.gmail.com']"

    gsettings set org.gnome.shell favorite-apps "['firefox.desktop', 'org.gnome.Nautilus.desktop', 'org.gnome.Geary.desktop', 'org.gnome.Calendar.desktop', 'org.gnome.Settings.desktop', 'org.gnome.Music.desktop', 'kitty.desktop', 'org.gnome.tweaks.desktop', 'org.gnome.Extensions.desktop']"
    # gsettings set org.gnome.shell.extensions.dash-to-dock extend-height 
    echo "------------------ gnome config set ------------------"

}

cpMozilla() {
    echo "------------------ cp mozilla ------------------"
    sudo cp -r ~/.mozilla/firefox/ ~/Documents/mozilla/
}

askForReboot() {
    echo "Do you want to reboot? (y/n)"
    select yn in "Yes" "No"; do
        case $yn in
            Yes ) sudo reboot; break;;
            No ) break;;
        esac
    done
}

createAllSymlink
setGnomeConfig
cpMozilla
gitinit


if [ "$HOSTNAME"  = "nixos" ]
then
   copieNixosConfig
   sudo nixos-rebuild switch --upgrade
   echo "------------------ nixos rebuild done ------------------"
else
    echo "you have to install ${filesToLinkInConfig[@]} and ${filesToLinkInHome[@]} manually." 
fi

askForReboot
echo "------------------ finished ------------------"
