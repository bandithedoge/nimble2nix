{
  inputs = {
    nimble2nix.url = "github:bandithedoge/nimble2nix";
  };

  outputs = {
    self,
    nimble2nix,
    ...
  } @ inputs:
    nimble2nix.buildNimblePackage {
      pname = "example_package";
      version = "0.1";
      src = ./.;
    };
}
