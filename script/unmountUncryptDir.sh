#!/usr/bin/env bash
source ~/.dotfiles/script/colors.sh
source ~/.dotfiles/script/chooseFunction.sh

unmountSecret () {
    echo -e "-----------------${color2} ¤${colorEnd} ${color1}| Unmounting encrypted drives |${colorEnd}---"
    pushd /tmp/mnt > /dev/null
    if [[ $(ls -A /tmp/mnt) ]]; then
        if [ -e /tmp/mnt/* ]; then
            list_all_drive+=($(ls -d *))
        fi
        if [ -e /tmp/mnt/.* ]; then
            list_all_drive+=($(ls -d .*))
        fi
        choose_from_menu "Select directory to unmount:" selected_directory "${list_all_drive[@]}"
        if [ -e /tmp/mnt/"$selected_directory" ]; then
            fusermount -u /tmp/mnt/"$selected_directory"
            rm -d /tmp/mnt/"$selected_directory"
            echo -e "${colorG}- Unmount done${colorEnd}"
          else
            echo -e "${colorB}- No Directory to unmount${colorEnd}"
        fi
    else
        echo -e "${colorB} No uncrypted directory found${colorEnd}" ; exit 
    fi
    popd > /dev/null
}
unmountSecret
