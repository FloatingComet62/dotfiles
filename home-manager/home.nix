{ config, lib, pkgs, symlinkRoot, username, ... }:
let
  inherit (config.lib.file) mkOutOfStoreSymlink;
  inherit (lib) flatten flip map mergeAttrsList;

  pipe = flip lib.pipe;
  flatMerge = pipe [flatten mergeAttrsList];

  toSrcFile = name: "${symlinkRoot}/${name}";
  link = pipe [toSrcFile mkOutOfStoreSymlink];

  linkFile = name: {${name}.source = link name;};
  linkDir = name: {
    ${name} = {
      source = link name;
      recursive = true;
    };
  };

  linkConfFiles = map linkFile;
  linkConfDirs = map linkDir;

  confFiles = linkConfFiles [
    "starship.toml"
  ];

  confDirs = linkConfDirs [
    "foot"
    "fortune"
    "hypr"
    "nvim"
    "quickshell"
    "tmux"
    "wofi"
    "yazi"
  ];

  links = flatMerge [confFiles confDirs];
in {
  xdg.configFile = links;

  home.username = username;
  home.homeDirectory = "/home/${username}";
  home.stateVersion = "25.05";
  home.packages = with pkgs; [
    devenv
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  home.file = {
    ".bashrc".text = ''
      bash_starship_init_code=$(starship init bash)
      STARSHIP_DEV_MODE=1
      eval "$bash_starship_init_code"
    '';
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };
  home.sessionVariables = {
    EDITOR = "nvim";
  };
  programs.home-manager.enable = true;
}
