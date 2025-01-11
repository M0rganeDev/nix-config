# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, inputs, ... }:

{
  nix = {
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
    settings.auto-optimise-store = true;
    settings.experimental-features = [ "nix-command" "flakes" ];
  };

  imports =
    [ # Include the results of the hardware scan.
      inputs.home-manager.nixosModules.default
    ];
  # Bootloader.
  boot.loader.grub.enable = true;
  boot.loader.grub.useOSProber = true;

  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.blacklistedKernelModules = [ "snd_pcsp" ];

  services.xserver.enable = true;
  services.xserver.windowManager.i3.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.displayManager.gdm.wayland = true;

  networking.hostName = "nixos"; #Define your hostname.

  # Enable networking
  networking.networkmanager.enable = true;
  networking.firewall.enable = false;
  # Set your time zone.
  time.timeZone = "Europe/Paris";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

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

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
  };

  # Configure console keymap
  console.keyMap = "us";

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.linuxuser = {
    isNormalUser = true;
    description = "linuxuser";
    extraGroups = [ "networkmanager" "wheel" "audio" "docker" "libvirtd"];
  };
  
  programs.zsh.enable = true;
  programs.fish.enable = true;

  # https://nixos.wiki/wiki/Fish#Setting_fish_as_your_shell
  programs.bash = {
    interactiveShellInit = ''
      if [[ $(${pkgs.procps}/bin/ps --no-header --pid=$PPID --format=comm) != "fish" && -z ''${BASH_EXECUTION_STRING} ]]
      then
        shopt -q login_shell && LOGIN_OPTION='--login' || LOGIN_OPTION=""
        exec ${pkgs.fish}/bin/fish $LOGIN_OPTION
      fi
    '';
  };

  users.defaultUserShell = pkgs.bash;

  virtualisation.virtualbox.host.enable = true;
  users.extraGroups.vboxusers.members = [ "linuxuser" ];
  programs.virt-manager.enable = true;
  users.groups.libvirtd.members = [ "linuxuser" ];
  virtualisation.libvirtd.enable = true;
  virtualisation.spiceUSBRedirection.enable = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
     opencv
     wget
     firefox
     vesktop
     nodejs_20
     jdk17
	 jdk21_headless
     python3
     picom
     polybar
     nitrogen
     killall
     neofetch
     htop
     libnotify
     flameshot
     xclip
     toybox
     nerdfetch
     vlc
     cargo
     rustc
     gcc
     rustup
     obsidian
     pavucontrol
     xorg.xkill
     slack
     rofi
	 gnumake
	 clang-tools
	 glib
	 glibc
	 tmux
     # Themes
     kdePackages.breeze-gtk
     kdePackages.breeze-icons
     kdePackages.breeze.qt5
	 dolphin
	 libsForQt5.qt5.qtsvg
	 libsForQt5.dolphin-plugins
     kdePackages.breeze
     kdePackages.qtsvg
     kdePackages.ark
     aseprite
     catppuccin-cursors # Mouse cursor theme
     catppuccin-papirus-folders # Icon theme, e.g. for pcmanfm-qt
     papirus-folders # For the catppucing stuff work
     nixd
     jq
  ];
  # needed by steam
  hardware.graphics.enable32Bit = true;
  hardware.pulseaudio.support32Bit = true;

  nixpkgs.config.qt = {
    enable = true;
    platformTheme.name = "kde";
    style = {
      name = "breeze";
    };
  };

  environment.variables.QT_QPA_PLATFORMTHEME = "qt5ct";

  fonts.packages = with pkgs; [
    udev-gothic-nf
    hackgen-nf-font
    plemoljp-nf
    nerd-fonts.open-dyslexic
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-emoji
    liberation_ttf
    fira-code
    fira-code-symbols
    mplus-outline-fonts.githubRelease
    dina-font
    proggyfonts
  ];

  security.polkit.enable = true;

  virtualisation.docker = {
    enable = true;
    rootless = {
      enable = true;
      setSocketVariable = true;  
    };
  };
  
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  services.xserver.libinput = {
    enable = true;
    middleEmulation = false;
  };


  services.openssh.enable = true;

  nixpkgs.config.allowUnfree = true;

  system.stateVersion = "24.11"; # Did you read the comment?
}
