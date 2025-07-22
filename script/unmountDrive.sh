#!/usr/bin/env bash

source ~/.dotfiles/script/colors.sh
source ~/.dotfiles/script/chooseFunction.sh

unmountDrive () {
    echo -e " -------------------${color2} ¤${colorEnd} ${color1}| Unmounting Drive |${colorEnd}---"
    if [[ $(lsblk -d ) ]]; then
        list_all_drive+=($(lsblk -o NAME | grep -E '^└─' | cut -c7-))
        choose_from_menu "Select drive to unmount:" selected_drive "${list_all_drive[@]}"
    else
        echo "no drive found" ; exit 
    fi

    # sudo umount /run/media/"$USER"/"${selected_drive}"
    sudo umount /media/"$USER"/"${selected_drive}"
    sudo cryptsetup luksClose "${selected_drive}"
}

unmountDrive
