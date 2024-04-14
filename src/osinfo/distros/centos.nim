import std/[strutils]
import tinyre

proc centosCustomLogic(file: string) =
  var releaseRegex = re"release ([^\s]+)"
  var codenameRegex = re"\(([^\)]+)\)"
  var release = file.match(releaseRegex)
  echo release
#   if release.len == 2: os.release = release[1]
  var codename = file.match(codenameRegex)
  echo codename.len
#   codename.len == 2 os.codename = codename[1]
