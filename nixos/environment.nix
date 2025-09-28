{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    gcc
    # python312 # already added with nvim.nix
    zoxide
    starship
    cmake
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
