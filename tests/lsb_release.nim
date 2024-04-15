import std/strutils

# redhat, centos, fedora, ubuntu release file share same format.

# cat /etc/fedora-release
# cat /etc/redhat-relase
const FedoraRelease* = """
  Fedora release 34 (Thirty Four)
  """.unindent

# cat /etc/alpine-release
const AlpineRelease* = """
3.14.1
""".unindent


# cat /etc/system-release
const AmazonRelease* = """
Amazon Linux release 2 (Karoo)
""".unindent


# no version, no code name
# /etr/arch-release could be empty
# cat /etc/lsb-release
const ArchRelease* = """
  DISTRIB_ID="Arch"
  DISTRIB_RELEASE="rolling"
  DISTRIB_DESCRIPTION="Arch Linux"
  """.unindent

# cat /etc/lsb-release
const MintRelease* = """
  LSB_VERSION=1.4
  DISTRIB_ID=LinuxMint
  DISTRIB_RELEASE=20.2
  DISTRIB_CODENAME=uma
  DISTRIB_DESCRIPTION="Linux Mint 20.2 Uma"
  """.unindent

# cat /etc/lsb-release
const NeoonRelease* = """
  LSB_VERSION=1.4
  DISTRIB_ID=Neon
  DISTRIB_RELEASE=20.04
  DISTRIB_CODENAME=focal
  DISTRIB_DESCRIPTION="KDE neon User Edition 20.04"
  """.unindent

const DebianRelease* = """
  DISTRIB_ID=Debian
  DISTRIB_RELEASE=10.9
  DISTRIB_CODENAME=buster
  DISTRIB_DESCRIPTION="Debian GNU/Linux 10.9 (buster)"
  """.unindent

# The file /etc/SuSE-release has been marked as depreciated since openSUSE 13.1 and
# will no longer be present in openSUSE Leap 15.0. use /etc/os-release instead.
# https://en.opensuse.org/SDB:SUSE_and_openSUSE_Products_Version_Outputs

# cat /etc/SuSE-release
const SuseRelease* = """
  openSUSE 42.1 (x86_64)
  VERSION = 42.1
  CODENAME = Malachite
  """.unindent

  # SUSE Linux Enterprise Server 10 (x86_64)
  # VERSION = 10
  # PATCHLEVEL = 4

# cat /etc/redhat-relase
const RedHatRelease* = """
  Red Hat Enterprise Linux release 8.5 (Ootpa)
  """.unindent
  # Red Hat Enterprise Linux release 8.0 Beta (Ootpa)

# cat /etc/redhat-release
# cat /etc/system-release
const CentOSRelease* = "CentOS Linux release 8.1.1911 (Core)"

# cat /etc/dragonfly-release
const DragonFlyRelease* = """
  DragonFly v6.2.0.1
  """.unindent

# /etc/lsb-release or /etc/redhat-release
const NetBSDRelease* = """
  DISTRIB_ID=NetBSD
  DISTRIB_RELEASE=9.2
  DISTRIB_CODENAME=cats
  DISTRIB_DESCRIPTION="NetBSD 9.2 (Cats)"
  """.unindent

# cat /etc/lsb-release
const AIXRelease* = """
  DISTRIB_ID=AIX
  DISTRIB_RELEASE=7.2
  DISTRIB_CODENAME=Sapphire
  DISTRIB_DESCRIPTION="IBM AIX 7.2 Sapphire"
  """.unindent

# /etc/version
const OpenBSDRelease* = """
  OpenBSD 7.0
  """.unindent

  # /etc/release
const SolarisRelease* = """
  Oracle Solaris 11.4 X86
  Copyright (c) 1983, 2021, Oracle and/or its affiliates. All rights reserved.
  Assembled 11 October 2021
  """.unindent

# cat /etc/lsb-release
const UbuntuRelease* = """
  DISTRIB_ID=Ubuntu
  DISTRIB_RELEASE=20.04
  DISTRIB_CODENAME=focal
  DISTRIB_DESCRIPTION="Ubuntu 20.04 LTS"
  """.unindent

# cat /etc/rpi-issue
const RaspbianIssue* = """
  Raspberry Pi 4 Model B
  Raspbian GNU/Linux 10 (buster)
  Kernel version 5.10.17-v7+
  """.unindent
