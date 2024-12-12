{ pkgs, config, lib, ... } : 

{
  home.enableNixpkgsReleaseCheck = false;
  home.stateVersion = "24.05";
  qt = {
    enable = true;

    platformTheme.name = "qtct";

    style.name = "kvantum";
  };

  xdg.configFile = {
    "Kvantum/kvantum.kvconfig".text = ''
      [General]
      theme=GraphiteNordDark
    '';

    "Kvantum/GraphiteNord".source = "${pkgs.graphite-kde-theme}/share/Kvantum/GraphiteNord";
  };

  imports = [
    ../../shared/home/home.nix
  ];
}
