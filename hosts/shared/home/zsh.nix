{libs, pkgs, ...}:

{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    
    initExtra = ''
    nerdfetch
    echo ""
    nixcfg() {
      local PREVIOUS=$(pwd)  
      cd /etc/nixos          
      vim               
      cd "$PREVIOUS"         
    }
    switch() {
      if [[ -z $1 ]]; then
        echo "please enter a valid nixconfiguration (desktop, laptop)"
      else
        sudo nixos-rebuild switch --flake /etc/nixos#$1 --impure
      fi
    }

    '';

    oh-my-zsh = {
      enable = true;
      theme = "frisk";
    };

    shellAliases = {
      clear  = "clear && nerdfetch && echo \"\"";
    };
  };
}
