#!/bin/bash

# Obtenir le répertoire du script
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Importer la bibliothèque de menu
source "$SCRIPT_DIR/menu_lib.sh"

# Fonction pour afficher le menu des applications terminal
show_terminal_apps_menu() {
    # Options du menu des applications terminal
    local APPS=(
        "󰕮 btop"
        "󰚗 screenfetch"
        " music"
        " nvim"
        "󰕮 yazi"
        " lsblk"
        "← Retour"
    )

    # Appeler le menu
    menu_select "${APPS[@]}"
    local result=$?

    # Si annulé ou retour
    if [ $result -eq 255 ]; then
        return 0
    fi

    case $result in
        0)
            # Lancer btop
            clear
            # Redimensionner la fenêtre OS pour btop (plus grande pour l'interface musicale)
            kitty @ resize-os-window --width 100 --height 40 2>/dev/null || true
            btop
            # Restaurer la taille d'origine du menu (300x600 selon kitty_menu.conf)
            kitty @ resize-os-window --width 30 --height 40 2>/dev/null || true
            ;;
        1)
            # Lancer screenfetch
            clear
            # Redimensionner la fenêtre OS pour screenfetch (plus grande pour l'interface musicale)
            kitty @ resize-os-window --width 100 --height 40 2>/dev/null || true
            screenfetch
            # Restaurer la taille d'origine du menu (300x600 selon kitty_menu.conf)
            kitty @ resize-os-window --width 30 --height 40 2>/dev/null || true
            ;;
        2)
            # Lancer music
            clear
            # Redimensionner la fenêtre OS pour rmpc (plus grande pour l'interface musicale)
            kitty @ resize-os-window --width 100 --height 40 2>/dev/null || true
            rmpc
            # Restaurer la taille d'origine du menu (300x600 selon kitty_menu.conf)
            kitty @ resize-os-window --width 30 --height 40 2>/dev/null || true
            ;;
        3)
            # Lancer nvim
            clear
            # Redimensionner la fenêtre OS pour nvim (plus grande pour l'interface musicale)
            kitty @ resize-os-window --width 100 --height 40 2>/dev/null || true
            nvim
            # Restaurer la taille d'origine du menu (300x600 selon kitty_menu.conf)
            kitty @ resize-os-window --width 30 --height 40 2>/dev/null || true
            ;;
        4)
            # Lancer yazi
            clear
            # Redimensionner la fenêtre OS pour yazi (plus grande pour l'interface musicale)
            kitty @ resize-os-window --width 100 --height 40 2>/dev/null || true
            yazi
            # Restaurer la taille d'origine du menu (300x600 selon kitty_menu.conf)
            kitty @ resize-os-window --width 30 --height 40 2>/dev/null || true
            ;;
        5)
            # Lancer lsblk
            clear
            # Redimensionner la fenêtre OS pour nvim (plus grande pour l'interface musicale)
            kitty @ resize-os-window --width 100 --height 40 2>/dev/null || true
            kitty lsblk
            # Restaurer la taille d'origine du menu (300x600 selon kitty_menu.conf)
            kitty @ resize-os-window --width 30 --height 40 2>/dev/null || true
            ;;
        6)
            # Retour
            return 0
            ;;
    esac
}
