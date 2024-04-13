import std/[strutils]
import tinyre

proc centosCustomLogic(file: string) =
  var releaseRegex = re"release ([^\s]+)"
  var codenameRegex = re"\(([^\)]+)\)"
  var release = file.match(releaseRegex)
  echo release
#   if release.len == 2: os.release = release[1]
  var codename = file.match(codenameRegex)
  echo codename.len
#   codename.len == 2 os.codename = codename[1]


when isMainModule:
  const RedHat = """
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
  centosCustomLogic(RedHat)
  const CentOS = """
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
  centosCustomLogic(CentOS)