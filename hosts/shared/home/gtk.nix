{libs, pkgs, ...}:

{
  home.gtk = {
      enable = true;
      gtk3.extraConfig.gtk-decoration-layout = "menu:";
      theme = {
        name = "Tokyonight-Dark-B";
        package = pkgs.tokyo-night-gtk;
      };
      iconTheme = {
        name = "Tokyonight-Dark";
      };
      cursorTheme = {
        name = gtkCursorTheme;
        package = pkgs.bibata-cursors;
        
      };
    };
    home.sessionVariables.GTK_THEME = "Tokyonight-Dark-B";
}
