# Nix Channels
# nix-ld https://github.com/Mic92/nix-ld/archive/main.tar.gz
# nixos https://channels.nixos.org/nixos-24.11
# nixos-unstable https://nixos.org/channels/nixos-unstable
# home-manager https://github.com/nix-community/home-manager/archive/release-24.11.tar.gz

{ config, pkgs, ... }:
let
  unstable = import <nixos-unstable> {
    config = {
      allowUnfree = true;
    };
  };
in {
  imports = [
      ./hardware-configuration.nix
      <home-manager/nixos>
  ];
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

  networking.hostName = "nixos";
  networking.networkmanager.enable = true;
  networking.firewall = {
    allowedTCPPorts = [53317];
    allowedUDPPorts = [53317];
  };

  time.timeZone = "Asia/Kolkata";
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

  services.desktopManager.plasma6.enable = true;
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
  };

  services.printing.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  users.users.aargh = {
    isNormalUser = true;
    description = "aargh";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      kate
    ];
  };

  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = "nix-command flakes";

  # $ nix search <package>
  environment.systemPackages = with pkgs; [
    vim
    wget
    git
    unstable.neovim
    nmap
    dust
    ffmpeg
    rclone
    hyprpaper
    kdePackages.sddm-kcm
    vscode
    android-tools
  ];
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  time.hardwareClockInLocalTime = true;  
  programs.fish.enable = true;
  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
      stdenv.cc.cc.lib
      zlib
    ];
  };
  # services.seatd.enable = true;
  services.openssh.enable = true;
  services.flatpak.enable = true;
  system.stateVersion = "24.11";

}
