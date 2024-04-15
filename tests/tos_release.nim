import ./os_release
import osinfo/[linux]

block ubuntuOsRelase:
  doAssert extractOsRelease(UbuntuOsRelease) == ("Ubuntu", "20.10", "groovy")

block centosOsRelease:
  doAssert extractOsRelease(CentOSOsRelease) == ("CentOS Linux", "8", "Core")

block redhatOsRelease:
  doAssert extractOsRelease(RedHatOsRelease) == ("Red Hat Enterprise Linux", "8.4", "Ootpa")

block debianOsRelease:
  doAssert extractOsRelease(DebianOsRelease) == ("Debian", "10", "buster")

block fedoraOsRelease:
  doAssert extractOsRelease(FedoraOsRelease) == ("Fedora", "17", "Beefy Miracle")

block raspbian:
  doAssert extractOsRelease(RaspbianOsRelease) == ("Raspbian GNU/Linux", "10", "buster")

block solaris:
  doAssert extractOsRelease(SolarisOsRelease) == ("Solaris", "11.4", "")

block arch:
  doAssert extractOsRelease(ArchOsRelease) == ("Arch Linux", "", "")

block zorin:
  doAssert extractOsRelease(ZorinOsRelease) == ("Zorin OS", "16.1", "")

block manjaro:
  doAssert extractOsRelease(ManjaroOsRelease) == ("Manjaro Linux", "21.0", "")

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

block gentoo:
  doAssert extractOsRelease(GentooOsRelease) == ("Gentoo Linux", "2.9", "")

block voidLinux:
  doAssert extractOsRelease(VoidLinuxOsRelease) == ("Void Linux", "", "")

block almalinux:
  doAssert extractOsRelease(AlmaLinuxOsRelease) == ("AlmaLinux", "9.1", "Lime Lynx")

block antergos:
  doAssert extractOsRelease(AntergosOsRelease) == ("Antergos Linux", "18.11-ISO-Rolling", "")

block slackware:
  doAssert extractOsRelease(SlackwareOsRelease) == ("Slackware", "14.2", "")
