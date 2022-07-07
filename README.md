# Painless Nimble dependencies in Nix derivations

## Usage

Install and run `nimble2nix` in your Nimble package's directory:

```bash
nix-env -iA nixpkgs.fetchgit --arg url "https://github.com/bandithedoge/nimble2nix"
nimble2nix .
```

This will generate a `nimble2nix.json` file. Create a nix expression that imports this repo's overlay and calls `buildNimblePackage`:

```nix
let
  pkgs = import <nixpkgs> {
    overlays = [
      ((builtins.fetchGit {
        url = "https://github.com/bandithedoge/nimble2nix";
      }) + "/overlay.nix")
    ];
  };
in pkgs.buildNimblePackage {
  pname = "my_package";
  version = "0.1";
  src = ./.;
}
```

This is only the bare minimum required to build a package. See [`example_package/flake.nix`](example_package/flake.nix) for a working example.

## TODO

- [ ] Development shells
- [ ] Build phase customization
- [ ] Package overrides
