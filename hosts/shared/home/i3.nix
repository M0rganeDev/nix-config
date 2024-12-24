{ pkgs, lib, config, ... } :

let
  i3ConfigContent = builtins.readFile /etc/nixos/config/i3/config;
in
{
  # Manage the i3 configuration file manually
  home.file.".config/i3/config".text = i3ConfigContent;

  # Include required packages
  home.packages = with pkgs; [ jq i3-gaps ];

  # Enable i3-gaps without managing its config
  xsession.windowManager.i3.enable = false;
}
