{ pkgs, ... } :

{
	programs.fish = {
		enable = true;

		interactiveShellInit = ''
		set fish_greeting

		clear

		function nixcfg
			set previous $PWD
			cd /etc/nixos
			vim
			cd $previous
		end

		function nswitch
	        sudo nixos-rebuild switch --flake /etc/nixos#$argv[1] --impure
		end

		function fish_prompt
			printf "\n%s - %s > "	 $USER $PWD
		end
		'';
		shellAliases = {
			"clear" = "clear && nerdfetch";
		};
	};
}
