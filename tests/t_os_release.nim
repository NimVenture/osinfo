import ./os_release
import osinfo/[linux]

block ubuntuOsRelase:
  # var os = new OsInfo
  # osRelease(os, UbuntuOsRelease)
  # doAssert os.release == "20.10"
  # doAssert os.codename == "groovy"
  doAssert extractOsRelease(UbuntuOsRelease) == ("Ubuntu", "20.10", "Groovy Gorilla")

block centosOsRelease:
  # var os = new OsInfo
  # osRelease(os, CentOSOsRelease)
  # doAssert os.release == "8"
  # doAssert os.codename == ""
  doAssert extractOsRelease(CentOSOsRelease) == ("CentOS Linux", "8", "Core")

block redhatOsRelease:
  # var os = new OsInfo
  # readhatOsRelease(os, RedHatOsRelease)
  # doAssert os.release == "8.4"
  # doAssert os.codename == "Ootpa"
  doAssert extractOsRelease(RedHatOsRelease) == ("Red Hat Enterprise Linux", "8.4", "Ootpa")

block debianOsRelease:
  # var os = new OsInfo
  # osRelease(os, DebianOsRelease)
  # doAssert os.release == "10"
  # doAssert os.codename == "buster"
  doAssert extractOsRelease(DebianOsRelease) == ("Debian", "10", "buster")

block fedoraOsRelease:
  # var os = new OsInfo
  # fedoraOsRelease(os, FedoraOsRelease)
  # doAssert os.release == "17"
  # doAssert os.codename == "Beefy Miracle"
  doAssert extractOsRelease(FedoraOsRelease) == ("Fedora", "17", "Beefy Miracle")

block raspbian:
  # var os = new OsInfo
  # osRelease(os, RaspbianOsRelease)
  # doAssert os.release == "10"
  # doAssert os.codename == "buster"
  doAssert extractOsRelease(RaspbianOsRelease) == ("Raspbian GNU/Linux", "10", "buster")

block solaris:
  # var os = new OsInfo
  # osRelease(os, SolarisOsRelease)
  # doAssert os.release == "11.4"
  # doAssert os.codename == ""
  doAssert extractOsRelease(SolarisOsRelease) == ("Solaris", "11.4", "")

block arch:
  doAssert extractOsRelease(ArchOsRelease) == ("Arch Linux", "", "")

block zorin:
  doAssert extractOsRelease(ZorinOsRelease) == ("Zorin OS", "16.1", "")

block manjaro:
  doAssert extractOsRelease(ManjaroOsRelease) == ("Manjaro Linux", "", "")

block linuxmint:
  doAssert extractOsRelease(MintOsRelease) == ("Linux Mint", "20", "Ulyana")

block neon:
  doAssert extractOsRelease(NeoonOsRelease) == ("KDE neon", "20200218", "")

block suse:
  doAssert extractOsRelease(SuseOsRelease) == ("openSUSE", "42.1", "")

block freebsd:
  doAssert extractOsRelease(FreeBSD) == ("FreeBSD", "12.2", "")

block dragonfly:
  doAssert extractOsRelease(DragonFlyOsRelease) == ("DragonFly BSD", "x.y.z", "")

block netbsd:
  doAssert extractOsRelease(NetBSDOsRelease) == ("NetBSD", "9.1", "")

block aix:
  doAssert extractOsRelease(AIXOsRelease) == ("AIX", "7.2", "")

block openbsd:
  doAssert extractOsRelease(OpenBSDOsRelease) == ("OpenBSD", "6.9", "")

block amazon:
  doAssert extractOsRelease(AmazonOsRelease) == ("Amazon Linux", "2", "")

block alpine:
  doAssert extractOsRelease(AlpineOsRelease) == ("Alpine Linux", "3.14.0", "")