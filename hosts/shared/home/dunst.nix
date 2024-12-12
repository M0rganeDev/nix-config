{libs, pkgs, ...} :

{
  services.dunst = {
    enable = true;
    
    settings = {

      global = {
        font = "0xProto Nerd Font Propo 14";
      };

      urgency_normal = {
        background = "#02173c";
        foreground = "#510065";
      };
    };
  };
}
