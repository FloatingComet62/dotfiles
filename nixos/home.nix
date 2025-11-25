{ config, pkgs, username, ... }:
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

if status is-interactive
    set fish_greeting

    if not set -q TMUX
        tmux new-session -d -s "main" -c "~/dev"
        if not set -q VSCODE_PID
            tmux -u a
        end
    end
end

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

alias pamcan=pacman
alias py=python
alias tmux="tmux -u"
alias snvim="sudo -E -s nvim"
alias ls="eza"
alias wisdom="fortune ~/.config/fortune/showerthoughts | cowsay | lolcat"
function mkcd
    mkdir -p $argv[1]
    cd $argv[1]
end

set -x PKG_CONFIG_PATH $HOME/.local/lib/pkgconfig $HOME/.local/lib64/pkgconfig
set -x LD_LIBRARY_PATH $HOME/.local/lib $HOME/.local/lib64
set -U fish_user_paths /home/comet/.cargo/bin $fish_user_paths
set -U fish_user_paths /opt/android-sdk/cmdline-tools/latest/bin $fish_user_paths
set -U fish_user_paths /opt/android-sdk/platform-tools $fish_user_paths
set -U fish_user_paths /opt/android-sdk/emulator $fish_user_paths

set ANDROID_NDK_HOME /opt/android-ndk
set ANDROID_NDK_ROOT /opt/android-ndk
set ANDROID_HOME /opt/android-sdk
    '';
  };
  programs.firefox.enable = true;
  environment.systemPackages = with pkgs; [
    home-manager
  ];
}
