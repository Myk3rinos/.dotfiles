#!/bin/bash

# Obtenir le répertoire du script
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Importer la bibliothèque de menu
source "$SCRIPT_DIR/menu_lib.sh"

# Fonction pour obtenir l'icône Nerd Font d'une application
get_app_icon() {
    local app_name="$1"
    local exec_cmd="$2"

    # Convertir en minuscules pour la comparaison
    local app_lower=$(echo "$app_name" | tr '[:upper:]' '[:lower:]')
    local exec_lower=$(echo "$exec_cmd" | tr '[:upper:]' '[:lower:]')

    # Mapper les applications aux icônes Nerd Font
    case "$app_lower" in
        *nautilus*|*files*|*fichiers*)
            echo "" # nf-fa-folder_open
            ;;
        *kitty*|*terminal*|*gnome-terminal*|*konsole*|*alacritty*)
            echo "" # nf-dev-terminal
            ;;
        *firefox*)
            echo "󰈹" # nf-md-firefox
            ;;
        *chrome*|*chromium*)
            echo "" # nf-fa-chrome
            ;;
        *code*|*vscode*|*vscodium*)
            echo "󰨞" # nf-md-code
            ;;
        *windsurf*)
            echo "󰙯" # nf-md-weather_windy
            ;;
        *cursor*)
            echo "󰆍" # nf-md-cursor_default
            ;;
        *extension*|*extensions*)
            echo "󰏗" # nf-md-puzzle
            ;;
        *rhythmbox*|*music*|*spotify*)
            echo "󰎆" # nf-md-music
            ;;
        *tweak*)
            echo "" # nf-fa-cog
            ;;
        *settings*|*paramètres*|*configuration*)
            echo "" # nf-fa-cog
            ;;
        *mail*|*thunderbird*|*evolution*)
            echo "󰇮" # nf-md-email
            ;;
        *calculator*|*calculatrice*)
            echo "󰃬" # nf-md-calculator
            ;;
        *text*|*editor*|*gedit*)
            echo "󰷈" # nf-md-text
            ;;
        *image*|*gimp*|*inkscape*)
            echo "󰋩" # nf-md-image
            ;;
        *video*|*vlc*|*mpv*)
            echo "󰕧" # nf-md-video
            ;;
        *libreoffice*)
            echo "󰈙" # nf-md-file_document
            ;;
        *)
            # Icône par défaut
            echo "󰣆" # nf-md-application
            ;;
    esac
}

# Fonction pour obtenir toutes les applications du lanceur
get_all_apps() {
    local app_dirs=(
        "/usr/share/applications"
        "$HOME/.local/share/applications"
        "/var/lib/snapd/desktop/applications"
    )

    declare -A seen_names

    for app_dir in "${app_dirs[@]}"; do
        if [ -d "$app_dir" ]; then
            while IFS= read -r desktop_file; do
                # Ignorer les applications cachées
                if grep -q "^NoDisplay=true" "$desktop_file" 2>/dev/null; then
                    continue
                fi

                local name=$(grep "^Name=" "$desktop_file" | head -1 | cut -d'=' -f2)
                local exec=$(grep "^Exec=" "$desktop_file" | head -1 | cut -d'=' -f2)

                # Nettoyer la commande exec (retirer les %U, %F, etc.)
                exec=$(echo "$exec" | sed 's/%[a-zA-Z]//g' | xargs)

                if [ -n "$name" ] && [ -n "$exec" ]; then
                    # Éviter les doublons
                    if [ -z "${seen_names[$name]}" ]; then
                        seen_names[$name]=1
                        local icon=$(get_app_icon "$name" "$exec")
                        echo "$icon $name|$exec"
                    fi
                fi
            done < <(find "$app_dir" -maxdepth 1 -name "*.desktop" 2>/dev/null | sort)
        fi
    done
}

# Menu des applications
show_applications_menu() {
    # Définir le titre du sous-menu
    MENU_TITLE="=== 󰀻 Applications ==="

    local apps=()
    local commands=()

    # Lire toutes les applications disponibles
    while IFS='|' read -r name cmd; do
        apps+=("$name")
        commands+=("$cmd")
    done < <(get_all_apps | sort)

    if [ ${#apps[@]} -eq 0 ]; then
        echo "Aucune application trouvée"
        sleep 2
        return 1
    fi

    # Ajouter l'option retour
    apps+=("← Retour")
    commands+=("")

    # Afficher le menu
    menu_select "${apps[@]}"
    local result=$?

    if [ $result -eq 255 ] || [ $result -eq 1 ]; then
        # Flèche gauche ou q - retour au menu principal
        return 0
    elif [ $result -eq $((${#apps[@]} - 1)) ]; then
        # Option retour sélectionnée
        return 0
    elif [ -z "${commands[$result]}" ]; then
        # Commande vide - ne rien faire
        return 0
    else
        # Lancer l'application sélectionnée
        clear
        echo "Lancement de ${apps[$result]}..."
        eval ${commands[$result]} &>/dev/null &
        disown
        sleep 1
        return 0
    fi
}
