#!/bin/bash

source ~/.dotfiles/script/colors.sh
source ~/.dotfiles/script/checkCopy.sh
source ~/.dotfiles/script/chooseFunction.sh
source ~/.dotfiles/script/installation/extensions.sh
source ~/.dotfiles/script/installation/packages.sh
source ~/.dotfiles/script/installation/configure.sh


echo -e "------------------------------------------------------"
echo -e "------------------ ${color2} ¤${colorEnd} ${color1}| Install start |${colorEnd}---"
echo -e "------------------------------------------------------"

filesToLinkInHome=(.zshrc .themes)
filesToLinkInConfig=( yazi kitty lazygit conky btop nvim neofetch starship.toml lsd)

createSymlinks() {
    if [ -f /home/$USER/.dotfiles/$1 ] || [ -r /home/$USER/.dotfiles/$1 ]; then # check if file exists
       rm -r ~/"$2""$1"
       ln -s /home/$USER/.dotfiles/$1 ~/"$2""$1"
       echo -e "${colorG}$1 configuration linked.${colorEnd}"
    else
       echo -e "${colorB}WARNING: no $1 config found; can't link for now.${colorEnd}"
    fi
}

createAllSymlink() {
    echo -e "${color4}- create symlink $1 ${colorEnd}"
    for file in "${filesToLinkInHome[@]}"; do
       createSymlinks $file ""
    done
    for file in "${filesToLinkInConfig[@]}"; do
       createSymlinks $file ".config/"
    done
    
    # symlink Windsurf config
    rm -rf ~/.config/Windsurf/User/settings.json
    ln -s ~/.dotfiles/windsurf/settings.json ~/.config/Windsurf/User/settings.json
}

importConfig() {
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

    DEST_DIR="$base_path/$USER/${selected_drive}/$USER"


    cpKeybinding() {
      echo -e "${color4}- Copying custom keybindings to keybindings/custom.txt ${colorEnd}"
      cat "$DEST_DIR/config/keybindings/custom.txt" | dconf load /org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/
      if [ $? -eq 0 ]; then
          echo -e "${colorG}- Custom keybindings copied ${colorEnd}"
      fi
    }


    cpAutostart() {
      echo -e "${color4}- Copying autostart ${colorEnd}"
      mkdir -p "$DEST_DIR/config/autostart"
    #   rsync -av --ignore-existing ~/.config/autostart/ "$DEST_DIR/config/autostart/"
     rsync -av --ignore-existing "$DEST_DIR/config/autostart/" ~/.config/autostart/
     if [ $? -eq 0 ]; then
         echo -e "${colorG}- Autostart copied ${colorEnd}"
     fi
    }

    cpFirefoxBookmarks() {
        latest_backup=$(ls -t "$DEST_DIR/config/firefox/bookmarks"-*.json | head -n 1)
        if [ -f "$latest_backup" ]; then
            echo -e "${color4}- Copying Firefox bookmarks file from media to Documents ${colorEnd}"
            cp "$latest_backup" "$HOME/Documents/"
            echo -e "${colorG}- Firefox bookmarks copied ${colorEnd}"
        else
            echo -e "${color4}- No Firefox bookmarks file found on media, doing nothing ${colorEnd}"
        fi
    }
    cpWallpaper() {
        if [ -f "$DEST_DIR/Images/wallpapers/1.jpg" ]; then
            echo -e "${color4}- Copying wallpaper ${colorEnd}"
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
        read gitName
        git config --global user.name "$gitName"
        echo "Enter your git email"
        read gitEmail
        git config --global user.email "$gitEmail"
        git config --list --global
    }

    echo -e "${color4}- git ${colorEnd}"
    gitNamee=$(git config --global user.name)
    if [[ "$gitNamee" = "" ]]; then
        selections=( "Yes" "No" )
        choose_from_menu "Do you want to set your git name and email? " selected_choice "${selections[@]}"
        case $selected_choice in
            Yes ) setGitConfig; break;;
            No ) break;; #exit;;
        esac
    else
      echo -e "Your git name is ${color3}${gitNamee}${colorEnd}" 
    fi


    echo -e "${color4}- github ${colorEnd}"
    githubName=$(gh auth status)
    if [[ "$githubName" = "" ]]; then
        selections=( "No" "Yes" )
        choose_from_menu "Do you want to connect to your github? " selected_choice "${selections[@]}"
        case $selected_choice in
            Yes ) gh auth login; break;;
            No ) break;; #exit;;
        esac
    else
      gh auth status
    fi
}

askForCopy() {
    echo -e "${color4}- copy ${colorEnd}"
    selections=( "No" "Yes" )
    choose_from_menu "Do you want to import your configuration from media? " selected_choice "${selections[@]}"
    case $selected_choice in
        Yes ) importConfig $1;;
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
gitinit
askForReboot

echo -e "------------------ ${color2} ¤${colorEnd} ${color1}| Installation done |${colorEnd}---"
