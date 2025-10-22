{
  pkgs,
  inputs,
  host,
  ...
}:
{

  programs = {
    hyprland = {
      enable = true;
      withUWSM = false;
      #package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland; #hyprland-git
      #portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland; #xdph-git

      portalPackage = pkgs.xdg-desktop-portal-hyprland; # xdph none git
      xwayland.enable = true;
    };
    zsh.enable = true;
    firefox.enable = true;
    waybar.enable = true;
    hyprlock.enable = true;
    dconf.enable = true;
    seahorse.enable = true;
    fuse.userAllowOther = true;
    mtr.enable = true;
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
    git.enable = true;
    tmux.enable = true;
    nm-applet.indicator = true;
    neovim = {
      enable = true;
      defaultEditor = false;
    };

    thunar.enable = true;
    thunar.plugins = with pkgs.xfce; [
      exo
      mousepad
      thunar-archive-plugin
      thunar-volman
      tumbler
    ];

  };
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [

    # Update flkake script
    (pkgs.writeShellScriptBin "fupdate" ''
      cd ~/NixOS-Hyprland
      nh os switch -u -H ${host} .
    '')

    # Rebuild flkake script
    (pkgs.writeShellScriptBin "frebuild" ''
      cd ~/NixOS-Hyprland
      nh os switch -H ${host} .
    '')

    # clean up old generations
    (writeShellScriptBin "ncg" ''
      nix-collect-garbage --delete-old && sudo nix-collect-garbage -d && sudo /run/current-system/bin/switch-to-configuration boot
    '')

    # Internet
    firefox
   
    # Hyprland Stuff
    hypridle
    hyprpolkitagent
    pyprland
    #uwsm
    hyprlang
    hyprshot
    hyprcursor
    mesa
    nwg-displays
    nwg-look
    waypaper
    hyprland-qt-support # for hyprland-qt-support

    #  Apps
    loupe
    appimage-run
    bc
    brightnessctl
    (btop.override {
      cudaSupport = true;
      rocmSupport = true;
    })
    bottom
    baobab
    btrfs-progs
    cmatrix
    dua
    duf
    cava
    cargo
    clang
    cmake
    cliphist
    cpufrequtils
    curl
    dysk
    eog
    eza
    findutils
    figlet
    ffmpeg
    fd
    feh
    file-roller
    glib # for gsettings to work
    gsettings-qt
    git
    gnome-system-monitor
    fastfetch
    jq
    gcc
    git
    gnumake
    grim
    grimblast
    gtk-engine-murrine # for gtk themes
    inxi
    imagemagick
    killall
    kdePackages.qt6ct
    kdePackages.qtwayland
    lazydocker
    libappindicator
    libnotify
    (mpv.override { scripts = [ mpvScripts.mpris ]; }) # with tray
    nvtopPackages.full
    openssl # required by Rainbow borders
    pciutils
    networkmanagerapplet
    pamixer
    pavucontrol
    playerctl
    kdePackages.polkit-kde-agent-1
    rofi
    slurp
    swappy
    swaynotificationcenter
    swww
    unzip
    wallust
    wdisplays
    wl-clipboard
    wlr-randr
    wlogout
    wget
    xarchiver
    yad
    yt-dlp

    (inputs.quickshell.packages.${pkgs.system}.default)
    (inputs.ags.packages.${pkgs.system}.default)

    # Utils
    caligula # burn ISOs at cli FAST
    atop
    gdu
    glances
    gping
    htop
    hyfetch
    ipfetch
    lolcat
    lsd
    oh-my-posh
    pfetch
    ncdu
    ncftp
    ripgrep
    socat
    starship
    tldr
    ugrep
    unrar
    v4l-utils
    obs-studio
    zoxide

    # Hardware related
    cpufetch
    cpuid
    cpu-x
    #gsmartcontrol
    smartmontools
    light
    lm_sensors
    mission-center
    neofetch

    # Development related
    luarocks
    nh
    vscode
    gh

    #Disk Utilities
    gnome-disk-utility
    gparted

    #Tocaro Blue
    postman
    wireshark

    # Virtuaizaiton
    virt-viewer
    libvirt

    # Video
    vlc

    # Terminals
    kitty
    wezterm

  ];

}
