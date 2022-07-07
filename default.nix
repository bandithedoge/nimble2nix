{pkgs}:
pkgs.nimPackages.buildNimPackage {
  pname = "nimble2nix";
  version = "0.1";
  src = ./.;

  nimBinOnly = true;

  nativeBuildInputs = with pkgs; [
    makeWrapper
  ];

  postInstall = ''
    wrapProgram $out/bin/nimble2nix --prefix PATH : ${
      pkgs.lib.makeBinPath (with pkgs; [
        nix-prefetch-scripts
      ])
    }
  '';
}
