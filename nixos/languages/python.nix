{ config, pkgs, ... }:
in {
  environment.systemPackages = with pkgs; [
    python312
    python312Packages.psutil
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
  ];
}
