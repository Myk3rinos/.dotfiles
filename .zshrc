source $HOME/.dotfiles/script/gocrypt.sh
source $HOME/.dotfiles/script/mountDrive.sh

# ------- Man color -------
# function man() {
#   /usr/bin/man $* | \
#     col -b | \
#     vim -R -c 'set ft=man nomod nolist' -
# }
# export LESS_TERMCAP_mb=$'\e[1;32m'
# function man() {
#    LESS_TERMCAP_mb=$'\e[1;32m'
#    LESS_TERMCAP_md=$'\e[1;32m' \
#    LESS_TERMCAP_me=$'\e[0m' \
#    LESS_TERMCAP_se=$'\e[0m' \
#    LESS_TERMCAP_so=$'\e[01;33m' \
#    LESS_TERMCAP_ue=$'\e[0m' \
#    LESS_TERMCAP_us=$'\e[1;4;31m' \
#    command man "$@"
# }
## git aliases
alias gi="git init ."
alias ga="git add ."
alias gc="git commit -m 'Initial Commit'"

alias gp="git push"
alias gpl="git pull"
alias gclone="git clone"

alias gstatus="git status"
alias glog="git log"
alias gdiff="git diff"
alias gcheckout="git checkout"
alias gbranch="git branch"
alias gmerge="git merge"


alias v="clear ; nvim"
alias bt="clear ; btop"
alias n="clear ; neofetch"
alias c="clear"

alias ".."="clear ; cd .. "
alias ls="clear ; lsd"
alias lsa="clear ; lsd -a"
alias lsl="clear ; lsd -l"
alias lsla="clear ; lsd -la"
alias lst="clear ; ls --tree ."



alias nixrs="sudo nixos-rebuild switch"

export STARSHIP_CONFIG=~/.config/starship.toml

# yazi
function y() {
  clear
	local tmp="$(mktemp -t "yazi-cwd.XXXXX")"
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

function cd() {
  clear
  builtin cd "$@" #&& ls
}
function cdh() {
  clear
  builtin cd ~ "$@" #&& ls
}
# echo "Welcome to the terminal"

# if [ -e $HOME/.logon_script_done_v ]
# then
#  # echo "No actions to do"
# else
#  touch $HOME/.logon_script_done_v
#  # xdotool set_desktop 1
#  v
# fi
# ----------------- First run of the script. Performing some actions -----------------
if [ -e $HOME/.logon_script_done ]
then
 # echo "No actions to do"
else
  # v
 # echo "First run of the script. Performing some actions" >> $HOME/run-once.txt
 touch $HOME/.logon_script_done
 # v
 xdotool set_desktop 1
 # firefox
fi

# ----------------- Shutdown and reboot -----------------
function rb() {
 if [ -e $HOME/.logon_script_done ]
  then
    rm $HOME/.logon_script_done
    # rm $HOME/.logon_script_done_v
    shutdown -r now
   echo "Remove logon script done. Shutting down"
  else
    shutdown -r now
  fi
}
function sd() {
 if [ -e $HOME/.logon_script_done ]
  then
    rm $HOME/.logon_script_done
    # rm $HOME/.logon_script_done_v
    shutdown -h now
   echo "Remove logon script done. Shutting down"
  else
    shutdown -h now
  fi
}

# ----------------- Mounting and unmounting encrypted drives -----------------
function ms() {
  mountSecret "$1"
}
function us() {
  unmountSecret "$1"
}
function cs() {
  createSecret "$1"
}

# ----------------- Mounting and unmounting drives -----------------
function md() {
  mountDrive
}
function ud() {
  unmountDrive
}
