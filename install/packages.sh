#!/bin/bash
set -euo pipefail

source ~/.dotfiles/script/colors.sh

# ---------------------------------------------------------------------------
# Logging helpers
# ---------------------------------------------------------------------------

log_step()    { echo -e "${color4}- $*${colorEnd}"; }
log_error()   { echo -e "${colorB}$*${colorEnd}" >&2; }
log_section() { echo -e "------------------${color2} ¤${colorEnd} ${color3}| $* |${colorEnd}---"; }

# ---------------------------------------------------------------------------
# Package lists
# ---------------------------------------------------------------------------

APT_PACKAGES=(
    # Build essentials
    make                            # automatisation de build (Makefile)
    gnupg                           # chiffrement et signature GPG
    curl                            # client HTTP / téléchargement
    wget                            # téléchargement (utilisé par installFont)
    git-all                         # suite Git complète (gui, doc, svn...)

    # GNOME
    gnome-shell-extension-manager   # GUI pour gérer les extensions GNOME
    gnome-shell-extensions          # collection officielle d'extensions
    gnome-tweaks                    # réglages avancés de GNOME
    yaru-theme-gtk                  # variantes GTK Yaru (magenta, sage...)
    yaru-theme-icon                 # variantes d'icônes Yaru

    # Terminal & shell
    kitty                           # émulateur de terminal accéléré GPU
    zsh                             # shell (alternative à bash)
    zsh-autosuggestions             # suggestions de commandes basées sur l'historique
    zsh-syntax-highlighting         # coloration syntaxique dans le prompt zsh
    bat                             # `cat` amélioré avec coloration et pagination
    btop                            # moniteur de ressources (CPU/RAM/réseau)
    htop                            # visualiseur de processus interactif
    lsd                             # `ls` moderne avec icônes et couleurs
    # screenfetch                   # remplacé par fastfetch (installé via .deb GitHub)

    # Yazi (file manager) + dépendances pour preview & navigation
    fd-find                         # alternative moderne à `find` (utilisée par yazi/fzf)
    ffmpeg                          # preview vidéo dans yazi
    fzf                             # fuzzy finder (recherche interactive)
    imagemagick                     # preview d'images dans yazi
    jq                              # parseur JSON (utilisé par yazi & co)
    p7zip-full                      # preview d'archives 7z/zip
    poppler-utils                   # preview PDF dans yazi
    ripgrep                         # recherche rapide dans le contenu (alt. à grep)
    zoxide                          # navigation rapide entre dossiers (alt. à cd)

    # Dev tools
    cargo                           # gestionnaire de paquets Rust
    code                            # Visual Studio Code (dépôt Microsoft)
    gh                              # CLI GitHub
    glab                            # CLI GitLab
    nodejs                          # Node.js LTS + npm (dépôt NodeSource)
    sqlite3                         # base de données SQL embarquée
    python3-pip                     # gestionnaire de paquets Python
    python3-venv                    # environnements virtuels Python
    pipx                            # installation isolée d'outils Python en CLI

    # System utilities
    gocryptfs                       # système de fichiers chiffré (overlay)
    cryptsetup                      # chiffrement de disque (LUKS)
    libinput-tools                  # outils libinput (gestes, x11gestures)
    lm-sensors                      # lecture des capteurs matériels (temp, ventilos)
    rfkill                          # bloquer/débloquer radio (BT, WiFi)
    ufw                             # firewall (utilisé par setGnomeConfig)
    unar                            # extracteur d'archives universel
    unzip                           # extraction de fichiers ZIP
    # netcat-openbsd                # couteau suisse réseau (TCP/UDP)
    # xdotool                       # automatisation clavier/souris sous X11

    # Disk & partitions
    gparted                         # éditeur de partitions (GUI)
    testdisk                        # récupération de données / partitions

    # Media
    # celluloid                     # frontend GTK pour mpv
    conky-all                       # moniteur système sur le bureau
    mpd                             # daemon de lecture musicale (serveur pour rmpc)
    # rhythmbox                     # lecteur de musique GNOME

    # Web / TLS
    certbot                         # client Let's Encrypt (certificats SSL)
    python3-certbot-nginx           # plugin certbot pour Nginx

    # Security
    clamav                          # antivirus open source
    clamav-daemon                   # service de scan ClamAV en arrière-plan

    # Database
    mongodb-org                     # MongoDB 8.0 (dépôt officiel MongoDB)
    redis                           # base clé-valeur en mémoire

    # iOS / device support
    libimage-exiftool-perl          # lecture/écriture de métadonnées d'images
    libimobiledevice-utils          # outils CLI pour appareils iOS
    libimobiledevice6               # bibliothèque de communication iOS
    usbmuxd                         # daemon USB pour appareils iPhone/iPad
)

# ---------------------------------------------------------------------------
# Installation steps
# ---------------------------------------------------------------------------

install_apt_packages() {
    log_step "installing apt packages"
    sudo apt update
    sudo apt install -y "${APT_PACKAGES[@]}"
}

verify_apt_packages() {
    log_step "verifying apt packages"
    local failed=0
    for package in "${APT_PACKAGES[@]}"; do
        if ! dpkg -s "$package" 2>/dev/null | grep -q "Status: install ok installed"; then
            log_error "  ✗ $package"
            failed=1
        fi
    done
    return "$failed"
}

install_touchegg() {
    log_step "installing touchegg (PPA)"
    sudo add-apt-repository -y ppa:touchegg/stable
    sudo apt update
    sudo apt install -y touchegg
}

setup_vscode_repo() {
    log_step "configuring VSCode apt repository"
    # Suppression des éventuels fichiers source VSCode pré-existants
    # (l'install .deb officielle Microsoft crée /etc/apt/sources.list.d/vscode.sources
    #  avec une clé différente — conflit Signed-By sinon)
    sudo rm -f /etc/apt/sources.list.d/vscode.sources

    local key_tmp
    key_tmp=$(mktemp)
    curl -fsSL https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > "$key_tmp"
    sudo install -D -o root -g root -m 644 "$key_tmp" /etc/apt/keyrings/packages.microsoft.gpg
    rm -f "$key_tmp"

    echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" \
        | sudo tee /etc/apt/sources.list.d/vscode.list > /dev/null
}

setup_nodejs_repo() {
    log_step "configuring NodeSource apt repository (Node.js 24 LTS)"
    sudo install -m 0755 -d /etc/apt/keyrings
    curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key \
        | sudo gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg
    sudo chmod a+r /etc/apt/keyrings/nodesource.gpg

    # node_24.x = Active LTS depuis octobre 2025 (jusqu'à octobre 2026, puis
    # maintenance jusqu'à avril 2028). Pour changer de version, modifier ici.
    echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_24.x nodistro main" \
        | sudo tee /etc/apt/sources.list.d/nodesource.list > /dev/null
}

setup_mongodb_repo() {
    log_step "configuring MongoDB apt repository (8.0)"
    sudo install -m 0755 -d /etc/apt/keyrings
    curl -fsSL https://pgp.mongodb.com/server-8.0.asc \
        | sudo gpg --dearmor -o /etc/apt/keyrings/mongodb-server-8.0.gpg
    sudo chmod a+r /etc/apt/keyrings/mongodb-server-8.0.gpg

    echo "deb [arch=amd64,arm64 signed-by=/etc/apt/keyrings/mongodb-server-8.0.gpg] https://repo.mongodb.org/apt/ubuntu noble/mongodb-org/8.0 multiverse" \
        | sudo tee /etc/apt/sources.list.d/mongodb-org-8.0.list > /dev/null
}

enable_mongodb() {
    log_step "enabling MongoDB service"
    sudo systemctl enable --now mongod
}

setup_docker_repo() {
    log_step "configuring Docker apt repository"
    # Suppression des paquets Docker éventuellement fournis par Ubuntu
    for pkg in docker.io docker-doc docker-compose docker-compose-v2 podman-docker containerd runc; do
        sudo apt remove -y "$pkg" 2>/dev/null || true
    done

    # Ajout de la clé GPG officielle Docker
    sudo install -m 0755 -d /etc/apt/keyrings
    sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
    sudo chmod a+r /etc/apt/keyrings/docker.asc

    # Ajout du dépôt
    local arch codename
    arch=$(dpkg --print-architecture)
    codename=$(. /etc/os-release && echo "$VERSION_CODENAME")
    echo "deb [arch=${arch} signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu ${codename} stable" \
        | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
}

install_docker() {
    log_step "installing Docker"
    sudo apt update
    sudo apt install -y \
        docker-ce \
        docker-ce-cli \
        containerd.io \
        docker-buildx-plugin \
        docker-compose-plugin
}

# install_fastfetch() {
#     log_step "installing fastfetch (.deb depuis GitHub)"
#     local arch deb_url tmp_deb
#     arch=$(dpkg --print-architecture)
#     deb_url=$(curl -fsSL https://api.github.com/repos/fastfetch-cli/fastfetch/releases/latest \
#         | grep -o "https://[^\"]*linux-${arch}\.deb" \
#         | head -n1)

#     if [ -z "$deb_url" ]; then
#         log_error "  ✗ impossible de trouver le .deb fastfetch pour ${arch}"
#         return 1
#     fi

#     tmp_deb=$(mktemp --suffix=.deb)
#     curl -fsSL -o "$tmp_deb" "$deb_url"
#     sudo apt install -y "$tmp_deb"
#     rm -f "$tmp_deb"
# }

install_yazi() {
    log_step "installing yazi (.deb depuis GitHub)"
    local deb_url tmp_deb
    deb_url=$(curl -fsSL https://api.github.com/repos/sxyazi/yazi/releases/latest \
        | grep -o "https://[^\"]*yazi-x86_64-unknown-linux-gnu\.deb" \
        | head -n1)

    if [ -z "$deb_url" ]; then
        log_error "  ✗ impossible de trouver le .deb yazi"
        return 1
    fi

    tmp_deb=$(mktemp --suffix=.deb)
    curl -fsSL -o "$tmp_deb" "$deb_url"
    sudo apt install -y "$tmp_deb"
    rm -f "$tmp_deb"
}

install_rmpc() {
    log_step "installing rmpc (.tar.gz depuis GitHub)"
    local tarball_url tmp_archive tmp_dir
    tarball_url=$(curl -fsSL https://api.github.com/repos/mierak/rmpc/releases/latest \
        | grep -o "https://[^\"]*x86_64-unknown-linux-gnu\.tar\.gz" \
        | head -n1)

    if [ -z "$tarball_url" ]; then
        log_error "  ✗ impossible de trouver le tarball rmpc"
        return 1
    fi

    tmp_archive=$(mktemp --suffix=.tar.gz)
    tmp_dir=$(mktemp -d)
    curl -fsSL -o "$tmp_archive" "$tarball_url"
    tar -xzf "$tmp_archive" -C "$tmp_dir"

    # Binaire, man page et complétions shell
    sudo install -Dm755 "$tmp_dir/rmpc"                 /usr/local/bin/rmpc
    sudo install -Dm644 "$tmp_dir/man/rmpc.1"           /usr/local/share/man/man1/rmpc.1
    sudo install -Dm644 "$tmp_dir/completions/_rmpc"    /usr/local/share/zsh/site-functions/_rmpc
    sudo install -Dm644 "$tmp_dir/completions/rmpc.bash" /etc/bash_completion.d/rmpc

    rm -rf "$tmp_archive" "$tmp_dir"
}

install_firefox_nightly() {
    log_step "installing Firefox Nightly (.tar.xz depuis Mozilla)"
    local install_dir="/opt/firefox-nightly"
    local url="https://download.mozilla.org/?product=firefox-nightly-latest-ssl&os=linux64&lang=fr"
    local tmp_archive
    tmp_archive=$(mktemp --suffix=.tar.xz)

    curl -fsSL -o "$tmp_archive" "$url"

    # L'archive contient un répertoire `firefox/` — on nettoie tout résidu puis on renomme
    sudo rm -rf "$install_dir" /opt/firefox
    sudo tar -xJf "$tmp_archive" -C /opt/
    sudo mv /opt/firefox "$install_dir"
    rm -f "$tmp_archive"

    # Lien dans le PATH (nom distinct pour ne pas écraser le Firefox système)
    sudo ln -sf "${install_dir}/firefox" /usr/local/bin/firefox-nightly

    # Entrée de menu pour GNOME / launchers
    sudo tee /usr/share/applications/firefox-nightly.desktop > /dev/null <<EOF
[Desktop Entry]
Name=Firefox Nightly
GenericName=Navigateur Web
Comment=Navigateur Web Firefox Nightly
Exec=${install_dir}/firefox %u
Icon=${install_dir}/browser/chrome/icons/default/default128.png
Terminal=false
Type=Application
Categories=Network;WebBrowser;
MimeType=text/html;x-scheme-handler/http;x-scheme-handler/https;
StartupNotify=true
StartupWMClass=firefox-nightly
EOF
}

install_external_tools() {
    log_step "installing external tools"
    sudo npm install -g pnpm
    curl -sS https://starship.rs/install.sh | sh -s -- -y
    sudo npm install -g @anthropic-ai/claude-code
    # sudo npm install -g @google/gemini-cli
}

installFont() (
    # Subshell + set +e : un téléchargement qui échoue ne stoppe pas le script.
    # La fonction retourne toujours 0.
    set +e
    log_step "installing fonts (Cascadia Code Nerd + Raleway)"

    # NerdFonts — Cascadia Code (latest depuis GitHub API, pas de version codée)
    local nerd_url
    nerd_url=$(curl -fsSL https://api.github.com/repos/ryanoasis/nerd-fonts/releases/latest \
        | grep -o "https://[^\"]*/CascadiaCode\.zip" \
        | head -n1)
    if [ -n "$nerd_url" ]; then
        mkdir -p ~/.local/share/fonts
        local tmp_zip
        tmp_zip=$(mktemp --suffix=.zip)
        curl -fsSL -o "$tmp_zip" "$nerd_url"
        unzip -oq "$tmp_zip" -d ~/.local/share/fonts
        rm -f "$tmp_zip"
        fc-cache -f ~/.local/share/fonts
    else
        log_error "  ✗ impossible de trouver l'URL Nerd Fonts CascadiaCode"
    fi

    # Raleway depuis le repo officiel Google Fonts (sparse-checkout du sous-dossier)
    local gf_dir=/usr/share/fonts/googlefonts
    sudo mkdir -p "$gf_dir"
    local tmp_repo
    tmp_repo=$(mktemp -d)
    git clone --depth=1 --filter=blob:none --sparse \
        https://github.com/google/fonts.git "$tmp_repo"
    git -C "$tmp_repo" sparse-checkout set ofl/raleway
    if [ -d "$tmp_repo/ofl/raleway" ]; then
        sudo cp -r "$tmp_repo/ofl/raleway" "$gf_dir/"
        sudo fc-cache -f "$gf_dir"
    else
        log_error "  ✗ Raleway introuvable dans google/fonts"
    fi
    rm -rf "$tmp_repo"

    return 0
)

verify_external_tools() {
    log_step "verifying external tools"
    local failed=0
    local cmd
    for cmd in yazi rmpc firefox-nightly pnpm starship claude; do
        if ! command -v "$cmd" >/dev/null 2>&1; then
            log_error "  ✗ $cmd"
            failed=1
        fi
    done
    return "$failed"
}

upgrade_system() {
    log_step "upgrading system"
    sudo apt update
    sudo apt upgrade -y
}

set_default_shell_zsh() {
    log_step "setting zsh as default shell"
    # ${SUDO_USER:-$USER} : si le script tourne sous sudo, cible l'utilisateur d'origine
    sudo chsh -s "$(command -v zsh)" "${SUDO_USER:-$USER}"
}

# ---------------------------------------------------------------------------
# Public entry points
# ---------------------------------------------------------------------------

installAllPackages() {
    setup_vscode_repo
    setup_nodejs_repo
    setup_mongodb_repo
    setup_docker_repo
    install_apt_packages
    install_docker
    enable_mongodb
    # install_fastfetch
    install_yazi
    install_rmpc
    install_firefox_nightly
    install_touchegg
    install_external_tools
    installFont
    upgrade_system
    set_default_shell_zsh

    local apt_ok=0 ext_ok=0
    verify_apt_packages       || apt_ok=1
    verify_external_tools     || ext_ok=1

    if [ "$apt_ok" -eq 0 ] && [ "$ext_ok" -eq 0 ]; then
        log_step "install All packages Done"
    else
        log_error "- install All packages Failed (some packages or tools are missing)"
        return 1
    fi
}

installPackages() {
    log_section "Install packages"
    installAllPackages
}
