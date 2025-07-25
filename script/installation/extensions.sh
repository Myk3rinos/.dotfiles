#!/bin/bash

source ~/.dotfiles/script/colors.sh



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

# Fonction pour installer l'extension GNOME Shell X11 Gestures
install_x11_gestures() {
    echo "Installation de l'extension X11 Gestures..."
    # Installer les dépendances nécessaires
    sudo apt-get update
    sudo apt-get install -y libinput-tools xdotool git make

    # Cloner le dépôt de l'extension
    git clone https://github.com/JoseExposito/gnome-shell-extension-x11gestures.git /tmp/x11gestures

    # Compiler et installer
    cd /tmp/x11gestures
    make install

    # Activer l'extension
    gnome-extensions enable x11gestures@joseexposito.github.io

    echo "Installation de X11 Gestures terminée."
    
    # Nettoyer
    cd -
    rm -rf /tmp/x11gestures

}

# Fonction pour installer l'extension GNOME Shell Caffeine
install_caffeine() {
    echo "Installation de l'extension Caffeine..."
    # Obtenir la version de GNOME Shell
    SHELL_VERSION=$(gnome-shell --version | cut -d ' ' -f 3 | cut -d '.' -f 1)
    if [ -z "$SHELL_VERSION" ]; then
        echo "Impossible de déterminer la version de GNOME Shell."
        return 1
    fi
    echo "Version de GNOME Shell détectée : $SHELL_VERSION"

    # UUID de l'extension Caffeine
    UUID="caffeine@patapon.info"
    
    # Télécharger et installer
    EXTENSION_URL="https://extensions.gnome.org/download-extension/${UUID}.shell-extension.zip?shell_version=${SHELL_VERSION}"
    TMP_ZIP="/tmp/${UUID}.zip"
    
    echo "Téléchargement depuis ${EXTENSION_URL}"
    if ! wget -O "$TMP_ZIP" "$EXTENSION_URL"; then
        echo "Échec du téléchargement de l'extension. L'extension n'est peut-être pas compatible avec votre version de GNOME Shell."
        rm -f "$TMP_ZIP"
        return 1
    fi
    
    # Installer l'extension
    gnome-extensions install --force "$TMP_ZIP"
    
    # Activer l'extension
    gnome-extensions enable "$UUID"
    
    # Nettoyer
    rm "$TMP_ZIP"
    
    echo "Installation de Caffeine terminée."
}

# Fonction pour installer l'extension GNOME Shell Clipboard Indicator
install_clipboard_indicator() {
    echo "Installation de l'extension Clipboard Indicator..."
    git clone https://github.com/Tudmotu/gnome-shell-extension-clipboard-indicator.git ~/.local/share/gnome-shell/extensions/clipboard-indicator@tudmotu.com
    gnome-extensions enable clipboard-indicator@tudmotu.com
    echo "Installation de Clipboard Indicator terminée."
    # restart_gnome
}

# Fonction pour installer l'extension GNOME Shell Vitals
install_vitals() {
    echo "Installation de l'extension Vitals..."
    # Installer les dépendances nécessaires
    sudo apt-get update
    sudo apt-get install -y gir1.2-gtop-2.0 gir1.2-nm-1.0 gir1.2-clutter-1.0
    
    # Cloner le dépôt de l'extension
    git clone https://github.com/corecoding/Vitals.git ~/.local/share/gnome-shell/extensions/Vitals@CoreCoding.com
    
    # Activer l'extension
    gnome-extensions enable Vitals@CoreCoding.com
    
    echo "Installation de Vitals terminée."
}


# Ensuite, vous pouvez appeler chaque fonction par son nom:
installExtensions() {
    echo -e "------------------${color2} ¤${colorEnd} ${color3}| Install extensions |${colorEnd}---"
    install_x11_gestures
    install_clipboard_indicator
    install_caffeine
    install_vitals
    # restart_gnome
}

