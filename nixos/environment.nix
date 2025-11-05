{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    fastfetch
    pipes
    vim
    dust
    btop
    yazi
    scrcpy
    cloc
    wf-recorder
    cava

    wget
    git
    git-lfs
    nmap
    inetutils
    android-tools
    sqlite

    zoxide
    starship
    eza
    fzf
    termusic
    lazygit
    fortune
    cowsay
    lolcat
  ];
  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];
}
