import std/[os, strutils]
import osinfo/types

when defined(windows):
  import osinfo/win
elif defined(macox) or defined(macosx):
  import osinfo/darwin
else:
  import osinfo/darwin
  import osinfo/posix


proc getOsInfo(): OsInfo =
  result = new OsInfo
  when defined(windows):
    let osvi = getVersionInfo()
    result.os = osvi.getOsInfo()
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
      result.os = "Linux"
      result.distro = $info.sysname
      result.release = $info.version
    let sysname = $unix_info.sysname
    case sysname
      of "Linux":
        unix_info.commonInfo
      of "FreeBSD", "DragonFly":
        unix_info.commonInfo
      of "OpenBSD":
        unix_info.commonInfo
      of "NetBSD":
        unix_info.commonInfo
      of "Darwin":
        let osInfo = getDarwinOsInfo($unix_info.release)
        result.os = osInfo[0]
        result.release = osInfo[1]
        result.codename = osInfo[2]
      of "AIX":
        unix_info.commonInfo
      of "Solaris", "SunOS":
        unix_info.commonInfo
      of "Haiku":
        # System Name: Haiku
        # Node Name: haiku
        # Release: R1/beta1
        # Version: hrev55220+1
        # Machine: x86_64
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