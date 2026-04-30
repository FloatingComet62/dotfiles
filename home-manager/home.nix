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
  ];

  home.file = {
    ".bashrc".text = ''
      bash_starship_init_code=$(starship init bash)
      STARSHIP_DEV_MODE=1
      eval "$bash_starship_init_code"
    '';
  };
  home.sessionVariables = {
    EDITOR = "nvim";
  };
  programs.home-manager.enable = true;
}
