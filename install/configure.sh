#!/bin/bash

source ~/.dotfiles/script/colors.sh

# ---------------------------------------------------------------------------
# Configuration utilisateur post-install
# - Installation des extensions VSCode depuis vscode/extensions.txt
# - Restauration des raccourcis clavier GNOME depuis ~/Documents/custom.txt
# - Restauration du profil Firefox depuis ~/Documents/firefox-profile.tar.gz
# - Restauration des clés SSH depuis ~/Documents/ssh
# - Application des préférences GNOME (thème, dock, extensions, firewall...)
# - Configuration git (user.name/email) + auth GitHub (interactif)
# ---------------------------------------------------------------------------

installVSCodeExtensions() {
    echo -e "${color4}- install VSCode extensions ${colorEnd}"
    if ! command -v code >/dev/null 2>&1; then
        echo -e "${colorB}WARNING: code CLI not found, skipping VSCode extensions install.${colorEnd}"
        return
    fi
    local list=~/.dotfiles/vscode/extensions.txt
    if [ ! -f "$list" ]; then
        echo -e "${colorB}WARNING: $list not found, skipping.${colorEnd}"
        return
    fi
    while IFS= read -r ext; do
        [ -z "$ext" ] && continue
        code --install-extension "$ext" --force || true
    done < "$list"
    echo -e "${colorG}VSCode extensions installed.${colorEnd}"
}

cpKeybinding() {
    # Le dump doit avoir été généré avec le path parent pour inclure la liste
    # `custom-keybindings` qui active les raccourcis :
    #   dconf dump /org/gnome/settings-daemon/plugins/media-keys/ > custom.txt
    local src="$HOME/Documents/custom.txt"
    local dconf_path="/org/gnome/settings-daemon/plugins/media-keys/"

    echo -e "${color4}- Restoring custom GNOME keybindings ${colorEnd}"
    if [ ! -f "$src" ]; then
        echo -e "${color4}- No keybindings file found at $src, skipping ${colorEnd}"
        return
    fi

    if dconf load "$dconf_path" < "$src"; then
        echo -e "${colorG}- Custom keybindings loaded ${colorEnd}"
    else
        echo -e "${colorB}WARNING: dconf load failed for $dconf_path${colorEnd}"
    fi
}

cpFirefoxProfile() {
    local src="$HOME/Documents/firefox-profile.tar.gz"

    echo -e "${color4}- Restoring Firefox profile ${colorEnd}"

    if [ ! -f "$src" ]; then
        echo -e "${color4}- No Firefox profile backup found at $src, skipping ${colorEnd}"
        return
    fi

    # Refuser si Firefox tourne (DB SQLite incohérentes sinon)
    if pgrep -x firefox >/dev/null 2>&1; then
        echo -e "${colorB}WARNING: Firefox est lancé. Ferme-le AVANT de restaurer le profil ${colorEnd}"
        return 1
    fi

    # Cible : snap par défaut sur Ubuntu 24.04, fallback ~/.mozilla si pas de snap
    local mozilla_dir
    if [ -L /snap/bin/firefox ] || [ -d "$HOME/snap/firefox" ]; then
        mozilla_dir="$HOME/snap/firefox/common/.mozilla/firefox"
    else
        mozilla_dir="$HOME/.mozilla/firefox"
    fi
    mkdir -p "$mozilla_dir"

    # Lire le nom du dossier de profil depuis l'archive (premier chemin)
    local profile_path
    profile_path=$(tar -tzf "$src" | head -n1 | sed 's:/.*::')
    if [ -z "$profile_path" ]; then
        echo -e "${colorB}- Impossible de lire le contenu de $src ${colorEnd}"
        return 1
    fi

    # Si un profil existant porte le même nom, le sauvegarder
    if [ -d "$mozilla_dir/$profile_path" ]; then
        local backup_dir="$mozilla_dir/$profile_path.bak.$(date +%Y%m%d-%H%M%S)"
        mv "$mozilla_dir/$profile_path" "$backup_dir"
        echo -e "${color4}- Ancien profil sauvegardé dans $backup_dir ${colorEnd}"
    fi

    tar -xzf "$src" -C "$mozilla_dir"

    # (Re)créer profiles.ini pour pointer sur le profil restauré
    cat > "$mozilla_dir/profiles.ini" <<EOF
[Profile0]
Name=default
IsRelative=1
Path=$profile_path
Default=1

[General]
StartWithLastProfile=1
Version=2
EOF

    echo -e "${colorG}- Profil Firefox restauré dans $mozilla_dir/$profile_path ${colorEnd}"
}

cpSsh() {
    local src="$HOME/Documents/ssh"
    local dest="$HOME/.ssh"

    if [ ! -d "$src" ]; then
        echo -e "${color4}- No SSH keys found at $src, skipping ${colorEnd}"
        return
    fi

    echo -e "${color4}- Restoring SSH keys from $src ${colorEnd}"
    mkdir -p "$dest"
    rsync -a "$src/" "$dest/"

    # Permissions strictes requises par SSH
    chmod 700 "$dest"
    find "$dest" -mindepth 1 -type f -exec chmod 600 {} \;
    find "$dest" -mindepth 1 -type f -name "*.pub" -exec chmod 644 {} \;

    echo -e "${colorG}- SSH keys restored in $dest ${colorEnd}"
}

setGnomeConfig() (
    # Subshell + set +e : un `gsettings set` qui échoue (schéma absent, extension
    # non installée...) ne stoppe pas le script. La fonction retourne toujours 0.
    set +e
    echo -e "------------------${color2} ¤${colorEnd} ${color3}| Setting Gnome config |${colorEnd}---"
    gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
    gsettings set org.gnome.desktop.background picture-uri-dark "file:///home/$USER/Images/wallpapers/1.jpg"
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
    gsettings set org.gnome.shell.extensions.auto-move-windows application-list "['firefox_firefox.desktop:2']"
    gsettings set org.gnome.shell.extensions.ding show-home false
    gsettings set org.gnome.shell.app-switcher current-workspace-only true
    gsettings set org.gnome.shell enabled-extensions "['dash-to-dock@micxgx.gmail.com', 'user-theme@gnome-shell-extensions.gcampax.github.com', 'drive-menu@gnome-shell-extensions.gcampax.github.com', 'caffeine@patapon.info', 'clipboard-indicator@tudmotu.com', 'extension-list@tu.berry', 'color-picker@tuberry', 'mediacontrols@cliffniff.github.com', 'desk-changer@eric.gach.gmail.com', 'top-bar-organizer@julian.gse.jsts.xyz', 'pico-system-monitor@hiddewie', 'tophat@fflewddur.github.io', 'addshutbutton@flioner@jerom@olika.ovh', 'xremap@k0kubun.com', 'native-window-placement@gnome-shell-extensions.gcampax.github.com', 'auto-move-windows@gnome-shell-extensions.gcampax.github.com', 'x11gestures@joseexposito.github.io', 'ding@rastersoft.com', 'ubuntu-dock@ubuntu.com', 'tiling-assistant@ubuntu.com', 'Vitals@CoreCoding.com']"
    gsettings set org.gnome.shell.extensions.dash-to-dock extend-height false
    gsettings set org.gnome.shell.extensions.dash-to-dock dock-position BOTTOM
    gsettings set org.gnome.shell.extensions.dash-to-dock dash-max-icon-size 38
    gsettings set org.gnome.shell.extensions.dash-to-dock dock-fixed false
    gsettings set org.gnome.desktop.notifications show-banners false

    # gsettings set org.gnome.settings-daemon.plugins.power sleep-display-ac 600

    firewall() {
        # sudo ufw status
        sudo ufw --force enable
        # sudo ufw disable
    }
    firewall

    sudo rfkill block bluetooth
    return 0
)

# Subshell + set +e : `git config --global user.name` retourne 1 si non défini,
# ce qui ferait abort avec set -e propagé. Le subshell isole.
gitinit() (
    set +e

    setGitConfig() {
        echo "Enter your git name"
        read -r gitName
        git config --global user.name "$gitName"
        echo "Enter your git email"
        read -r gitEmail
        git config --global user.email "$gitEmail"
        git config --list --global
    }

    echo -e "${color4}- git ${colorEnd}"
    local gitNamee
    gitNamee=$(git config --global user.name)
    if [ -z "$gitNamee" ]; then
        selections=( "Yes" "No" )
        choose_from_menu "Do you want to set your git name and email? " selected_choice "${selections[@]}"
        case $selected_choice in
            Yes ) setGitConfig;;
            No ) ;;
        esac
    else
        echo -e "Your git name is ${color3}${gitNamee}${colorEnd}"
    fi

    echo -e "${color4}- github ${colorEnd}"
    if ! command -v gh >/dev/null 2>&1; then
        echo -e "${colorB}WARNING: gh not installed, skipping github auth.${colorEnd}"
        return 0
    fi
    if gh auth status >/dev/null 2>&1; then
        gh auth status
    else
        selections=( "No" "Yes" )
        choose_from_menu "Do you want to connect to your github? " selected_choice "${selections[@]}"
        case $selected_choice in
            Yes ) gh auth login;;
            No ) ;;
        esac
    fi

    return 0
)

askForReboot() {
    echo -e "${color4}- reboot ${colorEnd}"
    selections=( "No" "Yes" )
    choose_from_menu "Do you want to reboot? " selected_choice "${selections[@]}"
    case $selected_choice in
        Yes ) sudo reboot;;
        No ) return;;
    esac
}
