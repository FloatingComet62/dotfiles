{ config, pkgs, unstable, ... }:

{
  services.ollama.package = unstable.ollama;
  services.ollama = {
    enable = true;
    acceleration = "cuda";
  };
}
