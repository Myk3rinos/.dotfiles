#!/bin/bash

# Obtenir le répertoire du script
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Importer la bibliothèque de menu
source "$SCRIPT_DIR/menu_lib.sh"

# Chemin vers le dossier des thèmes
THEMES_DIR="$HOME/.dotfiles/.themes"
COLORS_FILE="$HOME/.dotfiles/.themes/colors.sh"

# Fonction pour appliquer un thème de couleurs
apply_color_theme() {
    local theme_dir="$1"
    local theme_name="$2"

    # Chercher un fichier de couleurs dans le dossier du thème
    local color_file=""

    # Rechercher les fichiers avec différentes conventions de nommage
    if [ -f "$theme_dir/${theme_name}_colors.sh" ]; then
        # Avec le nom exact du thème (ex: AlphaBlueNeon_colors.sh)
        color_file="$theme_dir/${theme_name}_colors.sh"
    elif [ -f "$theme_dir/${theme_name,,}_colors.sh" ]; then
        # Avec le nom en minuscules (ex: alphablueneon_colors.sh)
        color_file="$theme_dir/${theme_name,,}_colors.sh"
    elif [ -f "$theme_dir/colors.sh" ]; then
        # Fichier colors.sh générique
        color_file="$theme_dir/colors.sh"
    else
        # Recherche flexible: trouver n'importe quel fichier *_colors.sh
        color_file=$(find "$theme_dir" -maxdepth 1 -name "*_colors.sh" -o -name "colors.sh" | head -1)
    fi

    if [ -n "$color_file" ] && [ -f "$color_file" ]; then
        echo "Application des couleurs du thème: $theme_name"
        cp "$color_file" "$COLORS_FILE"
        echo "Couleurs appliquées avec succès!"

        # Régénérer la configuration rmpc avec les nouvelles couleurs
        if [ -f "$HOME/.dotfiles/rmpc/generate-config.sh" ]; then
            echo "Génération de la configuration rmpc..."
            bash "$HOME/.dotfiles/rmpc/generate-config.sh"
        fi

        echo ""
        exec "$HOME/.dotfiles/script/menu/menu_select.sh"
        # echo "Voulez-vous redémarrer le menu pour voir les nouvelles couleurs ?"
        # echo "1) Oui - Redémarrer le menu"
        # echo "2) Non - Continuer"
        # read -p "Choisissez (1 ou 2): " restart_choice

        # if [ "$restart_choice" = "1" ]; then
        #     echo "Redémarrage du menu..."
        #     sleep 1
        #     # Redémarrer le script du menu
        #     exec "$HOME/.dotfiles/script/menu/menu_select.sh"
        # fi

        return 0
    else
        echo "Aucun fichier de couleurs trouvé pour ce thème"
        sleep 2
        return 1
    fi
}

# Fonction pour générer une ligne de carrés colorés pour un thème
get_color_map() {
    local theme_dir="$1"
    local theme_name="$2"

    # Chercher le fichier de couleurs
    local color_file=""
    if [ -f "$theme_dir/${theme_name}_colors.sh" ]; then
        color_file="$theme_dir/${theme_name}_colors.sh"
    elif [ -f "$theme_dir/${theme_name,,}_colors.sh" ]; then
        color_file="$theme_dir/${theme_name,,}_colors.sh"
    elif [ -f "$theme_dir/colors.sh" ]; then
        color_file="$theme_dir/colors.sh"
    else
        color_file=$(find "$theme_dir" -maxdepth 1 -name "*_colors.sh" -o -name "colors.sh" | head -1)
    fi

    if [ -z "$color_file" ] || [ ! -f "$color_file" ]; then
        echo ""
        return 1
    fi

    local color_map=""

    # Ordre d'affichage des couleurs principales
    local color_order=("COLOR_PRIMARY" "COLOR_INSERT" "COLOR_VISUAL" "COLOR_COMMAND" "COLOR_CURSOR_LINE" "COLOR_GIT_ADD" "COLOR_GIT_CHANGE" "COLOR_GIT_DELETE")

    # Tableau associatif pour stocker les couleurs
    declare -A colors

    # Parser toutes les couleurs
    while IFS='=' read -r key value; do
        [[ -z "$key" || "$key" =~ ^[[:space:]]*# || ! "$key" =~ export ]] && continue

        var_name=$(echo "$key" | sed 's/export //' | xargs)
        color_value=$(echo "$value" | tr -d '"' | xargs)

        # Stocker toutes les variables COLOR_*
        if [[ "$var_name" =~ ^COLOR_ ]]; then
            colors["$var_name"]="$color_value"
        fi
    done < "$color_file"

    # Afficher les couleurs dans l'ordre défini
    for color_name in "${color_order[@]}"; do
        if [[ -n "${colors[$color_name]}" ]]; then
            local color_value="${colors[$color_name]}"
            # Convertir hex en RGB
            local r=$((16#${color_value:1:2}))
            local g=$((16#${color_value:3:2}))
            local b=$((16#${color_value:5:2}))

            # Ajouter un carré coloré
            color_map="${color_map}\e[48;2;${r};${g};${b}m  \e[0m"
        fi
    done

    echo -e "$color_map"
}

# Fonction pour appliquer un thème GNOME Shell
apply_theme() {
    local theme_name="$1"
    echo "Application du thème GNOME: $theme_name"
    gsettings set org.gnome.shell.extensions.user-theme name "$theme_name"
    sleep 1
    echo "Thème appliqué avec succès!"
    sleep 1
}

# Fonction pour afficher le menu des thèmes
show_themes_menu() {
    while true; do
        # Définir le titre du sous-menu
        MENU_TITLE="===  Thèmes ==="

        # Lire dynamiquement les thèmes disponibles dans le dossier .themes
        local THEME_NAMES=()
        local THEME_DIRS=()

        # Parcourir les dossiers dans .themes
        if [ -d "$THEMES_DIR" ]; then
            while IFS= read -r theme_dir; do
                local theme_name=$(basename "$theme_dir")
                THEME_NAMES+=("$theme_name")
                THEME_DIRS+=("$theme_dir")
            done < <(find "$THEMES_DIR" -mindepth 1 -maxdepth 1 -type d | sort)
        fi

        # Ajouter des icônes aux thèmes pour le menu
        local THEMES=()
        for theme_name in "${THEME_NAMES[@]}"; do
            THEMES+=(" $theme_name")
        done

        # Ajouter l'option de retour
        THEMES+=("← Retour")

        # Appeler le menu
        menu_select "${THEMES[@]}"
        local result=$?

        # Si annulé ou retour
        if [ $result -eq 255 ]; then
            return 0
        fi

        # Vérifier si c'est l'option "Retour"
        if [ $result -eq ${#THEME_NAMES[@]} ]; then
            return 0
        fi

        # Appliquer le thème sélectionné
        if [ $result -ge 0 ] && [ $result -lt ${#THEME_NAMES[@]} ]; then
        # Sous-menu pour choisir le type d'application
        local selected_theme="${THEME_NAMES[$result]}"
        local selected_dir="${THEME_DIRS[$result]}"

        while true; do
            MENU_TITLE="===  ${selected_theme} ==="

            # Générer la ligne de couleurs
            local color_map=$(get_color_map "$selected_dir" "$selected_theme")

            local APPLY_OPTIONS=(
                "󰏘 Appliquer les couleurs"
                "󰍉 Appliquer le thème GNOME"
                "󰚰 Appliquer tout"
                "← Retour"
                "$color_map"
            )

            menu_select "${APPLY_OPTIONS[@]}"
            local apply_result=$?

            if [ $apply_result -eq 255 ] || [ $apply_result -eq 3 ]; then
                # Retour au menu des thèmes
                break
            fi

            # Ignorer si on clique sur la ligne de couleurs
            if [ $apply_result -eq 4 ]; then
                continue
            fi

            clear
            case $apply_result in
                0)
                    # Appliquer les couleurs uniquement
                    apply_color_theme "$selected_dir" "$selected_theme"
                    ;;
                1)
                    # Appliquer le thème GNOME uniquement
                    apply_theme "$selected_theme"
                    ;;
                2)
                    # Appliquer tout
                    apply_color_theme "$selected_dir" "$selected_theme"
                    apply_theme "$selected_theme"
                    ;;
            esac
        done
        fi
    done
}
