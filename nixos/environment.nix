{ config, pkgs, ... }:
{
  environment.variables = {
    EDITOR = "nvim";
    XDG_CONFIG_HOME = "$HOME/.config";
    XDG_CACHE_HOME = "$HOME/.cache";
    PATH = [
      "$HOME/.bin"
      "$HOME/.cargo/bin"
      "$HOME/.android-sdk/cmdline-tools/latest/bin"
      "$HOME/.android-sdk/platform-tools"
      "$HOME/.android-sdk/emulator"
    ];
    PKG_CONFIG_PATH="$HOME/.local/lib/pkgconfig $HOME/.local/lib64/pkgconfig";
    LD_LIBRARY_PATH="$HOME/.local/lib $HOME/.local/lib64";
    ANDROID_NDK_HOME="$HOME/.android-ndk";
    ANDROID_NDK_ROOT="$HOME/.android-ndk";
    ANDROID_HOME="$HOME/.android-sdk";
  };
  programs.nix-ld.enable = true;
  environment.systemPackages = with pkgs; [
    man-pages-posix
    uutils-coreutils-noprefix
    fd
    bat
    eza
    xh
    hyperfine
    delta
    tokei
    wiki-tui
    bluetui

    fastfetch
    pipes
    vim
    dust
    btop
    yazi
    scrcpy
    wf-recorder
    cava

    wget
    git
    git-lfs
    nmap
    inetutils
    android-tools
    opencode
    sqlite
    bc

    zoxide
    starship
    fzf
    termusic
    lazygit
    lazydocker
    fortune
    cowsay
    lolcat
    just
    process-compose
    jq

    termshark
  ];
  fonts.packages = with pkgs; [
    dejavu_fonts
    nerd-fonts.jetbrains-mono
  ];
}
