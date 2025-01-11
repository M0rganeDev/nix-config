{libs, pkgs, ...}:

{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    
	# This command let's me execute arbitrary binaries downloaded through channels such as mason.
	# https://www.reddit.com/r/NixOS/comments/13uc87h/comment/kgraua7/?utm_source=share&utm_medium=web3x&utm_name=web3xcss&utm_term=1&utm_content=share_button
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
