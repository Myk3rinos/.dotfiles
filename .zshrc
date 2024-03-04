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

# echo "Welcome to the terminal"
# xdotool set_desktop 1
