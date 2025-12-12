{ config, inputs, system, ... }:
{
  environment.systemPackages = [
    inputs.zen-browser.packages."${system}".default
  ];
  xdg.mime = let
    value = let
      zen-browser = inputs.zen-browser.packages.${system}.default;
    in
      zen-browser.meta.desktopFileName;

    associations = builtins.listToAttrs (map (name: {
        inherit name value;
      }) [
        "application/x-extension-shtml"
        "application/x-extension-xhtml"
        "application/x-extension-html"
        "application/x-extension-xht"
        "application/x-extension-htm"
        "x-scheme-handler/unknown"
        "x-scheme-handler/mailto"
        "x-scheme-handler/chrome"
        "x-scheme-handler/about"
        "x-scheme-handler/https"
        "x-scheme-handler/http"
        "application/xhtml+xml"
        "application/json"
        "application/pdf"
        "text/plain"
        "text/html"
      ]);
  in {
    defaultApplications = associations;
  };
}
