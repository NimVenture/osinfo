import std/[strutils]
import tinyre

proc fedoraCustomLogic(file: string) =
  var releaseRegex = reU"VERSION_ID=(\d+\.\d+\.\d+|\d+)"
  var codenameRegex = re"\(([^\)]+)\)"

  var release = file.match(releaseRegex)
  echo release
#   if release.len == 2: os.release = release[1]
  var codename = file.match(codenameRegex)
  echo codename

