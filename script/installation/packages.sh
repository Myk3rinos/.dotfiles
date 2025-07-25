#!/bin/bash


source ~/.dotfiles/script/colors.sh


installNodejs() {
    echo -e "${color4}- install Nodejs $1 ${colorEnd}"
    # Télécharger et installer nvm :
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash
    # au lieu de redémarrer le shell
    \. "$HOME/.nvm/nvm.sh"
    # Télécharger et installer Node.js :
    nvm install 22
    # Vérifier la version de Node.js :
    node -v # Doit afficher "v22.17.1".
    nvm current # Doit afficher "v22.17.1".
    # Vérifier la version de npm :
    npm -v # Doit afficher "10.9.2".
}




installWindsurfIA() {
    echo -e "${color4}- install WindsurfIA $1 ${colorEnd}"
    sudo apt-get install wget gpg
    wget -qO- "https://windsurf-stable.codeiumdata.com/wVxQEIWkwPUEAGf3/windsurf.gpg" | gpg --dearmor > windsurf-stable.gpg
    sudo install -D -o root -g root -m 644 windsurf-stable.gpg /etc/apt/keyrings/windsurf-stable.gpg
    echo "deb [arch=amd64 signed-by=/etc/apt/keyrings/windsurf-stable.gpg] https://windsurf-stable.codeiumdata.com/wVxQEIWkwPUEAGf3/apt stable main" | sudo tee /etc/apt/sources.list.d/windsurf.list > /dev/null
    rm -f windsurf-stable.gpg
    sudo apt install apt-transport-https
    sudo apt update
    sudo apt install windsurf

    windsurf -v
}



installYazi() {
    echo -e "${color4}- install Yazi $1 ${colorEnd}"
    #dependancy
    sudo nala install -y ffmpeg 7zip jq poppler-utils fd-find ripgrep fzf zoxide imagemagick xclip wl-clipboard xsel
    #rust
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
    rustup update
    #yazi
    cargo install --locked yazi-fm #yazi-cli
}




installAllPackages() {
    echo -e "${color4}- install packages $1 ${colorEnd}"
    sudo apt install -y nala
    
    PACKAGES=(
		make \
		gnupg \
		curl \
		git-all \
		gnome-shell-extension-manager \
		gnome-tweaks \
		gnome-shell-extensions \
		neovim \
		kitty \
		cargo \
		gocryptfs \
		zsh \
		bat \
		gh \
		btop \
		htop \
		unar \
		gparted \
		testdisk \
		rhythmbox \
		lm-sensors \
		zsh-autosuggestions \
		zsh-syntax-highlighting \
		xdotool \
		conky-all \
		celluloid \
        sqlite3 \
        usbmuxd \
        libimobiledevice6 \
        libimobiledevice-utils
    )
    sudo nala install -y ${PACKAGES[@]}
    # Vérification de l'installation
    for package in ${PACKAGES[@]}; do
        if ! dpkg -l $package > /dev/null 2>&1; then
            echo "Erreur : impossible d'installer $package"
            exit 1
        fi
    done


    sudo add-apt-repository ppa:touchegg/stable
    sudo apt update
    sudo apt install touchegg


    installNodejs
    installYazi
    installWindsurfIA

	sudo npm install -g pnpm
	cargo install lsd

    #starship
	curl -sS https://starship.rs/install.sh | sh
    
    #gemini IA
    npm install -g @google/gemini-cli

    # sudo nala list --upgradable
    sudo nala update
	sudo nala upgrade
	sudo apt update
	sudo apt upgrade
    
    
    #choose zsh
    chsh -s $(which zsh)



    if [ $? -eq 0 ]; then
        echo -e "${color4}- install All packages Done$1 ${colorEnd}"
    else
        echo -e "${color3}- install All packages Failed$1 ${colorEnd}"
        exit 1
    fi
}





installMongodb() {
    echo -e "${color4}- install mongodb $1 ${colorEnd}"
    sudo apt-get install gnupg curl
    curl -fsSL https://www.mongodb.org/static/pgp/server-8.0.asc | \
    sudo gpg -o /usr/share/keyrings/mongodb-server-8.0.gpg \
   --dearmor
    echo "deb [ arch=amd64,arm64 signed-by=/usr/share/keyrings/mongodb-server-8.0.gpg ] https://repo.mongodb.org/apt/ubuntu noble/mongodb-org/8.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-8.0.list
    sudo apt-get update
    sudo apt-get install -y mongodb-org
    sudo systemctl enable --now mongod
}




installFont() {
    echo -e "${color4}- install Fonts $1 ${colorEnd}"
    # NerdFonts
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

installPackages() {
    echo -e "------------------${color2} ¤${colorEnd} ${color3}| Install packages |${colorEnd}---"
    installAllPackages
    installFont
    installMongodb
}