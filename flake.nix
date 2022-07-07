{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };
  outputs = {
    self,
    flake-utils,
    nixpkgs,
    ...
  } @ inputs:
    (flake-utils.lib.eachDefaultSystem (system: let
      pkgs = nixpkgs.legacyPackages.${system};
    in rec {
      defaultPackage = pkgs.callPackage ./default.nix {};
      packages = {
        nimble2nix = defaultPackage;
        buildNimblePackage = import ./buildNimblePackage.nix {inherit pkgs;};
      };
    }))
    // {
      overlay = final: prev: {
        nimble2nix = prev.callPackage ./default.nix {};
        buildNimblePackage = import ./buildNimblePackage.nix {pkgs = prev;};
      };
    };
}
