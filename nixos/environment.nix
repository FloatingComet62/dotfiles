{ config, pkgs, ... }:
{
  programs.nix-ld.enable = true;
  environment.systemPackages = with pkgs; [
    man-pages-posix
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
    lazydocker
    fortune
    cowsay
    lolcat
    just
  ];
  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];
}
