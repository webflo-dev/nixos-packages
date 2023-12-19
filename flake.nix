{
  description = "Apple fonts";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs";
  };

  outputs = { self, nixpkgs, ... }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};

      fonts-apple = import ./packages/fonts/apple { inherit pkgs; };
      fonts-luciole = import ./packages/fonts/luciole { inherit pkgs; };
    in
    {
      packages.${system} = fonts-apple // fonts-luciole;
      defaultPackage.${system} = fonts-luciole.luciole;
    };
}
