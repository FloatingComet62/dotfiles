{ config, pkgs, ... }:
let unstable = import <nixos-unstable> { config.allowUnfree = true; };
in {
  hardware.graphics.enable = true;
  hardware.nvidia = {
    modesetting.enable = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
    nvidiaSettings = true;
    open = true;
  };
  boot.kernelParams = [ "acpi_backlight=video" ];
  boot.initrd.kernelModules = [ "nvidia" "hp_wmi" ];
  services.xserver.videoDrivers = [ "nvidia" ];
}
