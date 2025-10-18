#!/bin/bash

# Obtenir le répertoire du script
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Importer la bibliothèque de menu
source "$SCRIPT_DIR/menu_lib.sh"

# Fonction pour afficher le menu des thèmes
show_themes_menu() {
    # Options du menu des thèmes
    local THEMES=(
        " Dracula"
        " Ayu"
        "← Retour"
    )

    # Appeler le menu
    menu_select "${THEMES[@]}"
    local result=$?

    # Si annulé ou retour
    if [ $result -eq 1 ] || [ $result -eq 255 ]; then
        return 0
    fi

    case $result in
        0)
            echo "Thème Dracula sélectionné"
            sleep 2
            ;;
        1)
            echo "Thème Ayu sélectionné"
            sleep 2
            ;;
        2)
            # Retour
            return 0
            ;;
    esac
}
