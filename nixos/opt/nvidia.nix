{ config, pkgs, ... }:
{
  hardware.graphics.enable = true;
  hardware.nvidia = {
    modesetting.enable = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
    nvidiaSettings = true;
    open = false;
    prime = {

    };
  };
  hardware.graphics.enable32Bit = true;
  hardware.graphics.extraPackages = with pkgs; [
    nvidia-vaapi-driver
  ];
  boot.kernelParams = [ "acpi_backlight=video" ];
  boot.initrd.kernelModules = [ "nvidia" "hp_wmi" ];
  services.xserver.videoDrivers = [ "nvidia" ];
}
