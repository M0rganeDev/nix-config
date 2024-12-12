{ pkgs, lib, config, ... } :

let
  # Read the content of your custom i3 config file
  i3ConfigContent = builtins.readFile /etc/nixos/config/i3/config;
in
{
    # Ensure jq is available
    home.packages = with pkgs; [ jq ];
    xsession.windowManager.i3 = {
        enable = true;
        package = pkgs.i3-gaps;
        config = {
            bars = [];
        };
        extraConfig = i3ConfigContent;
    };
}
