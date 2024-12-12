{libs, pkgs, ...} :

{
  services.picom = {
    enable = true;
    fade = true;
    fadeDelta = 3;
    vSync = true;
  };
}
