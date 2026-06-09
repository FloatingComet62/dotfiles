{ config, pkgs, unstable, ... }:
{
  imports =
    [
      ./apps/browser.nix
    ];
  environment.systemPackages = with pkgs; [
    google-chrome
    blanket
    gimp
    # discord # electron has fucked discord, electron is currently unsecure package
    localsend
    libresprite
    # bitwarden-desktop # same electron issue
    parted
    obsidian
    libreoffice-qt6-fresh
    kdePackages.dolphin
    wineWow64Packages.stable
    vlc
  ];

  programs.obs-studio = {
    enable = true;

    package = (
      pkgs.obs-studio.override {
        cudaSupport = true;
      }
    );

    plugins = with pkgs.obs-studio-plugins; [
      wlrobs
      obs-backgroundremoval
      obs-pipewire-audio-capture
      obs-gstreamer
      obs-vkcapture
    ];
  };

  networking.firewall.allowedTCPPorts = [ 53317 41567 ];
  networking.firewall.allowedUDPPorts = [ 53317 41567 ];
}
