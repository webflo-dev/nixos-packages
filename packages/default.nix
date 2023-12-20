{ pkgs, ... }:
let
  fonts-apple = pkgs.callPackage ./fonts/apple.nix { };
  fonts-luciole = pkgs.callPackage ./fonts/luciole.nix { };
in
{
  font-sf-pro = fonts-apple.sf-pro;
  font-sf-mono = fonts-apple.sf-mono;
  font-new-york = fonts-apple.new-york;
  font-luciole = fonts-luciole.luciole;
}
