import ./distros
import osinfo/[types, linux]

block ubuntuOsRelase:
  var os = new OsInfo
  osRelease(os, UbuntuOsRelease)
  doAssert os.release == "20.10"
  doAssert os.codename == "groovy"

block centosOsRelease:
  var os = new OsInfo
  osRelease(os, CentOSOsRelease)
  doAssert os.release == "8"
  doAssert os.codename == ""

block redhatOsRelease:
  var os = new OsInfo
  readhatOsRelease(os, RedHatOsRelease)
  doAssert os.release == "8.4"
  doAssert os.codename == "Ootpa"

block debianOsRelease:
  var os = new OsInfo
  osRelease(os, DebianOsRelease)
  doAssert os.release == "10"
  doAssert os.codename == "buster"

block fedoraOsRelease:
  var os = new OsInfo
  fedoraCustomLogic(os, FedoraOsRelease)
  doAssert os.release == "17"
  doAssert os.codename == "Beefy Miracle"

block raspbian:
  var os = new OsInfo
  osRelease(os, RaspbianOsRelease)
  doAssert os.release == "10"
  doAssert os.codename == "buster"