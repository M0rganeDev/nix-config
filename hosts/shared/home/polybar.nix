{ lib, config, pkgs, ... }:

let
  polybarConfig = "/etc/nixos/config/polybar/config.ini";
in
{
  programs.polybar = {
    enable = true;
  };

  home.file.".polybar-launch.sh".text = ''
    
  '';

  # Make the script executable and available in the user's PATH
  home.activation.enablePolybarLaunchScript = lib.mkAfter ''
    chmod +x ${config.home.homeDirectory}/.polybar-launch.sh
  '';
}
