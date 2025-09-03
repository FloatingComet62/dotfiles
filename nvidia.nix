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
  boot.kernelParams = [ "acpi_backlight=vendor" ];
  boot.initrd.kernelModules = [ "nvidia" "hp_wmi" ];
  services.xserver.videoDrivers = [ "nvidia" ];
  nixpkgs.config.cudaSupport = true;

  environment.systemPackages = with pkgs; [
    linuxPackages.nvidia_x11
    unstable.cudaPackages.cuda_cudart
    unstable.cudaPackages.cudatoolkit
  ];
  environment.sessionVariables = {
    CUDA_HOME = "${pkgs.cudatoolkit}";
    CUDA_PATH = "${pkgs.cudatoolkit}";
    LD_LIBRARY_PATH = "${pkgs.linuxPackages.nvidia_x11}/lib";
  };
}
