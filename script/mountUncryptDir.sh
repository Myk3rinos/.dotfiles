#!/usr/bin/env bash
source ~/.dotfiles/script/colors.sh
source ~/.dotfiles/script/chooseFunction.sh

mountSecret () {
    echo -e "-----------------${color2} ¤${colorEnd} ${color1}| Mounting encrypted drives |${colorEnd}---"
    runMountSecret () {
        echo -e "${color2}- Mounting directory: $1 ${colorEnd}"
        if [ -e "$1"/gocryptfs.diriv ] ; then

            if [ -e tmp/mnt/"$1" ]
              then
                fusermount -u /tmp/mnt/"$1"
                rm -d /tmp/mnt/"$1"
                mkdir -p /tmp/mnt/"$1"
                gocryptfs $1 /tmp/mnt/"$1"
                echo -e "${color2}- Remove and create mounting done${colorEnd}"
                cd /tmp/mnt/"$1"
              else
                mkdir -p /tmp/mnt/"$1"
                gocryptfs $1 /tmp/mnt/"$1"
                echo -e "${color2}- Mounting done ${colorEnd}"
                cd /tmp/mnt/"$1"
            fi
        else
            echo -e "${colorB} This directory is not encrypted ${colorEnd}"
        fi
    }

    if [[ $(ls -A) ]]; then
        filesH=( .* )
        filesH=( * )
        if [ -e $files ]; then
           list_all_drive+=($(ls -d *))
        fi
        if [ -e $filesH ]; then
           list_all_drive+=($(ls -d .*))
        fi
        choose_from_menu "Select uncrypted directory to mount:" selected_drive "${list_all_drive[@]}"
        runMountSecret $selected_drive
    else
        echo "No directory found" ; exit 
    fi
}
mountSecret
