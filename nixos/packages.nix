{
    pkgs,
    ...
}:
let
  unstable = import <nixos-unstable> {
    config = {
      allowUnfree = true;
    };
  };
in {
  # $ nix search <package>
  environment.systemPackages = with pkgs; [
    vim
    wget
    git
    unstable.neovim
    nmap
    dust
    ffmpeg
    rclone
    hyprpaper
    kdePackages.sddm-kcm
    vscode
    android-tools
  ];
  programs.fish.enable = true;
  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
      stdenv.cc.cc.lib
      zlib
    ];
  };
}
