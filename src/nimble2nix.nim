import std/[
  json,
  os,
  osproc,
  strformat,
  strutils,
  tables,
]

when isMainModule:
  let
    args = commandLineParams()
    path = if args.len() == 0: "." else: args[0]

  setCurrentDir(path)

  let isLocal =
    if dirExists "nimbledeps": true
    else: false

  let code = execCmd "nimble install --depsOnly --localdeps --accept"

  if code != 0:
    if not isLocal:
      removeDir "nimbledeps"
    quit(code)

  var packages: Table[string, JsonNode]

  for package in walkDir "nimbledeps/pkgs":
    var name = package.path
    removePrefix(name, "nimbledeps/pkgs/")

    echo &"Prefetching {name}..."

    let
      json = parseJson readFile(package.path & "/nimblemeta.json")
      url = json["url"].getStr()
      rev = json{"vcsRevision"}.getStr()
      prefetch = execCmdEx(
          &"nix-prefetch-git --fetch-submodules --url {url}" &
            (if rev != "": &" --rev {rev}" else: ""),
          options = {poUsePath}
        )

    packages[name] = %parseJson(prefetch.output)

  echo "Writing result..."
  writeFile("nimble2nix.json", pretty(%packages))

  if not isLocal:
    removeDir "nimbledeps"
