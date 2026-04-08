{ config, pkgs, ... }:
{
  imports =
    [
      ./apps/browser.nix
    ];
  environment.systemPackages = with pkgs; [
    gimp
    vscode
    discord
    localsend
    bitwarden-desktop
    obsidian
    libreoffice-qt6-fresh
    kdePackages.dolphin
    wineWowPackages.stable
    vlc
  ];

  networking.firewall.allowedTCPPorts = [ 53317 8081 ];
  networking.firewall.allowedUDPPorts = [ 53317 8081 ];
}
