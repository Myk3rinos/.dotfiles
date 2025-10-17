#!/bin/bash

# Fonction pour obtenir les applications du Dock
get_dock_apps() {
    local apps_raw=$(gsettings get org.gnome.shell favorite-apps 2>/dev/null)

    if [ -z "$apps_raw" ]; then
        # Fallback si gsettings ne fonctionne pas
        echo "Nautilus|nautilus"
        echo "Kitty|kitty"
        echo "Firefox|firefox"
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
        fi

        if [ -n "$desktop_file" ]; then
            local name=$(grep "^Name=" "$desktop_file" | head -1 | cut -d'=' -f2)
            local exec=$(grep "^Exec=" "$desktop_file" | head -1 | cut -d'=' -f2 | awk '{print $1}')

            if [ -n "$name" ] && [ -n "$exec" ]; then
                echo "$name|$exec"
            fi
        fi
    done
}

# Menu des applications
show_applications_menu() {
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

    # Ajouter l'option retour
    apps+=("← Retour")

    # Afficher le menu
    menu_select "${apps[@]}"
    local result=$?

    if [ $result -eq 1 ]; then
        return 1
    elif [ $result -eq $((${#apps[@]} - 1)) ]; then
        # Option retour sélectionnée
        return 0
    else
        # Lancer l'application sélectionnée
        echo "Lancement de ${apps[$result]}..."
        ${commands[$result]} &>/dev/null &
        disown
        return 0
    fi
}
