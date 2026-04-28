#!/bin/bash

source ~/.dotfiles/.themes/colors.sh
source ~/.dotfiles/script/checkCopy.sh
source ~/.dotfiles/script/chooseFunction.sh
source ~/.dotfiles/script/installation/extensions.sh
source ~/.dotfiles/script/installation/packages.sh
source ~/.dotfiles/script/installation/configure.sh


echo -e "------------------------------------------------------"
echo -e "------------------ ${color2} ¤${colorEnd} ${color1}| Install start |${colorEnd}---"
echo -e "------------------------------------------------------"

filesToLinkInHome=(.zshrc .themes)
filesToLinkInConfig=( yazi kitty lazygit conky btop nvim neofetch starship.toml lsd mpd rmpc bat)

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
    echo -e "${color4}- create symlink $1 ${colorEnd}"
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

installVSCodeExtensions() {
    echo -e "${color4}- install VSCode extensions ${colorEnd}"
    if ! command -v code >/dev/null 2>&1; then
        echo -e "${colorB}WARNING: code CLI not found, skipping VSCode extensions install.${colorEnd}"
        return
    fi
    local list=~/.dotfiles/vscode/extensions.txt
    if [ ! -f "$list" ]; then
        echo -e "${colorB}WARNING: $list not found, skipping.${colorEnd}"
        return
    fi
    while IFS= read -r ext; do
        [ -z "$ext" ] && continue
        code --install-extension "$ext" --force || true
    done < "$list"
    echo -e "${colorG}VSCode extensions installed.${colorEnd}"
}

importConfig() {
    local base_path="$1"
    local list_all_drive=()
    local selected_drive

    # Sélection du disque
    local drive_root="$base_path/$USER"
    if [ ! -d "$drive_root" ]; then
        echo "no external drive found"
        return
    fi
    shopt -s nullglob
    for d in "$drive_root"/*/; do
        list_all_drive+=("$(basename "$d")")
    done
    shopt -u nullglob
    if [ ${#list_all_drive[@]} -eq 0 ]; then
        echo "no external drive found"
        return
    fi
    choose_from_menu "Select drive:" selected_drive "${list_all_drive[@]}"
    echo -e "${color4}- Sauvegarde des dossiers personnels ${colorEnd}"

    DEST_DIR="$base_path/$USER/${selected_drive}/$USER"


    cpKeybinding() {
      echo -e "${color4}- Copying custom keybindings to keybindings/custom.txt ${colorEnd}"
      if [ -f "$DEST_DIR/config/keybindings/custom.txt" ]; then
          if dconf load /org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/ < "$DEST_DIR/config/keybindings/custom.txt"; then
              echo -e "${colorG}- Custom keybindings copied ${colorEnd}"
          fi
      else
          echo -e "${color4}- No custom keybindings file found, skipping ${colorEnd}"
      fi
    }


    cpAutostart() {
      echo -e "${color4}- Copying autostart ${colorEnd}"
      mkdir -p ~/.config/autostart
      if [ -d "$DEST_DIR/config/autostart" ]; then
          if rsync -av --ignore-existing "$DEST_DIR/config/autostart/" ~/.config/autostart/; then
              echo -e "${colorG}- Autostart copied ${colorEnd}"
          fi
      else
          echo -e "${color4}- No autostart folder found on media, skipping ${colorEnd}"
      fi
    }

    cpFirefoxBookmarks() {
        local latest_backup
        latest_backup=$(ls -t "$DEST_DIR/config/firefox/bookmarks"-*.json 2>/dev/null | head -n 1)
        if [ -n "$latest_backup" ] && [ -f "$latest_backup" ]; then
            echo -e "${color4}- Copying Firefox bookmarks file from media to Documents ${colorEnd}"
            mkdir -p "$HOME/Documents"
            cp "$latest_backup" "$HOME/Documents/"
            echo -e "${colorG}- Firefox bookmarks copied ${colorEnd}"
        else
            echo -e "${color4}- No Firefox bookmarks file found on media, doing nothing ${colorEnd}"
        fi
    }

    cpWallpaper() {
        if [ -f "$DEST_DIR/Images/wallpapers/1.jpg" ]; then
            echo -e "${color4}- Copying wallpaper ${colorEnd}"
            mkdir -p "$HOME/Images/wallpapers"
            rsync -av --ignore-existing "$DEST_DIR/Images/wallpapers/1.jpg" "$HOME/Images/wallpapers/1.jpg"
            echo -e "${colorG}- Wallpaper copied ${colorEnd}"
        else
            echo -e "${color4}- No wallpaper found on media, doing nothing ${colorEnd}"
        fi
    }

    cpKeybinding
    cpAutostart
    cpFirefoxBookmarks
    cpWallpaper
    echo -e "------------------${color2} ¤${colorEnd} ${color3}  Import config done ${colorEnd}---"
}



gitinit() {
    setGitConfig() {
        echo "Enter your git name"
        read -r gitName
        git config --global user.name "$gitName"
        echo "Enter your git email"
        read -r gitEmail
        git config --global user.email "$gitEmail"
        git config --list --global
    }

    echo -e "${color4}- git ${colorEnd}"
    local gitNamee
    gitNamee=$(git config --global user.name)
    if [ -z "$gitNamee" ]; then
        selections=( "Yes" "No" )
        choose_from_menu "Do you want to set your git name and email? " selected_choice "${selections[@]}"
        case $selected_choice in
            Yes ) setGitConfig;;
            No ) ;;
        esac
    else
      echo -e "Your git name is ${color3}${gitNamee}${colorEnd}"
    fi


    echo -e "${color4}- github ${colorEnd}"
    if ! command -v gh >/dev/null 2>&1; then
        echo -e "${colorB}WARNING: gh not installed, skipping github auth.${colorEnd}"
        return
    fi
    if gh auth status >/dev/null 2>&1; then
        gh auth status
    else
        selections=( "No" "Yes" )
        choose_from_menu "Do you want to connect to your github? " selected_choice "${selections[@]}"
        case $selected_choice in
            Yes ) gh auth login;;
            No ) ;;
        esac
    fi
}

askForCopy() {
    echo -e "${color4}- copy ${colorEnd}"
    selections=( "No" "Yes" )
    choose_from_menu "Do you want to import your configuration from media? " selected_choice "${selections[@]}"
    case $selected_choice in
        Yes ) importConfig "$1";;
        No ) return;;
    esac
}
askForReboot() {
    echo -e "${color4}- reboot ${colorEnd}"
    selections=( "No" "Yes" )
    choose_from_menu "Do you want to reboot? " selected_choice "${selections[@]}"
    case $selected_choice in
        Yes ) sudo reboot;;
        No ) return;;
    esac
}


askForCopy "/media"
installPackages
installExtensions
setGnomeConfig
createAllSymlink
installVSCodeExtensions
gitinit
askForReboot

echo -e "------------------ ${color2} ¤${colorEnd} ${color1}| Installation done |${colorEnd}---"
