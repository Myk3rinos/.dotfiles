#!/usr/bin/env bash

source ~/.dotfiles/script/colors.sh
source ~/.dotfiles/script/checkCopy.sh
source ~/.dotfiles/script/chooseFunction.sh


echo -e "-------------${color2} ¤${colorEnd} ${color1}| Update Start |${colorEnd}---"



backup_to_media() {
    
    local base_path="$1"
    local list_all_drive=()
    local selected_drive

    # Sélection du disque
    pushd "$base_path"/$USER/ > /dev/null
    if [[ $(ls -A) ]]; then
        list_all_drive+=($(ls -d *))
    else
        echo "no external drive found" ; return
    fi
    popd > /dev/null
    choose_from_menu "Select drive:" selected_drive "${list_all_drive[@]}"
    echo -e "${color4}- Sauvegarde des dossiers personnels ${colorEnd}"
    

    mkdir -p "$base_path/$USER/${selected_drive}/$USER"
    
    DEST_DIR="$base_path/$USER/${selected_drive}/$USER"
    # Vérifier si le disque de destination existe
    if [ ! -d "$DEST_DIR" ]; then
        echo "Erreur : Le disque de destination n'existe pas à l'emplacement $DEST_DIR"
        echo "Veuillez brancher le disque et réessayer."
        return 1
    fi



    cpKeybinding() {
      echo -e "${color4}- Copying custom keybindings to keybindings/custom.txt ${colorEnd}"
      mkdir -p "$DEST_DIR/config/keybindings"
      # rsync -av --ignore-existing ~/.config/dconf/user /org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/ "$DEST_DIR/config/keybindings/"
      dconf dump /org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/ > "/home/$USER/Documents/custom.txt"
      dconf dump /org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/ > "$DEST_DIR/config/keybindings/custom.txt"
    }


    cpAutostart() {
      echo -e "${color4}- Copying autostart ${colorEnd}"
      mkdir -p "$DEST_DIR/config/autostart"
      rsync -av --ignore-existing ~/.config/autostart/ "$DEST_DIR/config/autostart/"
    }

    cpFirefoxBookmarks() {
        firefoxBookmarkFile="bookmarks-$(date +%Y-%m-%d).json"
        if [ -f "$HOME/Documents/$firefoxBookmarkFile" ]; then
            echo -e "${color4}- Firefox bookmarks file found, copying it ${colorEnd}"
            rsync -av --ignore-existing "$HOME/Documents/$firefoxBookmarkFile" "$DEST_DIR/config/firefox/"
            echo -e "${colorG}- Firefox bookmarks copied ${colorEnd}"
        else
            echo -e "${color4}- Firefox bookmarks file not found, opening Firefox to create it ${colorEnd}"
            firefox &
            while [ ! -f "$HOME/Documents/$firefoxBookmarkFile" ]; do
                sleep 1
            done
            rsync -av --ignore-existing "$HOME/Documents/$firefoxBookmarkFile" "$DEST_DIR/config/firefox/"
            echo -e "${colorG}- Firefox bookmarks copied ${colorEnd}"
        fi
    }

    cpDotfiles() {
        echo -e "${color4}- Copying dotfiles ${colorEnd}"
        # Supprimer le dossier .dotfiles s'il existe déjà
        rm -rf "$DEST_DIR/.dotfiles"
        # Copier le dossier .dotfiles
        sudo rsync -av ~/.dotfiles/ "$DEST_DIR/.dotfiles/"
    }

    cpDocument() {
        SOURCE_DIRS=("$HOME/Documents" "$HOME/Images" "$HOME/Musique" "$HOME/Vidéos")

        for dir in "${SOURCE_DIRS[@]}"; do
            if [ -d "$dir" ]; then
                echo -e "${color4}- Copie de $(basename "$dir")...${colorEnd}"
                # Créer le dossier de destination s'il n'existe pas
                mkdir -p "$DEST_DIR/$(basename "$dir")"
                # Utiliser rsync pour copier les fichiers sans écraser ceux qui existent déjà
                sudo rsync -av --ignore-existing "$dir/" "$DEST_DIR/$(basename "$dir")/"
            else
                echo "Le dossier $(basename "$dir") n'existe pas, il est ignoré."
            fi
        done
    }
    cpKeybinding
    cpAutostart
    cpFirefoxBookmarks
    cpDotfiles
    cpDocument

    echo -e "${colorG}- Sauvegarde terminée. ${colorEnd}"
}


backup_to_media "/media"

echo -e "-------------${color2} ¤${colorEnd} ${color1}| Update Done |${colorEnd}---"



