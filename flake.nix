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
    flake-utils.lib.eachDefaultSystem (
      system: let
        pkgs = nixpkgs.legacyPackages.${system};
      in {
        packages.${system}.default = pkgs.callPackage ./default.nix {};

        overlays.default = import ./overlay.nix {};

        buildNimblePackage = import ./buildNimblePackage.nix {inherit pkgs;};
      }
    );
}
