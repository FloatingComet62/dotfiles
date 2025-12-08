{ config, pkgs, ... }:
{
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
    fortune
    cowsay
    lolcat

    openssl
    openssl.dev
  ];
  environment.variables = {
    OPENSSL_DIR = "${pkgs.openssl.dev}";
  };
  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];
}
