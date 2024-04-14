import std/[strutils]
import tinyre

proc ubuntuCustomLogic(file: string) =
  var releaseRegex = re"Version:\s(..)"
  var codenameRegex = re"Codename:\s(..)"

  var release = file.match(releaseRegex)
  echo release
#   if release.len == 2: os.release = release[1]
  var codename = file.match(codenameRegex)
  echo codename.len

# cat /etc/lsb-release
# DISTRIB_ID=Ubuntu
# DISTRIB_RELEASE=14.04
# DISTRIB_CODENAME=trusty
# DISTRIB_DESCRIPTION="Ubuntu 14.04 LTS"

# cat /etc/os-release
# NAME="Ubuntu"
# VERSION="13.10, Saucy Salamander"
# ID=ubuntu
# ID_LIKE=debian
# PRETTY_NAME="Ubuntu 13.10"
# VERSION_ID="13.10"
# HOME_URL="http://www.ubuntu.com/"
# SUPPORT_URL="http://help.ubuntu.com/"
# BUG_REPORT_URL="http://bugs.launchpad.net/ubuntu/"