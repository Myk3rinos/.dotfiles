#!/usr/bin/env bash
source ~/.dotfiles/script/colors.sh
source ~/.dotfiles/script/chooseFunction.sh


createSecret () {
  echo -e "-----------------${color2} ¤${colorEnd} ${color1}| Create encrypted directory |${colorEnd}---"
  printf "%s" "Enter directory name: "
  read dirname
  echo -e "${color2}- Creating directory: $1 ${colorEnd} $dirname"
  mkdir "${dirname}"
  gocryptfs -init $dirname
}

createSecret
