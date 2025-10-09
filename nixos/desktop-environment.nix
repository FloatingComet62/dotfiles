{ config, pkgs, ... }:
let unstable = import <nixos-unstable> { config.allowUnfree = true; };
in {
  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = false;
  programs.hyprland.enable = true;
  programs.hyprlock.enable = true;
  programs.foot.enable = true;
  programs.waybar.enable = true;       # status bar
  programs.sway.enable = true;     # lock screen, idle management
  programs.dconf.enable = true;        # needed for gsettings
  environment.systemPackages = with pkgs; [
    wofi # app launcher
    adwaita-icon-theme
    swaybg
    wl-clipboard
    mako
    lm_sensors
    grim
    slurp
    hyprsunset
  ];
}
