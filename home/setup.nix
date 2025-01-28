{ pkgs ? import <nixpkgs> {} }:
pkgs.mkShell {
  # List of packages to include
  buildInputs = with pkgs; [
    libsForQt5.spectacle
    p7zip
    nix-index
    python3
    python3.pkgs.virtualenv
    cmake
    gnumake
    gcc
    rustup
  ];

  # Use fish as the default shell
  shellHook = ''
    alias neovide="neovide --fork"
    # Check ../fish/functions/fish_prompt.fish, line 30
    export NIX_SHELL=1

    if [ "$SHELl" != "$(which fish)" ]; then
      exec $(which fish)
    fi
  '';
}
