{ pkgs, config, lib, ... } : 

{
  home.enableNixpkgsReleaseCheck = false;
  home.stateVersion = "24.05";
  
  imports = [
    ../../shared/home/home.nix
  ];
}
