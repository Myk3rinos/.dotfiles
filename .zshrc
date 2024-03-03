## git aliases
alias ginit="git init ."
alias gadd="git add ."
alias gc="git commit -m 'Initial Commit'"

alias gpush="git push"
alias gpull="git pull"
alias gclone="git clone"

alias gstatus="git status"
alias glog="git log"
alias gdiff="git diff"
alias gcheckout="git checkout"
alias gbranch="git branch"
alias gmerge="git merge"


alias v="nvim"
# alias y="yazi"
alias n="neofetch"
alias c="clear"

alias ".."="cd .."
alias ls="lsd"
alias "ls -a"="lsd -a"
alias "ls -l"="lsd -l"
alias "ls -la"="lsd -la"




alias nixrs="sudo nixos-rebuild switch"

export STARSHIP_CONFIG=~/.config/starship.toml

# alias n="neofetch --ascii .config/neofetch/asciiNix.txt"

function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXX")"
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}
