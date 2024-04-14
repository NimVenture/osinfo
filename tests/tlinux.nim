import ./distros
import osinfo/[types, linux]

block ubuntuRelase:
  var os = new OsInfo
  ubuntuCustomLogic(os, UbuntuRelease)
  doAssert os.release == "20.04"
  doAssert os.codename == "focal"

block ubuntuOsRelase:
  var os = new OsInfo
  osRelease(os, UbuntuOsRelease)
  doAssert os.release == "20.10"
  doAssert os.codename == "groovy"

block centosRelease:
  var os = new OsInfo
  centosCustomLogic(os, CentOSRelease)
  doAssert os.release == "8.1.1911"
  doAssert os.codename == ""

block centosOsRelease:
  var os = new OsInfo
  osRelease(os, CentOSOsRelease)
  doAssert os.release == "8"
  doAssert os.codename == ""

block redhatRelease:
  var os = new OsInfo
  redhatCustomLogic(os, RedHatRelease)
  doAssert os.release == "8.5"
  doAssert os.codename == "Ootpa"

block redhatOsRelease:
  var os = new OsInfo
  readhatOsRelease(os, RedHatOsRelease)
  doAssert os.release == "8.4"
  doAssert os.codename == "Ootpa"

block suseRelease:
  var os = new OsInfo
  suseCustomLogic(os, SuseRelease)
  doAssert os.release == "42.1"
  doAssert os.codename == "Malachite"

block debian:
  var os = new OsInfo
  debianCustomLogic(os, Debian)
  doAssert os.release == "10"
  doAssert os.codename == "buster"

block fedora:
  var os = new OsInfo
  fedoraCustomLogic(os, Fedora)
  doAssert os.release == "17"
  doAssert os.codename == "Beefy Miracle"

block raspbian:
  var os = new OsInfo
  osRelease(os, RaspbianOsRelease)
  doAssert os.release == "10"
  doAssert os.codename == "buster"