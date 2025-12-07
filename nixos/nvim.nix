{ config, pkgs, unstable, ... }:
{
  environment.systemPackages = with pkgs; [
    unstable.neovim

    zip
    unzip

    xsel
    ripgrep
    tree-sitter

    vscode-langservers-extracted
  ];
}
