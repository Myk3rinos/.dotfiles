#!/bin/bash

source ~/.dotfiles/script/colors.sh
source ~/.dotfiles/script/chooseFunction.sh
source ~/.dotfiles/install/packages.sh
source ~/.dotfiles/install/symlinks.sh
source ~/.dotfiles/install/extensions.sh
source ~/.dotfiles/install/configure.sh

echo -e "------------------------------------------------------"
echo -e "------------------ ${color2} ¤${colorEnd} ${color1}| Install start |${colorEnd}---"
echo -e "------------------------------------------------------"

# 1. Installer tous les paquets (apt + dépôts externes + binaires GitHub)
installPackages

# 2. Créer les symlinks vers les dotfiles (~/.zshrc, ~/.config/*, etc.)
createAllSymlink

# 3. Installer les extensions VSCode depuis vscode/extensions.txt
installVSCodeExtensions

# 4. Installer les extensions GNOME (depuis EGO + git pour Vitals/Clipboard)
#    DOIT être avant setGnomeConfig qui les active via `enabled-extensions`
installExtensions

# 5. Appliquer les préférences GNOME (thème, dock, extensions, firewall...)
setGnomeConfig

# 6. Restaurer les raccourcis clavier custom depuis ~/Documents/custom.txt
cpKeybinding

# 7. Restaurer le profil Firefox depuis ~/Documents/firefox-profile.tar.gz
cpFirefoxProfile

# 8. Restaurer les clés SSH depuis ~/Documents/ssh
cpSsh

# 9. Configurer git (nom/email) + login GitHub via gh CLI (interactif)
gitinit

echo -e "------------------ ${color2} ¤${colorEnd} ${color1}| Installation done |${colorEnd}---"

# 10. Demander si on redémarre maintenant (interactif)
askForReboot
