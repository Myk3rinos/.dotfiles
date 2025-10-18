#!/bin/bash

# Codes de couleur ANSI
BLUE_TEXT="\e[34m"    # Texte bleu
RESET="\e[0m"         # Reset des couleurs
BOLD="\e[1m"          # Texte gras

# Fonction pour afficher le menu avec scrolling
show_menu() {
    local selected=$1
    shift
    local options=("$@")

    # Calculer la hauteur disponible (terminal height - header - footer - marge)
    local term_height=$(tput lines)
    local max_visible=$((term_height - 6))

    # Si trop peu de lignes, utiliser un minimum
    if [ $max_visible -lt 10 ]; then
        max_visible=10
    fi

    # Calculer la fenêtre de visualisation
    local total=${#options[@]}
    local offset=0

    # Ajuster l'offset pour que l'élément sélectionné soit visible
    if [ $selected -ge $max_visible ]; then
        offset=$((selected - max_visible + 1))
    fi

    # S'assurer que l'offset ne dépasse pas
    if [ $((offset + max_visible)) -gt $total ]; then
        offset=$((total - max_visible))
    fi

    # L'offset ne peut pas être négatif
    if [ $offset -lt 0 ]; then
        offset=0
    fi

    clear
    echo -e "${BOLD}=== Menu de sélection ===${RESET}"
    echo ""

    # Indicateur si on peut scroller vers le haut
    if [ $offset -gt 0 ]; then
        echo -e "${BLUE_TEXT}  ▲ Plus d'options ci-dessus...${RESET}"
    fi

    # Afficher uniquement les éléments visibles
    local end=$((offset + max_visible))
    if [ $end -gt $total ]; then
        end=$total
    fi

    for ((i=offset; i<end; i++)); do
        if [ $i -eq $selected ]; then
            # Ligne sélectionnée : texte bleu et gras
            echo -e "${BOLD}${BLUE_TEXT}▶ ${options[$i]}${RESET}"
        else
            # Ligne non sélectionnée : texte normal
            echo "  ${options[$i]}"
        fi
    done

    # Indicateur si on peut scroller vers le bas
    if [ $end -lt $total ]; then
        echo -e "${BLUE_TEXT}  ▼ Plus d'options ci-dessous...${RESET}"
    fi

    echo ""
    # echo -e "${BLUE_TEXT}↑/↓ naviguer | → ou Entrée valider | ← ou q retour${RESET}"
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
                return 254
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
