#!/bin/bash

# Obtenir le répertoire du script
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Importer le menu des applications
source "$SCRIPT_DIR/applications_menu.sh"

# Fonction pour afficher le menu
show_menu() {
    local selected=$1
    shift
    local options=("$@")

    clear
    echo "=== Menu de sélection ==="
    echo ""

    for i in "${!options[@]}"; do
        if [ $i -eq $selected ]; then
            echo "▶ ${options[$i]}"
        else
            echo "  ${options[$i]}"
        fi
    done

    echo ""
    echo "Utilisez ↑/↓ pour naviguer, Entrée pour sélectionner, q pour quitter"
}

# Fonction principale de sélection
menu_select() {
    local options=("$@")
    local selected=0
    local key=""

    # Sauvegarder les paramètres du terminal
    local old_stty=$(stty -g)

    while true; do
        show_menu $selected "${options[@]}"

        # Lire une touche
        stty raw -echo
        key=$(dd bs=1 count=1 2>/dev/null)
        stty "$old_stty"

        case "$key" in
            # Touche q pour quitter
            q|Q)
                echo ""
                echo "Annulé"
                return 1
                ;;
            # Touche Entrée (gestion de multiples codes)
            $'\x0a'|$'\x0d'|'')
                echo ""
                echo "Vous avez sélectionné: ${options[$selected]}"
                return $selected
                ;;
            # Séquence d'échappement (flèches)
            $'\x1b')
                # Lire les deux caractères suivants
                stty raw -echo
                read -n 2 -t 0.1 key
                stty "$old_stty"

                case "$key" in
                    '[A') # Flèche haut
                        ((selected--))
                        if [ $selected -lt 0 ]; then
                            selected=$((${#options[@]} - 1))
                        fi
                        ;;
                    '[B') # Flèche bas
                        ((selected++))
                        if [ $selected -ge ${#options[@]} ]; then
                            selected=0
                        fi
                        ;;
                esac
                ;;
        esac
    done
}

# Menu principal
if [ "${BASH_SOURCE[0]}" == "${0}" ]; then
    while true; do
        # Options du menu principal
        OPTIONS=(
            "Applications"
            "Option 2"
            "Option 3"
            "Option 4"
            "Quitter"
        )

        # Appeler le menu
        menu_select "${OPTIONS[@]}"
        result=$?

        if [ $result -eq 1 ]; then
            echo "Au revoir!"
            exit 0
        fi

        case $result in
            0)
                # Applications
                show_applications_menu
                ;;
            1)
                echo "Option 2 sélectionnée"
                sleep 2
                ;;
            2)
                echo "Option 3 sélectionnée"
                sleep 2
                ;;
            3)
                echo "Option 4 sélectionnée"
                sleep 2
                ;;
            4)
                # Quitter
                echo "Au revoir!"
                exit 0
                ;;
        esac
    done
fi
