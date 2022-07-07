{pkgs ? import <nixpkgs> {}}: let
  buildNimblePackage = import ../buildNimblePackage.nix {inherit pkgs;};
in
  buildNimblePackage {
    pname = "example_package";
    version = "0.1";
    src = ./.;
  }
