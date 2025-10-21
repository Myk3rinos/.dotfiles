#!/bin/bash
# Script pour générer alpha.ron à partir du template en utilisant les couleurs de colors.sh

# Source le fichier colors.sh pour obtenir les variables
source "$(dirname "$0")/../.themes/colors.sh"

# Utiliser envsubst pour remplacer les variables dans le template
envsubst < "$(dirname "$0")/alpha.ron.template" > "$(dirname "$0")/alpha.ron"

echo "Configuration rmpc générée avec succès dans alpha.ron"
