{ opt, ... }:
{
  imports =
    (if opt.nvidia then [ ./nvidia.nix ] else []) ++
    (if opt.tailscale then [ ./tailscale.nix ] else []) ++
    (if opt.vm then [ ./vm.nix ] else []) ++
    (if opt.llm then [ ./llm.nix ] else []);
}
