{ config, pkgs, quickshell, ... }:
{
  services.xserver.enable = true;
  services.xserver.displayManager.startx.enable = true;
  services.displayManager.ly.enable = true;
  services.desktopManager.gnome.enable = false;
  services.desktopManager.plasma6.enable = true;
  programs.hyprland.enable = true;
  programs.hyprlock.enable = true;
  programs.foot.enable = true;
  programs.sway.enable = true;
  programs.dconf.enable = true;
  environment.systemPackages = with pkgs; [
    libGL

    quickshell.packages.${pkgs.system}.quickshell
    qt6.qtwayland
    catppuccin-cursors.mochaMauve
    swaybg
    mako
    lm_sensors
    grim
    slurp
    hyprcursor
    hyprsunset
    hyprpicker
    playerctl
    libnotify

    wl-clipboard

    xclip
    libx11
    libxrandr
    libxinerama
    libxcursor
    libxi
    libxext
    libxfixes
  ];
}
