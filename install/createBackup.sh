#!/bin/bash

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


backup_keybindings_to_documents() {
    echo -e "${color4}- Sauvegarde des raccourcis clavier GNOME ${colorEnd}"

    if ! command -v dconf >/dev/null 2>&1; then
        echo -e "${colorB}- dconf non trouvé, rien à sauvegarder ${colorEnd}"
        return 1
    fi

    local dest="$HOME/Documents/custom.txt"
    local dconf_path="/org/gnome/settings-daemon/plugins/media-keys/"

    mkdir -p "$(dirname "$dest")"

    if dconf dump "$dconf_path" > "$dest"; then
        echo -e "${colorG}- Raccourcis clavier exportés dans $dest ${colorEnd}"
    else
        echo -e "${colorB}- Échec de l'export des raccourcis clavier ${colorEnd}"
        return 1
    fi
}


backup_firefox_to_documents() {
    echo -e "${color4}- Sauvegarde du profil Firefox ${colorEnd}"

    # Détecter le dossier parent du profil (snap > apt)
    local mozilla_dir profile_path profile_dir
    if [ -f "$HOME/snap/firefox/common/.mozilla/firefox/profiles.ini" ]; then
        mozilla_dir="$HOME/snap/firefox/common/.mozilla/firefox"
    elif [ -f "$HOME/.mozilla/firefox/profiles.ini" ]; then
        mozilla_dir="$HOME/.mozilla/firefox"
    else
        echo -e "${colorB}- Aucun profiles.ini trouvé, Firefox jamais lancé ? ${colorEnd}"
        return 1
    fi

    # Lire le profil par défaut (Default=1 dans profiles.ini)
    profile_path=$(awk -F= '
        /^\[/        { in_profile = ($0 ~ /^\[Profile/) }
        in_profile && /^Path=/      { p = $2 }
        in_profile && /^Default=1/  { print p; exit }
    ' "$mozilla_dir/profiles.ini")

    if [ -z "$profile_path" ]; then
        # Pas de Default=1 : prendre le premier profil
        profile_path=$(awk -F= '/^Path=/ { print $2; exit }' "$mozilla_dir/profiles.ini")
    fi

    profile_dir="$mozilla_dir/$profile_path"
    if [ ! -d "$profile_dir" ]; then
        echo -e "${colorB}- Profil $profile_dir introuvable ${colorEnd}"
        return 1
    fi

    # Refuser de tar un profil pendant que Firefox tourne (DB SQLite incohérentes)
    if pgrep -x firefox >/dev/null 2>&1; then
        echo -e "${colorB}- WARNING: Firefox est lancé. Ferme-le AVANT de sauvegarder ${colorEnd}"
        echo -e "${colorB}            (sinon onglets/cookies/historique peuvent être incohérents) ${colorEnd}"
        return 1
    fi

    local dest="$HOME/Documents/firefox-profile.tar.gz"
    mkdir -p "$(dirname "$dest")"

    echo -e "${color4}- Profil détecté : $profile_dir ${colorEnd}"
    if tar -czf "$dest" -C "$mozilla_dir" "$profile_path"; then
        echo -e "${colorG}- Profil Firefox exporté dans $dest ($(du -h "$dest" | cut -f1)) ${colorEnd}"
    else
        echo -e "${colorB}- Échec de l'export du profil Firefox ${colorEnd}"
        return 1
    fi
}


# backup_ssh_to_documents
# backup_vscode_to_dotfiles
# backup_keybindings_to_documents
backup_firefox_to_documents

echo -e "-------------${color2} ¤${colorEnd} ${color1}| Create Backup Done |${colorEnd}---"
