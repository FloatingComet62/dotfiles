{ config, pkgs, ... }:
{
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vscode
    discord
    localsend
    bitwarden
    obsidian
    jetbrains.pycharm-professional
    jetbrains.clion
    wineWowPackages.stable
    sqlite
    libreoffice-qt6-fresh

    kdePackages.dolphin
    # kio-extras
    # ffmpegthumbs
    # kdePackages.kdegraphics-thumbnailers
    # kdePackages.kimageformats

    android-tools
    scrcpy
  ];

  # for Localsend
  networking.firewall.allowedTCPPorts = [ 53317 ];
  networking.firewall.allowedUDPPorts = [ 53317 ];
}
