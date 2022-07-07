version       = "0.1.0"
author        = "bandithedoge"
description   = "A new awesome nimble package"
license       = "MIT"
srcDir        = "src"
installExt    = @["nim"]
bin           = @["example_package"]

requires "nim >= 1.6.6"

requires "jsony"

# A package with its own dependencies
requires "pkginfo"

# Specific git branch
requires "https://github.com/yyoncho/asynctools#non-blocking"
