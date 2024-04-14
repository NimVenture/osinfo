import std/strutils

const Fedora* = """
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

const Alpine* = """
  NAME="Alpine Linux"
  ID=alpine
  VERSION_ID=3.14.0
  PRETTY_NAME="Alpine Linux v3.14"
  HOME_URL="https://alpinelinux.org/"
  BUG_REPORT_URL="https://bugs.alpinelinux.org/"
  """.unindent

const Amazon* = """
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

const Arch* = """
  NAME="Arch Linux"
  ID=arch
  PRETTY_NAME="Arch Linux"
  ANSI_COLOR="0;36"
  HOME_URL="https://www.archlinux.org"
  SUPPORT_URL="https://bbs.archlinux.org"
  BUG_REPORT_URL="https://bugs.archlinux.org"
  """.unindent

const Zorin* = """
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

const Manjaro* = """
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

const Mint* = """
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

const Raspbian* = """
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

  # var releaseRegex = /VERSION_ID="(.*)"/
  # var codenameRegex = /VERSION="[0-9] \((.*)\)"/
const Neoon* = """
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

const Debian* = """
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

const Suse* = """
  NAME="openSUSE Leap"
  VERSION="15.1"
  ID="opensuse-leap"
  ID_LIKE="suse opensuse"
  VERSION_ID="15.1"
  PRETTY_NAME="openSUSE Leap 15.1"
  ANSI_COLOR="0;32"
  HOME_URL="https://www.opensuse.org/"
  SUPPORT_URL="https://en.opensuse.org/Portal:Support"
  BUG_REPORT_URL="https://bugzilla.opensuse.org/"
  """

const RedHat* = """
  Red Hat Enterprise Linux release 8.4 (Ootpa)
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

const CentOS* = """
  CentOS Linux release 8.4.2105
  NAME="CentOS Linux"
  VERSION="8"
  ID="centos"
  ID_LIKE="rhel fedora"
  VERSION_ID="8"
  PLATFORM_ID="platform:el8"
  PRETTY_NAME="CentOS Linux 8.4.2105"
  ANSI_COLOR="0;31"
  CPE_NAME="cpe:/o:centos:centos:8"
  HOME_URL="https://www.centos.org/"
  BUG_REPORT_URL="https://bugs.centos.org/"
  CENTOS_MANTISBT_PROJECT="CentOS-8"
  CENTOS_MANTISBT_PROJECT_VERSION="8"
  REDHAT_SUPPORT_PRODUCT="CentOS"
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
  # /etc/dragonfly-release
const DragonFly* = """
  DragonFly v6.2.0.1
  """.unindent

  # /etc/lsb-release or /etc/redhat-release
const NetBSD* = """
  DISTRIB_ID=NetBSD
  DISTRIB_RELEASE=9.2
  DISTRIB_CODENAME=cats
  DISTRIB_DESCRIPTION="NetBSD 9.2 (Cats)"
  """.unindent

  # /etc/lsb-release
const AIX* = """
  DISTRIB_ID=AIX
  DISTRIB_RELEASE=7.2
  DISTRIB_CODENAME=Sapphire
  DISTRIB_DESCRIPTION="IBM AIX 7.2 Sapphire"
  """.unindent

  # /etc/version
const OpenBSD* = """
  OpenBSD 7.0
  """.unindent

  # /etc/release
const Solaris* = """
  Oracle Solaris 11.4 X86
  Copyright (c) 1983, 2021, Oracle and/or its affiliates. All rights reserved.
  Assembled 11 October 2021
  """.unindent