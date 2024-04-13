import std/[strutils]
import tinyre

proc ubuntuCustomLogic(file: string) =
  var releaseRegex = re"distrib_release=(.*)"
  var codenameRegex = re"distrib_codename=(.*)"

  var release = file.match(releaseRegex)
  echo release
#   if release.len == 2: os.release = release[1]
  var codename = file.match(codenameRegex)
  echo codename.len

when isMainModule:
  const Ubuntu = """
    Origin: Ubuntu
    Label: Ubuntu
    Suite: focal
    Version: 20.04
    Codename: Focal Fossa
    Date: Thu, 23 Apr 2020 12:00:00 UTC
    Architectures: amd64 arm64 armhf i386 ppc64el s390x
    Components: main restricted universe multiverse
    Description: Ubuntu 20.04 LTS
    """.unindent
  ubuntuCustomLogic(Ubuntu)
