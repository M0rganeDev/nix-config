{ pkgs, config, lib, ... } : 

{
  home.enableNixpkgsReleaseCheck = false;
  home.stateVersion = "24.05";
  qt = {
    enable = true;

    platformTheme.name = "qtct";

    style.name = "kvantum";
  };
  dconf.settings = {
    "org/virt-manager/virt-manager/connections" = {
      autoconnect = ["qemu:///system"];
      uris = ["qemu:///system"];
    };
  };
  xdg.configFile = {
    "Kvantum/kvantum.kvconfig".text = ''
      [General]
      theme=GraphiteNordDark
    '';

    "Kvantum/GraphiteNord".source = "${pkgs.graphite-kde-theme}/share/Kvantum/GraphiteNord";
  };
  imports = [
    ./git.nix
    ./dunst.nix
    ./vim.nix
    ./kitty.nix
    ./i3.nix
    ./zsh.nix
	./fish.nix
	./picom.nix
    ./obs.nix
  ];
}
