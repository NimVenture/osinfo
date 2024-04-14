import std/[strutils]
import tinyre

proc ubuntuCustomLogic(file: string) =
  var releaseRegex = re"Version:\s(..)"
  var codenameRegex = re"Codename:\s(..)"

  var release = file.match(releaseRegex)
  echo release
#   if release.len == 2: os.release = release[1]
  var codename = file.match(codenameRegex)
  echo codename.len
