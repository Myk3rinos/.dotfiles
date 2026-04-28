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


backup_vscode_to_dotfiles() {
    echo -e "${color4}- Sauvegarde de la config VSCode ${colorEnd}"

    if ! command -v code >/dev/null 2>&1; then
        echo -e "${colorB}- code CLI non trouvé, rien à sauvegarder ${colorEnd}"
        return 1
    fi

    local dotfiles_dir="$HOME/.dotfiles/vscode"
    mkdir -p "$dotfiles_dir"

    # settings.json — copié uniquement si la cible n'est pas déjà un symlink
    local settings_src="$HOME/.config/Code/User/settings.json"
    local settings_dest="$dotfiles_dir/settings.json"
    if [ -f "$settings_src" ]; then
        if [ -L "$settings_dest" ]; then
            echo -e "${color4}- settings.json déjà en symlink, copie sautée ${colorEnd}"
        else
            cp -p "$settings_src" "$settings_dest"
            echo -e "${colorG}- settings.json copié dans $settings_dest ${colorEnd}"
        fi
    else
        echo -e "${colorB}- Aucun settings.json trouvé dans ~/.config/Code/User/ ${colorEnd}"
    fi

    # liste des extensions
    if code --list-extensions > "$dotfiles_dir/extensions.txt"; then
        echo -e "${colorG}- Extensions exportées dans $dotfiles_dir/extensions.txt ${colorEnd}"
    else
        echo -e "${colorB}- Échec de l'export des extensions VSCode ${colorEnd}"
        return 1
    fi
}


backup_ssh_to_documents
backup_vscode_to_dotfiles

echo -e "-------------${color2} ¤${colorEnd} ${color1}| Create Backup Done |${colorEnd}---"
