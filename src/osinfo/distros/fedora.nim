import std/[strutils]
import tinyre

proc fedoraCustomLogic(file: string) =
  var releaseRegex = re"release (..)"
  var codenameRegex = re"\((.*)\)"

  var release = file.match(releaseRegex)
  echo release
#   if release.len == 2: os.release = release[1]
  var codename = file.match(codenameRegex)
  echo codename.len

when isMainModule:

  const Fedora = """
    NAME=Fedora
    VERSION="17 (Beefy Miracle)"
    ID=fedora
    VERSION_ID=17
    PRETTY_NAME="Fedora 17 (Beefy Miracle)"
    ANSI_COLOR="0;34"
    CPE_NAME="cpe:/o:fedoraproject:fedora:17"
    HOME_URL="https://fedoraproject.org/"
    BUG_REPORT_URL="https://bugzilla.redhat.com/"
  """.unindent
  fedoraCustomLogic(Fedora)