{ config, pkgs, unstable, ... }:
{
  environment.systemPackages = with pkgs; [
    unstable.neovim

    unzip
    xsel
    ripgrep
    tree-sitter

    vscode-langservers-extracted
  ];
}
