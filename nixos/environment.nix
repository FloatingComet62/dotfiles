{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    fastfetch
    vim
    wget
    git
    nmap
    dust
    home-manager
    zoxide
    starship
    git-lfs
    inetutils
    btop
    pipes
    playerctl
    libnotify
    termusic
    eza
    lazygit
    fzf
  ];
  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];
}
