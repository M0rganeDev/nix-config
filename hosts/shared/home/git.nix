{ pkgs, ... } :

{
  programs.git = {
    enable = true;
    userName = "Morgane";
    userEmail = "git@morgane.dev";

    extraConfig = {
      core.editor = "vim";
    };
  };
}
