pkgs: {
  fonts = {
    apple = pkgs.callPackage ./fonts/apple { };
    luciole = pkgs.callPackage ./fonts/luciole { };
  };
}
