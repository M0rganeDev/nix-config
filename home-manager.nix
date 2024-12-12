{ config, pkgs, ... }:

{
     imports = [ <home-manager/nixos> ];
     home-manager.users.linuxuser = import ./home/home.nix;
}
