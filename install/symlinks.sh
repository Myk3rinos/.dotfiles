#!/bin/bash

source ~/.dotfiles/script/colors.sh

# ---------------------------------------------------------------------------
# Listes des fichiers à symlinker
# ---------------------------------------------------------------------------

filesToLinkInHome=(.zshrc .themes)
filesToLinkInConfig=(yazi kitty lazygit conky btop nvim neofetch starship.toml lsd mpd rmpc bat)

# ---------------------------------------------------------------------------
# Fonctions
# ---------------------------------------------------------------------------

createSymlinks() {
    local src="/home/$USER/.dotfiles/$1"
    local dest="$HOME/$2$1"
    if [ -e "$src" ]; then
       mkdir -p "$(dirname "$dest")"
       rm -rf "$dest"
       ln -sfn "$src" "$dest"
       echo -e "${colorG}$1 configuration linked.${colorEnd}"
    else
       echo -e "${colorB}WARNING: no $1 config found; can't link for now.${colorEnd}"
    fi
}

createAllSymlink() {
    echo -e "${color4}- create symlinks ${colorEnd}"
    for file in "${filesToLinkInHome[@]}"; do
       createSymlinks "$file" ""
    done
    for file in "${filesToLinkInConfig[@]}"; do
       createSymlinks "$file" ".config/"
    done

    # symlink Windsurf config
    if [ -f ~/.dotfiles/windsurf/settings.json ]; then
        mkdir -p ~/.config/Windsurf/User
        rm -rf ~/.config/Windsurf/User/settings.json
        ln -sfn ~/.dotfiles/windsurf/settings.json ~/.config/Windsurf/User/settings.json
        echo -e "${colorG}Windsurf settings linked.${colorEnd}"
    fi

    # symlink VSCode config
    if [ -f ~/.dotfiles/vscode/settings.json ]; then
        mkdir -p ~/.config/Code/User
        rm -rf ~/.config/Code/User/settings.json
        ln -sfn ~/.dotfiles/vscode/settings.json ~/.config/Code/User/settings.json
        echo -e "${colorG}VSCode settings linked.${colorEnd}"
    fi
}
