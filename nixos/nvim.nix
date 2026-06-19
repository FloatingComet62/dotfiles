{ config, pkgs, unstable, ... }:
{
  environment.systemPackages = with pkgs; [
    unstable.neovim

    zip
    unzip

    xsel
    ripgrep
    tree-sitter
    
    luajitPackages.magick

    vscode-langservers-extracted
  ];
}
