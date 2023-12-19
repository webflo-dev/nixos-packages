{
  description = "Apple fonts";

  outputs = { nixpkgs, ... }:
    {
      packages = import ./packages nixpkgs.legacyPackages."x86_64-linux";
    };
}

