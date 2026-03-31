{ config, pkgs, username, terminalworkspace, ... }:
{
  users.users.${username} = {
    isNormalUser = true;
    description = "User";
    extraGroups = [ "networkmanager" "wheel" "kvm" "adbusers" "docker" ];
    packages = with pkgs; [];
    shell = pkgs.fish;
  };
  virtualisation.docker.enable = true;
  programs.adb.enable = true;
  programs.fish = {
    enable = true;
    shellInit = ''
function fish_prompt -d "Write out the prompt"
    # This shows up as USER@HOST /home/user/ >, with the directory colored
    # $USER and $hostname are set by fish, so you can just use them
    # instead of using `whoami` and `hostname`
    printf '%s@%s %s%s%s > ' $USER $hostname \
        (set_color $fish_color_cwd) (prompt_pwd) (set_color normal)
end
'' + (if terminalworkspace.tmux then ''
if status is-interactive
    set fish_greeting

    if not set -q TMUX
        tmux new-session -d -s "main" -c "~/dev"
        if not set -q VSCODE_PID
            tmux -u a
        end
    end
end
'' else '''') + (if terminalworkspace.zellij then ''
if status is-interactive
    set fish_greeting

    if status is-interactive
    set fish_greeting

    if not set -q ZELLIJ
        if not set -q VSCODE_PID
            cd ~/dev
            zellij attach --create main
        end
    end
end
end
'' else '''') + ''
function tsnode
    set filename (basename $argv[1] .ts)
    tsc $filename.ts
    node $filename.js
    rm $filename.js
end

zoxide init --cmd cd fish | source
starship init fish | source
if test -f ~/.cache/ags/user/generated/terminal/sequences.txt
    cat ~/.cache/ags/user/generated/terminal/sequences.txt
end

alias py=python
alias tmux="tmux -u"
alias snvim="sudo -E -s nvim"
alias ls="eza"
alias l="eza -bghHliS"
alias tree="eza -TL 2"
alias cat="bat"
alias find="fd"
alias cloc="tokei"
alias scrcpy="scrcpy --render-driver=opengl"
alias wisdom="fortune ~/.config/fortune/showerthoughts | cowsay | lolcat"
alias search="rg --color=always --line-number --no-heading \"\" | fzf --ansi --phony --query \"\" --bind \"change:reload(rg --color=always --line-number --no-heading {q} || true)\""
function mkcd
    mkdir -p $argv[1]
    cd $argv[1]
end
'';
  };
  environment.systemPackages = with pkgs; [
    nushell
    home-manager
  ];
}
