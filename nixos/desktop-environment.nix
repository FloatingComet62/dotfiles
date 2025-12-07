{ config, pkgs, ... }:
let unstable = import <nixos-unstable> { config.allowUnfree = true; };
in {
  services.xserver.enable = true;
  services.displayManager.ly.enable = true;
  services.desktopManager.gnome.enable = false;
  programs.hyprland.enable = true;
  programs.hyprlock.enable = true;
  programs.foot.enable = true;
  programs.waybar.enable = true;
  programs.sway.enable = true;
  programs.dconf.enable = true;
  environment.systemPackages = with pkgs; [
    wofi
    adwaita-icon-theme
    swaybg
    wl-clipboard
    mako
    lm_sensors
    grim
    slurp
    hyprsunset
    playerctl
    libnotify
  ];
}
