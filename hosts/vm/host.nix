{ inputs, config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
	../desktop/steam.nix
    inputs.home-manager.nixosModules.default
  ];

  home-manager.users.linuxuser = import ./home/home.nix;

  boot.loader.grub.device = "/dev/sda";
}
