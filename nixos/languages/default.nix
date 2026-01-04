{ config, pkgs, languages, ... }:
{
  imports =
    (if languages.beam then [ ./beam.nix ] else []) ++
    (if languages.c then [ ./c.nix ] else []) ++
    (if languages.asm then [ ./asm.nix ] else []) ++
    (if languages.go then [ ./go.nix ] else []) ++
    (if languages.javascript then [ ./javascript.nix ] else []) ++
    (if languages.lua then [ ./lua.nix ] else []) ++
    (if languages.python then [ ./python.nix ] else []) ++
    (if languages.rust then [ ./rust.nix ] else []) ++
    (if languages.zig then [ ./zig.nix ] else []);
}
