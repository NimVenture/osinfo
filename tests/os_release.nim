import std/strutils

# redhat, centos, fedora, ubuntu release file share same format.

const FedoraOsRelease* = """
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

const AlpineOsRelease* = """
  NAME="Alpine Linux"
  ID=alpine
  VERSION_ID=3.14.0
  PRETTY_NAME="Alpine Linux v3.14"
  HOME_URL="https://alpinelinux.org/"
  BUG_REPORT_URL="https://bugs.alpinelinux.org/"
  """.unindent

# cat /etc/lsb-release
const AmazonOsRelease* = """
  NAME="Amazon Linux"
  VERSION="2"
  ID="amzn"
  ID_LIKE="centos rhel"
  VERSION_ID="2"
  PRETTY_NAME="Amazon Linux 2"
  ANSI_COLOR="0;33"
  CPE_NAME="cpe:2.3:o:amazon:amazon_linux:2"
  HOME_URL="https://aws.amazon.com/amazon-linux-2/"
  BUG_REPORT_URL="https://aws.amazon.com/amazon-linux-2/"
  Amazon Linux release 2 (Karoo)
  """.unindent

const ArchOsRelease* = """
  NAME="Arch Linux"
  PRETTY_NAME="Arch Linux"
  ID=arch
  BUILD_ID=rolling
  ANSI_COLOR="38;2;23;147;209"
  HOME_URL="https://archlinux.org/"
  DOCUMENTATION_URL="https://wiki.archlinux.org/"
  SUPPORT_URL="https://bbs.archlinux.org/"
  BUG_REPORT_URL="https://gitlab.archlinux.org/groups/archlinux/-/issues"
  PRIVACY_POLICY_URL="https://terms.archlinux.org/docs/privacy-policy/"
  LOGO=archlinux-logo
  """.unindent

# no lsb release, no code name
# cat /etc/lsb-release
const ZorinOsRelease* = """
  NAME="Zorin OS"
  VERSION="16.1"
  ID=zorin
  ID_LIKE=ubuntu
  VERSION_ID="16.1"
  PRETTY_NAME="Zorin OS 16.1"
  HOME_URL="https://zorinos.com"
  SUPPORT_URL="https://zorinos.com"
  BUG_REPORT_URL="https://zorinos.com"
  PRIVACY_POLICY_URL="https://zorinos.com"
  """.unindent

# no lsb release, no code name
# cat /etc/lsb-release
const ManjaroOsRelease* = """
  NAME=Manjaro Linux
  ID=manjaro
  ID_LIKE=arch
  PRETTY_NAME="Manjaro Linux"
  ANSI_COLOR="32;1"
  HOME_URL="https://manjaro.org/"
  SUPPORT_URL="https://forum.manjaro.org/"
  BUG_REPORT_URL="https://bugs.manjaro.org/"
  LOGO=manjaro

  VERSION="21.0"
  VERSION_ID=21.0
  BUILD_ID="GNOME-2021.07"
  """.unindent

const MintOsRelease* = """
  NAME="Linux Mint"
  VERSION="20 (Ulyana)"
  ID=linuxmint
  ID_LIKE=ubuntu
  PRETTY_NAME="Linux Mint 20"
  VERSION_ID="20"
  HOME_URL="https://www.linuxmint.com/"
  SUPPORT_URL="https://forums.linuxmint.com/"
  BUG_REPORT_URL="http://linuxmint-troubleshooting-guide.readthedocs.io/en/latest/"
  """.unindent

const NeoonOsRelease* = """
  NAME="KDE neon"
  VERSION="20200218"
  ID=kde-neon
  ID_LIKE=ubuntu
  VERSION_ID="20200218"
  PRETTY_NAME="KDE neon User Edition 20200218"
  ANSI_COLOR="0;31"
  HOME_URL="https://neon.kde.org/"
  SUPPORT_URL="https://forum.kde.org/viewforum.php?f=309"
  BUG_REPORT_URL="https://bugs.kde.org/"
  """.unindent

  # NAME="KDE neon"
  # VERSION="21.04"
  # ID=kde-neon
  # ID_LIKE=ubuntu
  # VERSION_ID="21.04"
  # PRETTY_NAME="KDE neon 21.04"
  # ...

const DebianOsRelease* = """
  PRETTY_NAME="Debian GNU/Linux 10 (buster)"
  NAME="Debian GNU/Linux"
  VERSION_ID="10"
  VERSION="10 (buster)"
  VERSION_CODENAME=buster
  ID=debian
  HOME_URL="https://www.debian.org/"
  SUPPORT_URL="https://www.debian.org/support"
  BUG_REPORT_URL="https://bugs.debian.org/"
  """.unindent

# The file /etc/SuSE-release has been marked as depreciated since openSUSE 13.1 and
# will no longer be present in openSUSE Leap 15.0. use /etc/os-release instead.
# https://en.opensuse.org/SDB:SUSE_and_openSUSE_Products_Version_Outputs

# cat /usr/lib/os-release
const SuseOsRelease* = """
  NAME="openSUSE Leap"
  VERSION="42.1"
  VERSION_ID="42.1"
  PRETTY_NAME="openSUSE Leap 42.1 (x86_64)"
  ID=opensuse
  ANSI_COLOR="0;32"
  CPE_NAME="cpe:/o:opensuse:opensuse:42.1"
  BUG_REPORT_URL="https://bugs.opensuse.org"
  HOME_URL="https://opensuse.org/"
  ID_LIKE="suse"
  """.unindent

const RedHatOsRelease* = """
  NAME="Red Hat Enterprise Linux"
  VERSION="8.4 (Ootpa)"
  ID="rhel"
  ID_LIKE="fedora"
  VERSION_ID="8.4"
  PLATFORM_ID="platform:el8"
  PRETTY_NAME="Red Hat Enterprise Linux 8.4 (Ootpa)"
  ANSI_COLOR="0;31"
  CPE_NAME="cpe:/o:redhat:enterprise_linux:8.4:GA"
  HOME_URL="https://www.redhat.com/"
  BUG_REPORT_URL="https://bugzilla.redhat.com/"
  REDHAT_BUGZILLA_PRODUCT="Red Hat Enterprise Linux 8"
  REDHAT_BUGZILLA_PRODUCT_VERSION=8.4
  REDHAT_SUPPORT_PRODUCT="Red Hat Enterprise Linux"
  REDHAT_SUPPORT_PRODUCT_VERSION="8.4"
  """.unindent

const CentOSOsRelease* = """
  NAME="CentOS Linux"
  VERSION="8 (Core)"
  ID="centos"
  ID_LIKE="rhel fedora"
  VERSION_ID="8"
  PLATFORM_ID="platform:el8"
  PRETTY_NAME="CentOS Linux 8 (Core)"
  ANSI_COLOR="0;31"
  CPE_NAME="cpe:/o:centos:centos:8"
  HOME_URL="https://www.centos.org/"
  BUG_REPORT_URL="https://bugs.centos.org/"
  
  CENTOS_MANTISBT_PROJECT="CentOS-8"
  CENTOS_MANTISBT_PROJECT_VERSION="8"
  REDHAT_SUPPORT_PRODUCT="centos"
  REDHAT_SUPPORT_PRODUCT_VERSION="8"
  """.unindent

  # /etc/os-release
const FreeBSD* = """
  NAME="FreeBSD"
  VERSION="12.2-RELEASE"
  ID=freebsd
  ID_LIKE=freebsd
  VERSION_ID=12.2
  PRETTY_NAME="FreeBSD 12.2-RELEASE"
  """.unindent

const DragonFlyOsRelease* = """
  NAME="DragonFly BSD"
  PRETTY_NAME="DragonFly BSD"
  VERSION="x.y.z"
  ID=dragonfly
  ID_LIKE=dragonfly-bugtracker
  HOME_URL="https://www.dragonflybsd.org/"
  SUPPORT_URL="https://www.dragonflybsd.org/support/"
  BUG_REPORT_URL="https://bugs.dragonflybsd.org/"
  """.unindent

# cat /etc/os-release
const NetBSDOsRelease* = """
  NAME="NetBSD"
  VERSION="9.1"
  ID=netbsd
  VERSION_ID=9.1
  PRETTY_NAME="NetBSD 9.1"
  HOME_URL="https://www.netbsd.org/"
  SUPPORT_URL="https://www.netbsd.org/support/"
  BUG_REPORT_URL="https://www.netbsd.org/support/"
  """.unindent

# cat /etc/os-release
const AIXOsRelease* = """
  NAME=AIX
  VERSION=7.2
  ID=aix
  PRETTY_NAME="AIX 7.2"
  HOME_URL="https://www.ibm.com/support/home/"
  SUPPORT_URL="https://www.ibm.com/support/home/"
  BUG_REPORT_URL="https://www.ibm.com/support/home/"
  """.unindent

const OpenBSDOsRelease* = """
  NAME=OpenBSD
  VERSION=6.9
  ID=openbsd
  PRETTY_NAME="OpenBSD 6.9"
  HOME_URL="https://www.openbsd.org/"
  SUPPORT_URL="https://www.openbsd.org/support.html"
  BUG_REPORT_URL="https://www.openbsd.org/report.html"
  """.unindent

const SolarisOsRelease* = """
  NAME="Solaris"
  VERSION="11.4"
  ID=solaris
  ID_LIKE=solaris
  PRETTY_NAME="Oracle Solaris 11.4"
  ANSI_COLOR="0;34"
  CPE_NAME= cpe:/o:oracle:solaris:11.4:1
  HOME_URL="https://www.oracle.com/solaris"
  SUPPORT_URL="https://www.oracle.com/solaris/support"
  BUG_REPORT_URL="https://www.oracle.com/solaris/support"
  """.unindent

# cat /etc/os-release
const UbuntuOsRelease* = """
  NAME="Ubuntu"
  VERSION="20.10 (Groovy Gorilla)"
  ID=ubuntu
  ID_LIKE=debian
  PRETTY_NAME="Ubuntu 20.10"
  VERSION_ID="20.10"
  HOME_URL="https://www.ubuntu.com/"
  SUPPORT_URL="https://help.ubuntu.com/"
  BUG_REPORT_URL="https://bugs.launchpad.net/ubuntu/"
  PRIVACY_POLICY_URL="https://www.ubuntu.com/legal/terms-and-policies/privacy-policy"
  VERSION_CODENAME=groovy
  UBUNTU_CODENAME=groovy
  """.unindent

# cat /etc/os-release
const RaspbianOsRelease* = """
  PRETTY_NAME="Raspbian GNU/Linux 10 (buster)"
  NAME="Raspbian GNU/Linux"
  VERSION_ID="10"
  VERSION="10 (buster)"
  VERSION_CODENAME=buster
  ID=raspbian
  ID_LIKE=debian
  HOME_URL="http://www.raspbian.org/"
  SUPPORT_URL="http://www.raspbian.org/RaspbianForums"
  BUG_REPORT_URL="http://www.raspbian.org/RaspbianBugs"
  """.unindent