#!/usr/bin/env bash

source ~/.dotfiles/script/colors.sh
source ~/.dotfiles/script/choiseFunction.sh

mountDrive () {
    echo -e " -------------------${color2} ¤${colorEnd} ${color1}| Mounting Drive |${colorEnd}---"
    if [[ $(lsblk -d ) ]]; then
        list_all_drive+=($(lsblk -o NAME | grep -E '^└─' | cut -c7-))
        choose_from_menu "Select selected_drive:" selected_drive "${list_all_drive[@]}"
    else
        echo "no selected_drive found" ; exit 
    fi

    sudo cryptsetup luksOpen /dev/"${selected_drive}" "${selected_drive}"
    sudo mkdir -p /run/media/"$USER"/"${selected_drive}"
    sudo mount /dev/mapper/"${selected_drive}" /run/media/"$USER"/"${selected_drive}"
}

mountDrive
