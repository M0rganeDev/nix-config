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

  users.users.linuxuser = {
    packages = with pkgs; [
      prismlauncher
      libsForQt5.kdenlive
      jetbrains-toolbox
      mono
      unityhub
      dotnetCorePackages.sdk_9_0
    ];
  };
}
