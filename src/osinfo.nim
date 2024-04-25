import std/[os, strutils]
import osinfo/types

when defined(windows):
  import osinfo/win
elif defined(macox) or defined(macosx):
  import osinfo/darwin
else:
  import osinfo/darwin
  import osinfo/posix
  import osinfo/linux


proc getOsInfo*(): OsInfo =
  result = new OsInfo
  when defined(windows):
    let info = win.getOsInfo()
    result.os = "Windows"
    result.distro = info.version
    result.edition = info.edition
    result.release = $info.buildNumber
  elif defined(macox) or defined(macosx):
    var unix_info: Utsname
    if uname(unix_info) != 0:
      raiseOSError(osLastError())
    let osInfo = getDarwinOsInfo($unix_info.release)
    result.os = osInfo[0]
    result.release = osInfo[1]
    result.codename = osInfo[2]
  else:
    # bsd, haiku, linux
    var unix_info: Utsname
    if uname(unix_info) != 0:
      raiseOSError(osLastError())
    template commonInfo(info: Utsname) =
      result.os = $info.sysname
      # result.distro = $info.sysname
      result.release = $info.version
    let sysname = $unix_info.sysname
    case sysname
      of "Linux":
        let info = getLinuxOsInfo()
        result.os = "Linux"
        result.distro = info[0]
        result.release = info[1]
        result.codename = info[2]
      of "FreeBSD", "DragonFly", "OpenBSD", "NetBSD", "Solaris",
          "SunOS", "AIX":
        let info = getLinuxOsInfo()
        result.os = sysname
        # result.distro = info[0]
        result.release = info[1]
        result.codename = info[2]
      of "Darwin":
        let osInfo = getDarwinOsInfo($unix_info.release)
        result.os = osInfo[0]
        result.release = osInfo[1]
        result.codename = osInfo[2]

      of "Haiku":
        # System Name: Haiku
        # Node Name: haiku
        # Release: R1/beta1
        # Version: hrev55220+1
        # Machine: x86_64
        # cat /boot/system/system/build_info
        # revision: 12345
        # arch: x86_64
        # build_date: Mon Nov 15 12:34:56 UTC 2021
        # haiku_revisions: ab12cd34e5fg
        # vendor: Haiku, Inc.
        unix_info.commonInfo

      of "OS/390":
        unix_info.commonInfo
      of "MVS":
        unix_info.commonInfo
      of "z/OS":
        unix_info.commonInfo
      else:
        unix_info.commonInfo

when isMainModule:
  echo getOsInfo()
