#!/bin/bash

# Obtenir le répertoire du script
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Importer la bibliothèque de menu
source "$SCRIPT_DIR/menu_lib.sh"

# Importer les menus
source "$SCRIPT_DIR/dock_menu.sh"
source "$SCRIPT_DIR/terminal_apps_menu.sh"
source "$SCRIPT_DIR/themes_menu.sh"

# Menu principal
if [ "${BASH_SOURCE[0]}" == "${0}" ]; then
    while true; do
        # Options du menu principal
        OPTIONS=(
            "󰀻 Dock"
            " Applications Terminal"
            "󰀻 Applications"
            " Thèmes"
            "󰒕 Option 5"
            "󰗼 Quitter"
        )

        # Appeler le menu
        menu_select "${OPTIONS[@]}"
        result=$?

        if [ $result -eq 255 ]; then
            # echo "Au revoir!"
            exit 0
        fi

        case $result in
            0)
                # Dock
                show_dock_menu
                ;;
            1)
                # Applications Terminal
                show_terminal_apps_menu
                ;;
            2)
                # Applications
                show_applications_menu
                ;;
            3)
                # Thèmes
                show_themes_menu
                ;;
            4)
                # Option 5
                echo "Option 5 sélectionnée"
                sleep 2
                ;;
            5)
                # Quitter
                # echo "Au revoir!"
                exit 0
                ;;
        esac
    done
fi
