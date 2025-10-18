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
            btop
            ;;
        1)
            # Lancer screenfetch
            clear
            screenfetch
            # echo ""
            # read -p "Appuyez sur Entrée pour continuer..."
            ;;
        2)
            # Lancer music
            clear
            rmpc
            ;;
        3)
            # Lancer nvim
            clear
            nvim
            ;;
        4)
            # Retour
            return 0
            ;;
    esac
}
