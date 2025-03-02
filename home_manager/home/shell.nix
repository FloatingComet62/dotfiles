{ pkgs ? import <nixpkgs> {} }:
let
  setup = import ./setup.nix { inherit pkgs; };
in
pkgs.mkShell {
  name = "Dev";

  buildInputs = setup.buildInputs;
  shellHook = setup.shellHook;
}
