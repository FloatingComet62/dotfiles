{ config, pkgs, ... }:
let unstable = import <nixos-unstable> { config.allowUnfree = true; };
in {
  environment.systemPackages = with pkgs; [
    unstable.neovim

    go
    gcc
    cargo
    python312
    python312Packages.psutil
    nodejs_20
    lua
    zig
    lua53Packages.luarocks
    lua53Packages.luafilesystem
    beamMinimal27Packages.elixir
    beamMinimal27Packages.erlang

    unzip
    xsel
    ripgrep
    tree-sitter

    gopls
    clang-tools
    lua-language-server
    vscode-langservers-extracted
    rust-analyzer
    zls
    typescript-language-server
    javascript-typescript-langserver
    pyright
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
    beamMinimal27Packages.elixir-ls
    beamMinimal27Packages.erlang-ls
  ];
}
