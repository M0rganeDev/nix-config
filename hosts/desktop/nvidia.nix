{pkgs, config, ...}:
{
  hardware.graphics.enable = true;
  hardware.graphics.extraPackages = [ pkgs.mesa.drivers ];

  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.cudaSupport = true;

  boot.kernelModules = [ "nvidia" ];
  
  services.xserver = {
    videoDrivers = [ "nvidia" ];
  };

  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = false;
    powerManagement.finegrained = false;
    open = false;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.beta;
  };
}
