{ config, pkgs, quickshell, ... }:
{
  services.xserver.enable = true;
  services.displayManager.ly.enable = true;
  services.desktopManager.gnome.enable = false;
  programs.hyprland.enable = true;
  programs.hyprlock.enable = true;
  programs.foot.enable = true;
  programs.sway.enable = true;
  programs.dconf.enable = true;
  environment.systemPackages = with pkgs; [
    quickshell.packages.${pkgs.system}.quickshell
    catppuccin-cursors.mochaMauve
    swaybg
    wl-clipboard
    mako
    lm_sensors
    grim
    slurp
    hyprcursor
    hyprsunset
    playerctl
    libnotify
  ];
}
