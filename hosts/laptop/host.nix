{ inputs, config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    inputs.home-manager.nixosModules.default
  ];

  home-manager.users.linuxuser = import ./home/home.nix;

  hardware.nvidia.open = true;
  networking.wireless.userControlled.enable = true;

  boot.loader.grub.device = "/dev/sda";
}
