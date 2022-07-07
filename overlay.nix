final: prev: {
  nimble2nix = prev.callPackage ./default.nix {};
  buildNimblePackage = import ./buildNimblePackage.nix {pkgs = prev;};
}
