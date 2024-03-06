source $HOME/.dotfiles/script/gocrypt.sh
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

# if [ -e $HOME/.logon_script_done ]
# then
#  # echo "No actions to do"
# else
#  xdotool set_desktop 1
#  v
# fi
# ----------------- First run of the script. Performing some actions -----------------
if [ -e $HOME/.logon_script_done ]
then
 # echo "No actions to do"
else
 # echo "First run of the script. Performing some actions" >> $HOME/run-once.txt
 xdotool set_desktop 1
 touch $HOME/.logon_script_done
fi

# ----------------- Shutdown and reboot -----------------
function rb() {
 if [ -e $HOME/.logon_script_done ]
  then
    rm $HOME/.logon_script_done
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
    shutdown -h now
   echo "Remove logon script done. Shutting down"
  else
    shutdown -h now
  fi
}

# ----------------- Mounting and unmounting encrypted drives -----------------
function ms() {
  mountSecret "$1"
  # echo " ----------------- Mounting encrypted drives -----------------"
  # if [ -z "$1" ]
  # then
  #   echo "Argument directory missing"
  # else
  #   if [ -e tmp/"$1" ]
  #     then
  #       fusermount -u /tmp/"$1"
  #       rm -d /tmp/"$1"
  #       mkdir /tmp/"$1"
  #       gocryptfs "$(pwd)/$1" /tmp/"$1"
  #       echo "Remove and create mnt done"
  #     else
  #       mkdir /tmp/"$1"
  #       gocryptfs "$(pwd)/$1" /tmp/"$1"
  #       echo "-- Mount done --"
  #       cd /tmp/"$1"
  #   fi
  # fi
}
function us() {
  unmountSecret "$1"
  # echo " ----------------- Unmounting encrypted drives -----------------"
  # if [ -z "$1" ]
  # then
  #   echo "Argument directory missing"
  # else
  #   if [ -e /tmp/"$1" ]
  #     then
  #       fusermount -u /tmp/"$1"
  #       rm -d /tmp/"$1"
  #       echo " -- Unmount done --"
  #     else
  #       echo "No Directory to unmount"
  #   fi
  # fi
}

function cs() {
  createSecret "$1"
  # echo " ----------------- Create encrypted drives -----------------"
  # if [ -z "$1" ]
  # then
  #   echo "Argument directory missing"
  # else
  #   gocryptfs -init "$(pwd)/$1"
  # fi
}
