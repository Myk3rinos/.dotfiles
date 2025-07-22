#!/bin/bash

# Source de la fonction choose_from_menu
source ~/.dotfiles/script/chooseFunction.sh

# Chemin vers le dossier des thèmes
THEMES_DIR="/home/will/.dotfiles/.themes"

# Vérifier si le dossier des thèmes existe
if [ ! -d "$THEMES_DIR" ]; then
  echo "Erreur : Le dossier des thèmes n'a pas été trouvé à l'emplacement $THEMES_DIR"
  exit 1
fi

# Créer une liste des thèmes disponibles
themes=("$THEMES_DIR"/*)

# Extraire uniquement les noms de fichiers pour l'affichage
theme_names=()
for theme_path in "${themes[@]}"; do
  theme_names+=("$(basename "$theme_path")")
done

# Utiliser choose_from_menu pour la sélection
choose_from_menu "Veuillez choisir un thème :" selected_theme "${theme_names[@]}"

# Vérifier si l'utilisateur a choisi "exit" (géré automatiquement par choose_from_menu)
# Si on arrive ici, c'est qu'un thème a été sélectionné
echo "Vous avez choisi le thème : $selected_theme"
gsettings set org.gnome.shell.extensions.user-theme name "$selected_theme"
echo "Thème '$selected_theme' appliqué avec succès !"
