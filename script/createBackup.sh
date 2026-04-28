#!/usr/bin/env bash

source ~/.dotfiles/script/colors.sh


echo -e "-------------${color2} ¤${colorEnd} ${color1}| Create Backup Start |${colorEnd}---"


backup_ssh_to_documents() {
    echo -e "${color4}- Sauvegarde des clés SSH ${colorEnd}"

    local src="$HOME/.ssh"
    local dest="$HOME/Documents/ssh"

    if [ ! -d "$src" ]; then
        echo -e "${colorB}- Aucun dossier ~/.ssh trouvé, rien à sauvegarder ${colorEnd}"
        return 1
    fi

    mkdir -p "$dest"
    chmod 700 "$dest"

    if rsync -a "$src/" "$dest/"; then
        echo -e "${colorG}- Clés SSH copiées dans $dest ${colorEnd}"
    else
        echo -e "${colorB}- Échec de la copie des clés SSH ${colorEnd}"
        return 1
    fi
}


backup_ssh_to_documents

echo -e "-------------${color2} ¤${colorEnd} ${color1}| Create Backup Done |${colorEnd}---"
