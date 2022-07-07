version = "0.1.0"
author = "bandithedoge"
description = "A new awesome nimble package"
license = "MIT"
srcDir = "src"
installExt = @["nim"]
bin = @["example_package"]

requires "nim >= 1.6.6"

# A package from nimble.directory
requires "jsony"

# A package with its own dependencies
requires "pkginfo"

# A package with extra non-Nim dependencies (see `flake.lock`)
requires "sdl2"

# A package from a specific git branch
requires "https://github.com/yyoncho/asynctools#non-blocking"

# A task that requires extra dependencies
task fetch, "Check neofetch output":
  exec "neofetch"
