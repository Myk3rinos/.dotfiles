#!/bin/bash


source ~/.dotfiles/.themes/colors.sh


installNodejs() {
    echo -e "${color4}- install Nodejs $1 ${colorEnd}"
    # Télécharger et installer nvm :
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash
    # au lieu de redémarrer le shell
    export NVM_DIR="$HOME/.nvm"
    \. "$NVM_DIR/nvm.sh"
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
    sudo apt-get install -y wget gpg
    local tmp_gpg
    tmp_gpg=$(mktemp /tmp/windsurf-stable.XXXXXX.gpg)
    wget -qO- "https://windsurf-stable.codeiumdata.com/wVxQEIWkwPUEAGf3/windsurf.gpg" | gpg --dearmor > "$tmp_gpg"
    sudo install -D -o root -g root -m 644 "$tmp_gpg" /etc/apt/keyrings/windsurf-stable.gpg
    echo "deb [arch=amd64 signed-by=/etc/apt/keyrings/windsurf-stable.gpg] https://windsurf-stable.codeiumdata.com/wVxQEIWkwPUEAGf3/apt stable main" | sudo tee /etc/apt/sources.list.d/windsurf.list > /dev/null
    rm -f "$tmp_gpg"
    sudo apt install -y apt-transport-https
    sudo apt update
    sudo apt install -y windsurf

    windsurf -v
}

installCursorIA() {
    echo -e "${color4}- install CursorIA $1 ${colorEnd}"
    sudo apt update
    sudo apt install -y snapd
    sudo snap install cursor --classic
}


installYazi() {
    echo -e "${color4}- install Yazi $1 ${colorEnd}"
    #dependancy
    sudo nala install -y ffmpeg 7zip jq poppler-utils fd-find ripgrep fzf zoxide imagemagick xclip wl-clipboard xsel
    #rust
    if ! command -v cargo >/dev/null 2>&1; then
        curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
        # shellcheck disable=SC1091
        [ -f "$HOME/.cargo/env" ] && . "$HOME/.cargo/env"
    fi
    rustup update
    #yazi
    cargo install --locked yazi-fm #yazi-cli
}

installRMPC() {
  #install MPD (music player deamon)
  # Créer le répertoire de configuration s'il n'existe pas
  # mkdir -p ~/.config/mpd

  # Copier un exemple de configuration (si disponible)
  # cp /usr/share/doc/mpd/mpdconf.example ~/.config/mpd/mpd.conf

  # OU créer votre propre configuration
  # (comme celle que vous avez déjà dans ~/.config/mpd/mpd.conf)

  # Désactiver le service système
  sudo systemctl stop mpd.service mpd.socket 2>/dev/null || true
  sudo systemctl disable mpd.service mpd.socket 2>/dev/null || true

  # Activer le service utilisateur
  systemctl --user enable mpd.service
  systemctl --user start mpd.service

  # Mettre à jour la base de données (nécessite netcat)
  if command -v nc >/dev/null 2>&1; then
      echo "update" | nc localhost 6600 || true
  fi

  #install RMPC
  if ! command -v cargo >/dev/null 2>&1; then
      # shellcheck disable=SC1091
      [ -f "$HOME/.cargo/env" ] && . "$HOME/.cargo/env"
  fi
  cargo install --git https://github.com/mierak/rmpc --locked
}

installBat() {
    echo -e "${color4}- install Bat $1 ${colorEnd}"
    mkdir -p ~/.local/bin
    if [ -e /usr/bin/batcat ]; then
        ln -sfn /usr/bin/batcat ~/.local/bin/bat
    fi
}
installNeovim() {
    echo -e "${color4}- install Neovim $1 ${colorEnd}"
    sudo add-apt-repository -y ppa:neovim-ppa/unstable
    sudo apt update
    sudo apt install -y neovim
    # TSInstall markdown markdown_inline
}

installLazyGit() {
    echo -e "${color4}- install LazyGit $1 ${colorEnd}"
    sudo add-apt-repository ppa:lazygit-team/release -y
    sudo apt update
    sudo apt install -y lazygit
    lazygit --version
}

installLazyDocker() {
    echo -e "${color4}- install LazyDocker $1 ${colorEnd}"
    curl https://raw.githubusercontent.com/jesseduffield/lazydocker/master/scripts/install_update_linux.sh | bash
    lazydocker --version
}

installFirefoxNightly() {
    echo -e "${color4}- install Firefox Nightly $1 ${colorEnd}"

    local tmp_tar
    tmp_tar=$(mktemp /tmp/firefox-nightly.XXXXXX.tar.xz)
    local url="https://download.mozilla.org/?product=firefox-nightly-latest-ssl&os=linux64&lang=en-US"

    if ! wget -O "$tmp_tar" "$url"; then
        echo -e "${colorB}- Échec du téléchargement de Firefox Nightly ${colorEnd}"
        rm -f "$tmp_tar"
        return 1
    fi

    sudo rm -rf /opt/firefox-nightly
    sudo mkdir -p /opt
    sudo tar -xJf "$tmp_tar" -C /opt
    sudo mv /opt/firefox /opt/firefox-nightly
    rm -f "$tmp_tar"

    sudo ln -sfn /opt/firefox-nightly/firefox /usr/local/bin/firefox-nightly

    sudo tee /usr/share/applications/firefox-nightly.desktop > /dev/null <<'EOF'
[Desktop Entry]
Name=Firefox Nightly
Comment=Browse the World Wide Web
GenericName=Web Browser
Exec=/opt/firefox-nightly/firefox %u
Icon=/opt/firefox-nightly/browser/chrome/icons/default/default128.png
Terminal=false
Type=Application
MimeType=text/html;text/xml;application/xhtml+xml;application/xml;application/vnd.mozilla.xul+xml;application/rss+xml;application/rdf+xml;image/gif;image/jpeg;image/png;x-scheme-handler/http;x-scheme-handler/https;
StartupNotify=true
Categories=Network;WebBrowser;
StartupWMClass=firefox-nightly
EOF

    /opt/firefox-nightly/firefox --version
}

installAllPackages() {
    echo -e "${color4}- install packages $1 ${colorEnd}"
    sudo apt install -y nala

    PACKAGES=(
		make
		gnupg
		curl
		git-all
		gnome-shell-extension-manager
		gnome-tweaks
		gnome-shell-extensions
		kitty
		cargo
		gocryptfs
		zsh
		bat
		gh
        glab
		btop
        screenfetch
		htop
		unar
		unzip
		netcat-openbsd
		gparted
		testdisk
		rhythmbox
        mpd
		lm-sensors
		zsh-autosuggestions
		zsh-syntax-highlighting
        certbot
        python3-certbot-nginx
        cryptsetup
        clamav
        clamav-daemon
        redis
        docker-ce
        docker-compose-plugin

		xdotool
		conky-all
		celluloid
        sqlite3
        usbmuxd
        libimobiledevice6
        libimobiledevice-utils
        libimage-exiftool-perl
        python3-pip
        python3-venv
    )
    sudo nala install -y "${PACKAGES[@]}"
    # Vérification de l'installation
    local install_failed=0
    for package in "${PACKAGES[@]}"; do
        if ! dpkg -l "$package" > /dev/null 2>&1; then
            echo -e "${colorB}Erreur : impossible d'installer $package${colorEnd}"
            install_failed=1
        fi
    done


    sudo add-apt-repository -y ppa:touchegg/stable
    sudo apt update
    sudo apt install -y touchegg


    installNodejs
    installYazi
    # installWindsurfIA
    # installCursorIA
    installRMPC
    installBat
    installNeovim
    # installLazyGit
    # installLazyDocker
    # installFirefoxNightly

	sudo npm install -g pnpm
	cargo install lsd

    #starship
	curl -sS https://starship.rs/install.sh | sh -s -- -y

    #gemini IA
    # npm install -g @google/gemini-cli
    npm install -g @anthropic-ai/claude-code

    # sudo nala list --upgradable
    sudo nala update
	sudo nala upgrade -y
	sudo apt update
	sudo apt upgrade -y


    #choose zsh
    chsh -s "$(which zsh)"



    if [ "$install_failed" -eq 0 ]; then
        echo -e "${color4}- install All packages Done ${colorEnd}"
    else
        echo -e "${colorB}- install All packages Failed (some packages are missing) ${colorEnd}"
        return 1
    fi
}




installMongodb() {
    echo -e "${color4}- install mongodb $1 ${colorEnd}"
    sudo apt-get install -y gnupg curl
    curl -fsSL https://www.mongodb.org/static/pgp/server-8.0.asc | \
    sudo gpg -o /usr/share/keyrings/mongodb-server-8.0.gpg \
   --dearmor
    local codename
    codename=$(lsb_release -cs)
    echo "deb [ arch=amd64,arm64 signed-by=/usr/share/keyrings/mongodb-server-8.0.gpg ] https://repo.mongodb.org/apt/ubuntu ${codename}/mongodb-org/8.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-8.0.list
    sudo apt-get update
    sudo apt-get install -y mongodb-org
    sudo systemctl enable --now mongod
}




installFont() {
    echo -e "${color4}- install Fonts $1 ${colorEnd}"
    # NerdFonts
    mkdir -p ~/.local/share/fonts
    pushd ~/.local/share/fonts > /dev/null
    wget -q https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/CascadiaCode.zip
    unzip -o CascadiaCode.zip
    fc-cache -fv
    rm -f CascadiaCode.zip
    popd > /dev/null

    # GoogleFonts
    sudo mkdir -p /usr/share/fonts/googlefonts
    pushd /usr/share/fonts/googlefonts > /dev/null
    sudo wget -q https://font.download/dl/font/raleway-5.zip
    sudo unzip -o raleway-5.zip
    sudo fc-cache -fv
    sudo rm -f raleway-5.zip
    popd > /dev/null
}

installPackages() {
    echo -e "------------------${color2} ¤${colorEnd} ${color3}| Install packages |${colorEnd}---"
    installAllPackages
    installFont
    installMongodb
}
