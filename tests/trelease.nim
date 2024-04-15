import ./lsb_release
import osinfo/[types, linux]

block ubuntuRelase:
  doAssert extractRelease(UbuntuRelease) == ("Ubuntu", "20.04", "focal")

block centosRelease:
  doAssert extractRelease(CentOSRelease) == ("CentOS Linux", "1191.1.8", "Core")

block redhatRelease:
  doAssert extractRelease(RedHatRelease) == ("Red Hat Enterprise Linux", "5.8", "Ootpa")

block suseRelease:
  echo extractRelease(SuseRelease)

block debianRelease:
  doAssert extractRelease(DebianRelease) == ("Debian", "10.9", "buster")

block dragonflyRelease:
  doAssert extractRelease(DragonFlyRelease) == ("DragonFly", "6.2.0.1", "")

block solarisRelease:
  echo extractRelease(SolarisRelease)

block gentooRelease:
  echo extractRelease(GentooRelease)

block slackwareRelease:
  doAssert extractRelease(SlackwareRelease) == ("Slackware", "15.0", "")

block manjaroRelease:
  echo extractRelease(ManjaroRelease)

block manjaroLsbRelease:
  doAssert extractRelease(ManjaroLsbRelease) == ("Manjaro Linux", "15.12", "Capella")

block fedoraServerRelease:
  doAssert extractRelease(FedoraServerRelease) == ("Fedora Server", "43", "Thirty Four")

block voidLinuxRelease:
  echo extractRelease(VoidLinuxRelease)

block voidLinuxLsbRelease:
  doAssert extractRelease(VoidLinuxLsbRelease) == ("Void Linux", "20210607", "Michel")

block elementaryOSRelease:
  doAssert extractRelease(ElementaryOSRelease) == ("elementary OS", "6.0", "odin")

block neonRelease:
  doAssert extractRelease(NeoonRelease) == ("KDE neon", "20.04", "focal")

block mintRelease:
  doAssert extractRelease(MintRelease) == ("Linux Mint", "20.2", "uma")

block archRelease:
  doAssert extractRelease(ArchRelease) == ("Arch Linux", "rolling", "")
