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
zoxide init --cmd cd fish | source
starship init fish | source
if test -f ~/.cache/ags/user/generated/terminal/sequences.txt
    cat ~/.cache/ags/user/generated/terminal/sequences.txt
end

function mkcd
    mkdir -p $argv[1]
    cd $argv[1]
end
'';
    shellAliases = {
      py="python";
      tmux="tmux -u";
      snvim="sudo -E -s nvim";
      ls="eza -hli";
      cat="bat";
      find="fd";
      cloc="tokei";
      scrcpy="scrcpy --render-driver=opengl";
      wisdom="fortune ~/.config/fortune/showerthoughts | cowsay | lolcat";
      search="rg --color=always --line-number --no-heading \"\" | fzf --ansi --phony --query \"\" --bind \"change:reload(rg --color=always --line-number --no-heading {q} || true)\"";
    };
  };
  environment.systemPackages = with pkgs; [
    nushell
    home-manager
  ];
}
