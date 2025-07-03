{ config, pkgs, ... }:
let unstable = import <nixos-unstable> { config.allowUnfree = true; };
in {
  imports =
    [
      ./hardware-configuration.nix
      <home-manager/nixos>
    ];

  hardware.graphics.enable = true;
  hardware.nvidia = {
    modesetting.enable = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
    nvidiaSettings = true;
    open = true;
  };
  boot.kernelParams = [ "acpi_backlight=none" ];
  boot.initrd.kernelModules = [ "nvidia" ];
  boot.loader = {
    grub = {
      enable = true;
      efiSupport = true;
      devices = ["nodev"];
      useOSProber = true;
      extraEntries = ''
      GRUB_SAVEDEFAULT=true
      menuentry "Windows" {
        insmod part_gpt
        insmod fat
        insmod search_fs_uuid
        insmod chain
        chainloader /EFI/Microsoft/Boot/bootmgfw.efi
      }
      menuentry "Reboot" {
        reboot
      }
      menuentry "Poweroff" {
        halt
      }
      '';
      default = "saved";
      theme = pkgs.stdenv.mkDerivation {
        pname = "distro-grub-themes";
        version = "3.1";
        src = pkgs.fetchFromGitHub {
          owner = "AdisonCavani";
          repo = "distro-grub-themes";
          rev = "v3.1";
          hash = "sha256-ZcoGbbOMDDwjLhsvs77C7G7vINQnprdfI37a9ccrmPs=";
        };
        installPhase = "cp -r customize/hp $out";
      };
    };
    efi.canTouchEfiVariables = true;
    systemd-boot.enable = false;
  };

  system.activationScripts.diff = {
    supportsDryActivation = true;
    text = ''
      ${pkgs.nvd}/bin/nvd --nix-bin-dir=${pkgs.nix}/bin diff /run/current-system "$systemConfig"
    '';
  };
  networking.hostName = "aargh-omen";
  networking.networkmanager.enable = true;

  time.timeZone = "Asia/Kolkata";
  time.hardwareClockInLocalTime = true;
  i18n.defaultLocale = "en_IN";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_IN";
    LC_IDENTIFICATION = "en_IN";
    LC_MEASUREMENT = "en_IN";
    LC_MONETARY = "en_IN";
    LC_NAME = "en_IN";
    LC_NUMERIC = "en_IN";
    LC_PAPER = "en_IN";
    LC_TELEPHONE = "en_IN";
    LC_TIME = "en_IN";
  };

  services.xserver.enable = true;
  services.xserver.videoDrivers = [ "nvidia" ];
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };
  services.printing.enable = true;
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };
  services.ollama = {
    enable = true;
    acceleration = "cuda";
  };
  users.users.aargh = {
    isNormalUser = true;
    description = "Aargh";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
    shell = pkgs.fish;
  };
  programs.fish.enable = true;
  home-manager.users.aargh = { pkgs, ... }: {
    programs.firefox.enable = true;
    home.stateVersion = "25.05";
  };
  home-manager.backupFileExtension = "hm-backup";

  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.cudaSupport = true;
  nix.settings.experimental-features = "nix-command flakes";

  # $ nix search wget
  environment.systemPackages = with pkgs; [
    fastfetch
    vim
    wget
    git
    nmap
    dust
    vscode
    discord
    localsend
    bitwarden
    gnome-tweaks
    jetbrains.pycharm-professional
    jetbrains.clion
    gnome-tweaks
    unstable.neovim
    home-manager
    zoxide
    starship
    tmux
    cmake
    gcc
    cargo
    python311
    linuxPackages.nvidia_x11
    unstable.cudaPackages.cuda_cudart
    unstable.cudaPackages.cudatoolkit
  ];
  #fuck - located here for quick navigation
  environment.sessionVariables = {
    CUDA_HOME = "${pkgs.cudatoolkit}";
    CUDA_PATH = "${pkgs.cudatoolkit}";
    LD_LIBRARY_PATH = "${pkgs.linuxPackages.nvidia_x11}/lib";
  };

  services.openssh.enable = true;
  services.flatpak.enable = true;
  services.mongodb = {
    enable = true;
    bind_ip = "127.0.0.1";
    package = pkgs.mongodb;
  };

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [ 53317 ];
  networking.firewall.allowedUDPPorts = [ 53317 ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?

}
