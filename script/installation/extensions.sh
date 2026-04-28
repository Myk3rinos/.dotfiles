#!/bin/bash

source ~/.dotfiles/.themes/colors.sh



# Fonction pour redémarrer GNOME Shell
restart_gnome() {
    echo "Pour que les changements prennent effet, GNOME Shell doit être redémarré."
    if [ "$XDG_SESSION_TYPE" = "wayland" ]; then
        echo "ATTENTION : Vous utilisez Wayland. Le redémarrage automatique de GNOME Shell mettra fin à votre session."
        echo "Veuillez enregistrer votre travail et vous déconnecter/reconnecter manuellement."
    else
        echo "Redémarrage de GNOME Shell dans 5 secondes... (Ctrl+C pour annuler)"
        sleep 5
        # killall -3 gnome-shell
        pkill -TERM gnome-shell
    fi
}

# Helper : installation idempotente d'une extension depuis extensions.gnome.org
install_extension_from_ego() {
    local uuid="$1"
    local shell_version
    shell_version=$(gnome-shell --version | cut -d ' ' -f 3 | cut -d '.' -f 1)
    if [ -z "$shell_version" ]; then
        echo -e "${colorB}Impossible de déterminer la version de GNOME Shell.${colorEnd}"
        return 1
    fi

    if gnome-extensions list 2>/dev/null | grep -qx "$uuid"; then
        echo -e "${color4}- Extension ${uuid} déjà installée ${colorEnd}"
    else
        local extension_url="https://extensions.gnome.org/download-extension/${uuid}.shell-extension.zip?shell_version=${shell_version}"
        local tmp_zip
        tmp_zip=$(mktemp /tmp/${uuid}.XXXXXX.zip)
        echo "Téléchargement de ${uuid} depuis ${extension_url}"
        if ! wget -qO "$tmp_zip" "$extension_url"; then
            echo -e "${colorB}Échec du téléchargement de ${uuid}. Peut-être incompatible avec GNOME Shell ${shell_version}.${colorEnd}"
            rm -f "$tmp_zip"
            return 1
        fi
        gnome-extensions install --force "$tmp_zip"
        rm -f "$tmp_zip"
    fi

    gnome-extensions enable "$uuid" 2>/dev/null || true
}

# Fonction pour installer l'extension GNOME Shell X11 Gestures
install_x11_gestures() {
    echo "Installation de l'extension X11 Gestures..."
    # Installer les dépendances nécessaires
    sudo apt-get update
    sudo apt-get install -y libinput-tools xdotool git make meson ninja-build

    # Cloner le dépôt de l'extension (idempotent)
    rm -rf /tmp/x11gestures
    git clone https://github.com/JoseExposito/gnome-shell-extension-x11gestures.git /tmp/x11gestures

    # Compiler et installer
    pushd /tmp/x11gestures > /dev/null
    if [ -f meson.build ]; then
        meson setup build
        sudo ninja -C build install
    else
        make install
    fi
    popd > /dev/null

    # Activer l'extension
    gnome-extensions enable x11gestures@joseexposito.github.io 2>/dev/null || true

    echo "Installation de X11 Gestures terminée."

    # Nettoyer
    rm -rf /tmp/x11gestures
}

# Fonction pour installer l'extension GNOME Shell Caffeine
install_caffeine() {
    echo "Installation de l'extension Caffeine..."
    install_extension_from_ego "caffeine@patapon.info"
    echo "Installation de Caffeine terminée."
}

# Fonction pour installer l'extension GNOME Shell Clipboard Indicator
install_clipboard_indicator() {
    echo "Installation de l'extension Clipboard Indicator..."
    local dest=~/.local/share/gnome-shell/extensions/clipboard-indicator@tudmotu.com
    if [ -d "$dest" ]; then
        git -C "$dest" pull --ff-only || true
    else
        git clone https://github.com/Tudmotu/gnome-shell-extension-clipboard-indicator.git "$dest"
    fi
    gnome-extensions enable clipboard-indicator@tudmotu.com 2>/dev/null || true
    echo "Installation de Clipboard Indicator terminée."
}

# Fonction pour installer l'extension GNOME Shell Vitals
install_vitals() {
    echo "Installation de l'extension Vitals..."
    # Installer les dépendances nécessaires
    sudo apt-get update
    sudo apt-get install -y gir1.2-gtop-2.0 gir1.2-nm-1.0 gir1.2-clutter-1.0

    local dest=~/.local/share/gnome-shell/extensions/Vitals@CoreCoding.com
    if [ -d "$dest" ]; then
        git -C "$dest" pull --ff-only || true
    else
        git clone https://github.com/corecoding/Vitals.git "$dest"
    fi

    gnome-extensions enable Vitals@CoreCoding.com 2>/dev/null || true

    echo "Installation de Vitals terminée."
}

# Installation des extensions disponibles sur extensions.gnome.org
# (celles activées dans configure.sh mais sans installation dédiée)
install_ego_extensions() {
    echo "Installation des extensions extensions.gnome.org..."
    local extensions=(
        "tophat@fflewddur.github.io"
        "mediacontrols@cliffniff.github.com"
        "extension-list@tu.berry"
        "color-picker@tuberry"
        "desk-changer@eric.gach.gmail.com"
        "top-bar-organizer@julian.gse.jsts.xyz"
        "pico-system-monitor@hiddewie"
        "xremap@k0kubun.com"
    )
    for uuid in "${extensions[@]}"; do
        install_extension_from_ego "$uuid" || true
    done
}


# Ensuite, vous pouvez appeler chaque fonction par son nom:
installExtensions() {
    echo -e "------------------${color2} ¤${colorEnd} ${color3}| Install extensions |${colorEnd}---"
    install_x11_gestures
    install_clipboard_indicator
    install_caffeine
    install_vitals
    install_ego_extensions
    # restart_gnome
}
