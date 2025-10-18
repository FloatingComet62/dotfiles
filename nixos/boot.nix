{ config, pkgs, ... }:
{
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
        set root=(hd0,gpt1)
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
        pname = "space-isolation";
        version = "0.2";
        src = pkgs.fetchFromGitHub {
          owner = "callmenoodles";
          repo = "space-isolation";
          rev = "v0.2.0";
          hash = "sha256:180796bqzpcwcbk2hlwz2r0vw58crnvhss1hrc7rzp2s8y3zhf0w";
        };
        installPhase = "cp -r 1920x1080 $out";
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
}
