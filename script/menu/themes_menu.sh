#!/bin/bash

# Obtenir le répertoire du script
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Importer la bibliothèque de menu
source "$SCRIPT_DIR/menu_lib.sh"

# Chemin vers le dossier des thèmes
THEMES_DIR="/home/will/.dotfiles/.themes"

# Fonction pour appliquer un thème
apply_theme() {
    local theme_name="$1"
    echo "Application du thème: $theme_name"
    gsettings set org.gnome.shell.extensions.user-theme name "$theme_name"
    sleep 1
    echo "Thème appliqué avec succès!"
    sleep 1
}

# Fonction pour afficher le menu des thèmes
show_themes_menu() {
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
        clear
        apply_theme "${THEME_NAMES[$result]}"
    fi
}
