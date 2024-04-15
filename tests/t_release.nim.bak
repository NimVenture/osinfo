import ./lsb_release
import osinfo/[types, lsb_release]

block ubuntuRelase:
  var os = new OsInfo
  ubuntuLsbRelease(os, UbuntuRelease)
  doAssert os.release == "20.04"
  doAssert os.codename == "focal"

block centosRelease:
  var os = new OsInfo
  centosLsbRelease(os, CentOSRelease)
  doAssert os.release == "8.1.1911"
  doAssert os.codename == ""

block redhatRelease:
  var os = new OsInfo
  redhatLsbRelease(os, RedHatRelease)
  doAssert os.release == "8.5"
  doAssert os.codename == "Ootpa"

block suseRelease:
  var os = new OsInfo
  suseLsbRelease(os, SuseRelease)
  doAssert os.release == "42.1"
  doAssert os.codename == "Malachite"

block debianRelease:
  var os = new OsInfo
  ubuntuLsbRelease(os, DebianRelease)
  doAssert os.release == "10.9"
  doAssert os.codename == "buster"
