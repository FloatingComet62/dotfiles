{ config, pkgs, ... }:
let unstable = import <nixos-unstable> { config.allowUnfree = true; };
in {
  environment.systemPackages = with pkgs; [
    unstable.neovim

    unzip
    xsel
    ripgrep
    tree-sitter

    vscode-langservers-extracted
  ];
}
