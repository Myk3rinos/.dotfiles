# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.timeout = 1;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Paris";

  # Select internationalisation properties.
  i18n.defaultLocale = "fr_FR.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "fr_FR.UTF-8";
    LC_IDENTIFICATION = "fr_FR.UTF-8";
    LC_MEASUREMENT = "fr_FR.UTF-8";
    LC_MONETARY = "fr_FR.UTF-8";
    LC_NAME = "fr_FR.UTF-8";
    LC_NUMERIC = "fr_FR.UTF-8";
    LC_PAPER = "fr_FR.UTF-8";
    LC_TELEPHONE = "fr_FR.UTF-8";
    LC_TIME = "fr_FR.UTF-8";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # Configure keymap in X11
  services.xserver = {
    layout = "fr";
    xkbVariant = "";
  };

  # Configure console keymap
  console.keyMap = "fr";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.will = {
    isNormalUser = true;
    description = "will";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      firefox
    # thunderbird
      neofetch
    ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
  #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  #  wget
    rhythmbox # for music
    clapper # for video
  	xdotool
	yazi
	nodejs
    corepack_21
    openssl
    prisma-engines
    nodePackages_latest.prisma
	git
    gitAndTools.gh
    lazygit
	starship
    zsh
    lsd
    bat
    fzf
    ncdu # for disk usage
    kitty
    catppuccin-gtk
    nightfox-gtk-theme
    tokyo-night-gtk
    orchis-theme
    htop
    btop
    gcc_multi
    tldr
    conky
    # amberol
    neovim
    rustup
    google-chrome
    cargo # for rust nvim nul_ls
    # delve # for neovim debug
    # vimPlugins.nvim-dap-go # for neovim debug
    wl-clipboard # for neovim copy
    universal-ctags # for neovim tagbar
    ctags
    ttags # generate tags for treesitter
    global
    mdctags
    gnome.gnome-tweaks
    gnomeExtensions.dash-to-dock
    gnomeExtensions.media-controls
    gnomeExtensions.extension-list
    gnomeExtensions.removable-drive-menu
    gnomeExtensions.vitals
    gnomeExtensions.caffeine
    gnomeExtensions.top-bar-organizer
    gnomeExtensions.clipboard-indicator
    gnomeExtensions.color-picker
    gnomeExtensions.freon
    undervolt
    mangohud
    gnomeExtensions.app-menu-is-back
    gnomeExtensions.forge
    # vault
    gocryptfs
    # INFO: ---- for yazi ----
    file # for file type
    ffmpegthumbnailer # for thumbnails
    unar # for archive
    jq # for json
    poppler # for pdf
    fd # for find
    # rg # for search
    zoxide # for cd
    # ---- for zsh ----
    most # for pager
    lm_sensors # for sensors
    liquidctl # for cooler
    # python311Packages.gpustat
    # python3
    # python311Packages.pynvml
    paperview
    # gsettings-desktop-schemas

    vimPlugins.nvim-treesitter-parsers.tsx
];


programs.zsh.syntaxHighlighting.enable = true;
programs.zsh.autosuggestions.enable = true;
programs.zsh.enable = true;
programs.starship.enable = true;
users.defaultUserShell = pkgs.zsh;

programs.neovim = {
	enable = true;
	defaultEditor = true;
};
# systemd.user.services.startOnWorkspace1 = {
#   # enable = true;
#   description = "start nixos on desktop";
#   serviceConfig.PassEnvironment = "DISPLAY";
#   script = ''
#     xdotool set_desktop 1
#     btop
#   '';
#   wantedBy = [ "multi-user.target" ]; # starts after login
#   # partOf = [ "graphical-session.target" ];
# };
# programs.bash.loginShellInit = ''
#   xdotool set_desktop 1
# '';
# ------------------------------------------------------
fonts.packages = with pkgs; [
  cascadia-code
  font-awesome
  google-fonts
  fira-code
  (nerdfonts.override { fonts = [ "FiraCode" "CascadiaCode" ]; })
];

# services.xserver.videoDrivers = ["nvidia"]; # bug with libinput

# -----------------------------------------------------
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?

}
