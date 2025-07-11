{ config, pkgs, ... }:
let unstable = import <nixos-unstable> { config.allowUnfree = true; };
in {
  environment.systemPackages = with pkgs; [
    unstable.neovim

    ripgrep
    gcc
    cargo
    python311
    nodejs_20
    unzip
    lua
    lua53Packages.luarocks
    lua53Packages.luafilesystem
    xsel
    tree-sitter

    lua-language-server
    vscode-langservers-extracted
    rust-analyzer
    zls
    typescript-language-server
    javascript-typescript-langserver
    (pkgs.python3.withPackages (ps: with ps; [
      python-lsp-server
      python-lsp-jsonrpc
      python-lsp-black
      python-lsp-ruff
      pyls-isort
      pyls-flake8
      ruff
      black
      isort
    ]))
  ];
}
