{ config, pkgs, ... }:
{
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vscode
    discord
    localsend
    bitwarden
    obsidian
    # jetbrains.pycharm-professional
    # jetbrains.clion
    libreoffice-qt6-fresh
    kdePackages.dolphin
    wineWowPackages.stable
  ];

  xdg = {
    mime.enable = true;
    mime.defaultApplications = {
      # don't use libreoffice draw for pdfs, use firefox
      "application/pdf" = [ "firefox.desktop" ];
    };
  };

  # for Localsend
  networking.firewall.allowedTCPPorts = [ 53317 8081 ];
  networking.firewall.allowedUDPPorts = [ 53317 8081 ];
}
