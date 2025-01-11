{ inputs, config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./nvidia.nix
    ./steam.nix
    inputs.home-manager.nixosModules.default
  ];

  home-manager.users.linuxuser = import ./home/home.nix;

  boot.loader.grub.device = "/dev/nvme0n1";

  services.accounts-daemon.enable = true;

  virtualisation.virtualbox = {
  	host.enable = true;
    host.enableExtensionPack = true;
	guest.enable = true;
	guest.dragAndDrop = true;
  };

  users.users.linuxuser = {
    packages = with pkgs; [
      prismlauncher
      libsForQt5.kdenlive
      jetbrains-toolbox
      mono
      dotnetCorePackages.sdk_9_0
	  flatpak
	  gnome-software
	  xdg-desktop-portal-gtk
	  xdg-desktop-portal-gnome
	  xdg-desktop-portal-kde
    ];
  };
}
