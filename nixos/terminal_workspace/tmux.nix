{ config, pkgs, ... }:
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
