import ./distros
import osinfo/[types, linux]

block ubuntuRelase:
  var os = new OsInfo
  ubuntuCustomLogic(os, UbuntuRelease)
  doAssert os.release == "20.04"
  doAssert os.codename == "focal"

block centosRelease:
  var os = new OsInfo
  centosCustomLogic(os, CentOSRelease)
  doAssert os.release == "8.1.1911"
  doAssert os.codename == ""

block redhatRelease:
  var os = new OsInfo
  redhatCustomLogic(os, RedHatRelease)
  doAssert os.release == "8.5"
  doAssert os.codename == "Ootpa"

block suseRelease:
  var os = new OsInfo
  suseCustomLogic(os, SuseRelease)
  doAssert os.release == "42.1"
  doAssert os.codename == "Malachite"

block debianRelease:
  var os = new OsInfo
  ubuntuCustomLogic(os, DebianRelease)
  doAssert os.release == "10.9"
  doAssert os.codename == "buster"
