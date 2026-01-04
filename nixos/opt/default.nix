{ opt, ... }:
{
  imports =
    (if opt.nvidia then [ ./nvidia.nix ] else []) ++
    (if opt.llm then [ ./llm.nix ] else []);
}
