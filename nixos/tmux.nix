{ config, pkgs, ... }:
# let unstable = import <nixos-unstable> { config.allowUnfree = true; };
{
  programs.tmux.enable = true;
  programs.tmux.plugins = with pkgs.tmuxPlugins; [
    sensible
    vim-tmux-navigator
    tmux-which-key
    tmux-powerline
    tmux-fzf
    gruvbox
    yank
  ];
}
