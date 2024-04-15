import ./os_release
import osinfo/[linux]

block ubuntuOsRelase:
  # var os = new OsInfo
  # osRelease(os, UbuntuOsRelease)
  # doAssert os.release == "20.10"
  # doAssert os.codename == "groovy"
  doAssert extractOsRelase(UbuntuOsRelease) == ("Ubuntu", "20.10", "Groovy Gorilla")

block centosOsRelease:
  # var os = new OsInfo
  # osRelease(os, CentOSOsRelease)
  # doAssert os.release == "8"
  # doAssert os.codename == ""
  doAssert extractOsRelase(CentOSOsRelease) == ("CentOS Linux", "8", "Core")

block redhatOsRelease:
  # var os = new OsInfo
  # readhatOsRelease(os, RedHatOsRelease)
  # doAssert os.release == "8.4"
  # doAssert os.codename == "Ootpa"
  doAssert extractOsRelase(RedHatOsRelease) == ("Red Hat Enterprise Linux", "8.4", "Ootpa")

block debianOsRelease:
  # var os = new OsInfo
  # osRelease(os, DebianOsRelease)
  # doAssert os.release == "10"
  # doAssert os.codename == "buster"
  doAssert extractOsRelase(DebianOsRelease) == ("Debian", "10", "buster")

block fedoraOsRelease:
  # var os = new OsInfo
  # fedoraOsRelease(os, FedoraOsRelease)
  # doAssert os.release == "17"
  # doAssert os.codename == "Beefy Miracle"
  doAssert extractOsRelase(FedoraOsRelease) == ("Fedora", "17", "Beefy Miracle")

block raspbian:
  # var os = new OsInfo
  # osRelease(os, RaspbianOsRelease)
  # doAssert os.release == "10"
  # doAssert os.codename == "buster"
  doAssert extractOsRelase(RaspbianOsRelease) == ("Raspbian GNU/Linux", "10", "buster")

block solaris:
  # var os = new OsInfo
  # osRelease(os, SolarisOsRelease)
  # doAssert os.release == "11.4"
  # doAssert os.codename == ""
  doAssert extractOsRelase(SolarisOsRelease) == ("Solaris", "11.4", "")

block arch:
  doAssert extractOsRelase(ArchOsRelease) == ("Arch Linux", "", "")