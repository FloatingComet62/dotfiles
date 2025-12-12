{ nvidia, llm, ... }:
{
  imports =
    (if nvidia then [
      ./nvidia.nix
    ] else []) ++ (if llm then [
      ./llm.nix
    ] else []);
}
