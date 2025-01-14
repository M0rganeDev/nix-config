{libs, pkgs, ...} : 

{
  services.jellyfin = {
    enable = true;
	user = "linuxuser";
  };
}
