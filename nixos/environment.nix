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
    (pkgs.python313.withPackages (ps: with ps; [
    ]))
  ];
  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];
}
