#!/bin/bash

# Codes de couleur ANSI
BLUE_TEXT="\e[34m"    # Texte bleu
RESET="\e[0m"         # Reset des couleurs
BOLD="\e[1m"          # Texte gras

# Fonction pour afficher le menu
show_menu() {
    local selected=$1
    shift
    local options=("$@")

    clear
    echo -e "${BOLD}=== Menu de sélection ===${RESET}"
    echo ""

    for i in "${!options[@]}"; do
        if [ $i -eq $selected ]; then
            # Ligne sélectionnée : texte bleu et gras
            echo -e "${BOLD}${BLUE_TEXT}▶ ${options[$i]}${RESET}"
        else
            # Ligne non sélectionnée : texte normal
            echo "  ${options[$i]}"
        fi
    done

    echo ""
    # echo -e "${BLUE_TEXT}↑/↓ naviguer | → sélectionner | ← retour | Entrée valider | q quitter${RESET}"
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
                # echo "Vous avez sélectionné: ${options[$selected]}"
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
                    '[C') # Flèche droite - Sélectionner
                        echo ""
                        # echo "Vous avez sélectionné: ${options[$selected]}"
                        return $selected
                        ;;
                    '[D') # Flèche gauche - Retour en arrière
                        echo ""
                        # echo "Annulé"
                        return 255
                        ;;
                esac
                ;;
        esac
    done
}
