{ pkgs, lib, ... } :

let
  KittyConfigContent = builtins.readFile /etc/nixos/config/kitty/dracula.conf;
in

{
  programs.kitty = lib.mkForce {
    enable = true;
    extraConfig = KittyConfigContent;
    settings = {
      confirm_os_window_close = 0;
      dynamic_background_opacity = false;
      enable_audio_bell = false;
      mouse_hide_wait = "-1.0";
      window_padding_width = 0;
      background_opacity = "0.95";
      background_blur = 1;
	  font = "DepartureMono Nerd Font";
    };
  };
}
