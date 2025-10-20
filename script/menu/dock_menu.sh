#!/bin/bash

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
            echo "" # nf-fa-folder_open
            ;;
        *kitty*|*terminal*|*gnome-terminal*|*konsole*|*alacritty*)
            echo "" # nf-dev-terminal
            ;;
        *firefox*)
            echo "󰈹" # nf-md-firefox
            ;;
        *chrome*|*chromium*)
            echo "" # nf-fa-chrome
            ;;
        *code*|*vscode*|*vscodium*)
            echo "󰨞" # nf-md-code
            ;;
        *windsurf*)
            echo "󰙯" # nf-md-weather_windy
            ;;
        *extension*|*extensions*)
            echo "󰏗" # nf-md-puzzle
            ;;
        *rhythmbox*|*music*|*spotify*)
            echo "󰎆" # nf-md-music
            ;;
        *tweak*)
            echo "" # nf-fa-cog
            ;;
        *settings*|*paramètres*|*configuration*)
            echo "" # nf-fa-cog
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
        *)
            # Icône par défaut
            echo "󰣆" # nf-md-application
            ;;
    esac
}

# Fonction pour obtenir les applications du Dock
get_dock_apps() {
    local apps_raw=$(gsettings get org.gnome.shell favorite-apps 2>/dev/null)

    if [ -z "$apps_raw" ]; then
        # Fallback si gsettings ne fonctionne pas
        echo " Nautilus|nautilus"
        echo " Kitty|kitty"
        echo "󰈹 Firefox|firefox"
        return
    fi

    # Parser les applications favorites
    echo "$apps_raw" | tr -d "[]'" | tr ',' '\n' | while read -r app; do
        app=$(echo "$app" | xargs) # Trim whitespace
        [ -z "$app" ] && continue

        # Extraire le nom depuis le fichier .desktop
        local desktop_file=""
        if [ -f "/usr/share/applications/$app" ]; then
            desktop_file="/usr/share/applications/$app"
        elif [ -f "$HOME/.local/share/applications/$app" ]; then
            desktop_file="$HOME/.local/share/applications/$app"
        elif [ -f "/var/lib/snapd/desktop/applications/$app" ]; then
            desktop_file="/var/lib/snapd/desktop/applications/$app"
        fi

        if [ -n "$desktop_file" ]; then
            local name=$(grep "^Name=" "$desktop_file" | head -1 | cut -d'=' -f2)
            local exec=$(grep "^Exec=" "$desktop_file" | head -1 | cut -d'=' -f2 | awk '{print $1}')

            if [ -n "$name" ] && [ -n "$exec" ]; then
                local icon=$(get_app_icon "$name" "$exec")
                echo "$icon $name|$exec"
            fi
        fi
    done
}

# Menu des applications
show_dock_menu() {
    local apps=()
    local commands=()

    # Lire les applications du dock
    while IFS='|' read -r name cmd; do
        apps+=("$name")
        commands+=("$cmd")
    done < <(get_dock_apps)

    if [ ${#apps[@]} -eq 0 ]; then
        echo "Aucune application trouvée dans le Dock"
        return 1
    fi

    # Ajouter un séparateur visuel
    apps+=("───────────────────")
    commands+=("")

    # Ajouter le lanceur d'applications
    local show_apps=$(gsettings get org.gnome.shell.extensions.dash-to-dock show-show-apps-button 2>/dev/null)
    if [ "$show_apps" = "true" ]; then
        apps+=("󰕰 Afficher les applications")
        commands+=("gnome-control-center applications")
    fi

    # Ajouter les médias (montés et non montés)
    local show_mounts=$(gsettings get org.gnome.shell.extensions.dash-to-dock show-mounts 2>/dev/null)
    if [ "$show_mounts" = "true" ]; then
        # Détecter les volumes avec lsblk (supporte chiffré, monté et non monté)
        while IFS='|' read -r name label fstype size mountpoint; do
            # Ignorer les lignes vides et les disques sans système de fichiers
            [ -z "$name" ] && continue

            # On s'intéresse aux partitions amovibles (sd*, mmcblk*)
            if [[ "$name" =~ ^(sd[a-z][0-9]+|mmcblk[0-9]+p[0-9]+)$ ]]; then
                local device_path="/dev/$name"
                local display_name="$label"

                # Si pas de label, utiliser la taille comme nom
                if [ -z "$display_name" ]; then
                    display_name="$size"
                fi

                # Volume chiffré
                if [ "$fstype" = "crypto_LUKS" ]; then
                    display_name="$display_name chiffrés"
                fi

                if [ -n "$mountpoint" ]; then
                    # Volume monté
                    apps+=("󰋊 $display_name")
                    commands+=("nautilus \"$mountpoint\"")
                else
                    # Volume non monté - Nautilus gérera le montage/déverrouillage
                    apps+=("󰋊 $display_name (non monté)")
                    commands+=("nautilus \"file://$device_path\"")
                fi
            fi
        done < <(/usr/bin/lsblk -nlo NAME,LABEL,FSTYPE,SIZE,MOUNTPOINT | tr -s ' ' '|')
    fi

    # Ajouter la corbeille
    local show_trash=$(gsettings get org.gnome.shell.extensions.dash-to-dock show-trash 2>/dev/null)
    if [ "$show_trash" = "true" ]; then
        apps+=("󰩺 Corbeille")
        commands+=("nautilus trash:///")
    fi

    # Ajouter l'option retour
    apps+=("───────────────────")
    commands+=("")
    apps+=("󰌍 Retour")
    commands+=("")

    # Afficher le menu
    menu_select "${apps[@]}"
    local result=$?

    if [ $result -eq 255 ]; then
        # Flèche gauche - retour au menu principal
        return 0
    elif [ $result -eq $((${#apps[@]} - 1)) ]; then
        # Option retour sélectionnée
        return 0
    elif [ "${apps[$result]}" = "───────────────────" ]; then
        # Séparateur sélectionné - ne rien faire et réafficher le menu
        return 0
    elif [ -z "${commands[$result]}" ]; then
        # Commande vide - ne rien faire
        return 0
    else
        # Lancer l'application sélectionnée
        echo "Lancement de ${apps[$result]}..."
        eval ${commands[$result]} &>/dev/null &
        disown
        return 0
    fi
}
