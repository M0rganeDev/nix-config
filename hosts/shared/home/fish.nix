{ pkgs, ... } :

{
	programs.fish = {
		enable = true;

		interactiveShellInit = ''
		set fish_greeting

		clear

		function nixcfg
			cd /etc/nixos
			vim
			cd $OLDPWD
		end

		function nswitch
	        sudo nixos-rebuild switch --flake /etc/nixos#$argv[1] --impure
		end

		function push
			if not set -q argv[1]
				echo "please enter a commit message !"
			else
				git add *
				git add .
				git commit -m "$argv[1]"
				git push
			end
		end

		function fish_prompt
			printf "\n%s - %s %s\n> "	 $USER $PWD $(date '+[%H:%M:%S]')
		end
		'';
		shellAliases = {
			"clear" = "clear && nerdfetch";
		};
	};
}
