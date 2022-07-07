{pkgs}: {
  pname,
  version,
  name ? "${pname}-${version}",
  src,
  deps ? src + "/nimble2nix.json",
  buildInputs ? [],
  nativeBuildInputs ? [],
}:
pkgs.nimPackages.buildNimPackage {
  inherit name src nativeBuildInputs;
  buildInputs =
    buildInputs
    ++ (pkgs.lib.mapAttrsToList
      (name: src:
        pkgs.fetchgit {
          inherit (src) url rev sha256 fetchSubmodules;
        }) (pkgs.lib.importJSON deps));
}
