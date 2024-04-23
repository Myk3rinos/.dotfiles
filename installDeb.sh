#!/bin/bash
installDebian() {
    echo "--------------- install packages ----------------" 
	sudo apt install -y neovim
	sudo apt install -y nala
	sudo add-apt-repository ppa:touchegg/stable
	sudo nala install -y gnupg curl git-all touchegg gnome-shell-extension-manager gnome-tweaks gnome-shell-extensions neovim kitty cargo gocryptfs zsh ffmpegthumbnailer fzf jq zoxide ripgrep bat conky gh btop htop wl-clipboard unar gparted foremost testdisk nodejs npm rhythmbox lm-sensors
	
	sudo nala update
	sudo nala upgrade
	sudo apt update
	sudo apt upgrade

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


installFont() {
    echo "--------------- install Fonts ----------------" 
    # NerdFonts
    # pushd /home/will/Téléchargemenets/
    pushd ~/.local/share/fonts
    wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/CascadiaCode.zip
    unzip CascadiaCode.zip
    fc-cache -fv
    rm CascadiaCode.zip
    popd

    # GoogleFonts
    sudo mkdir -p /usr/share/fonts/googlefonts
    pushd /usr/share/fonts/googlefonts
    wget https://font.download/dl/font/raleway-5.zip
    sudo unzip -d . raleway-5.zip
    sudo fc-cache -fv
    rm raleway-5.zip
    popd
}

installMongodb() {
    echo "---------------- install mongodb--------------- "
    curl -fsSL https://www.mongodb.org/static/pgp/server-7.0.asc | \
   sudo gpg -o /usr/share/keyrings/mongodb-server-7.0.gpg \
   --dearmor
    echo "deb [ arch=amd64,arm64 signed-by=/usr/share/keyrings/mongodb-server-7.0.gpg ] https://repo.mongodb.org/apt/ubuntu jammy/mongodb-org/7.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-7.0.list
    sudo apt update
    sudo apt upgrade
    sudo apt-get install -y mongodb-org
    sudo systemctl enable --now mongod
}
installDeb() {
    installDebian
    installFont
    installMongodb
}



