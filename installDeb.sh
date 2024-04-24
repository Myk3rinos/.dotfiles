#!/bin/bash
source ~/.dotfiles/script/colors.sh
echo -e "------------------ ${color2} ¤${colorEnd} ${color1}| Ubuntu Install |${colorEnd}---"
installDebian() {
    echo -e "${color4}- install packages $1 ${colorEnd}"
    installNeovim() {
        pushd ~/Téléchargements
        wget https://github.com/neovim/neovim/releases/download/v0.8.3/nvim-linux64.deb
        sudo apt autoremove neovim
        sudo apt remove vim-common
        sudo apt install -y ./nvim-linux64.deb
        sudo rm nvim-linux64.deb
        popd
    }
    installNeovim
	sudo apt install -y nala
	sudo add-apt-repository ppa:touchegg/stable
	sudo nala install -y gnupg curl git-all touchegg gnome-shell-extension-manager gnome-tweaks gnome-shell-extensions neovim kitty cargo gocryptfs zsh ffmpegthumbnailer fzf jq zoxide ripgrep bat conky gh btop htop wl-clipboard unar gparted foremost testdisk nodejs npm rhythmbox lm-sensors zsh-autosuggestions zsh-syntax-highlighting xdotool
	
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
    echo -e "${color4}- install Fonts $1 ${colorEnd}"
    # NerdFonts
    # pushd /home/will/Téléchargemenets/
    mkdir -p ~/.local/share/fonts 
    pushd ~/.local/share/fonts
    wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/CascadiaCode.zip
    unzip CascadiaCode.zip
    fc-cache -fv
    rm CascadiaCode.zip
    popd

    # GoogleFonts
    sudo mkdir -p /usr/share/fonts/googlefonts
    pushd /usr/share/fonts/googlefonts
    sudo wget https://font.download/dl/font/raleway-5.zip
    sudo unzip raleway-5.zip
    sudo fc-cache -fv
    sudo rm raleway-5.zip
    popd
}

installMongodb() {
    echo -e "${color4}- install mongodb $1 ${colorEnd}"
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



