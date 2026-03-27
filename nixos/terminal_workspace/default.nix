{ config, pkgs, terminalworkspace, ... }:
{
  imports =
    (if terminalworkspace.tmux then [ ./tmux.nix ] else []) ++
    (if terminalworkspace].zellij then [ ./zellij.nix ] else []);
}
