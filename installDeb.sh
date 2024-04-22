#!/bin/bash
installDeb() {
	sudo apt install -y nala
	sudo add-apt-repository ppa:touchegg/stable
	sudo nala install -y gnupg curl git-all touchegg gnome-shell-extension-manager gnome-tweaks gnome-shell-extensions neovim kitty cargo gocryptfs zsh ffmpegthumbnailer fzf jq zoxide ripgrep bat conky gh btop htop wl-clipboard unar gparted foremost testdisk nodejs npm rhythmbox
	
	sudo nala update
	sudo nala upgrade

	sudo snap install discord
	sudo npm install -g pnpm
	cargo install lsd
	#rust
	curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
	rustup update
	#yazi
	cargo install --locked yazi-fm
	#starship
	curl -sS https://starship.rs/install.sh | sh

	#cd /tmp
	#wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
	#sudo dpkg -i google-chrome-stable_current_amd64.deb

    chsh -s $(which zsh)
}

gnomeExtensions() {

	gnome-extensions install --force gnome-shell-extension-x11gestures-master.zip
	pkill -TERM gnome-shell
	gnome-extensions enable x11gestures@joseexposito.github.io

}

# #gnomeExtensions
# installDeb


