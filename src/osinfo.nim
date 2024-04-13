import std/[os, strutils]
import osinfo/darwin

when defined(windows):
  import osinfo/win
elif defined(posix):
  import osinfo/posix

proc getOsName(): string =
  when defined(windows):
    discard
  elif defined(posix):
    var unix_info: Utsname
    if uname(unix_info) != 0:
      raiseOSError(osLastError())
    let sysname = $unix_info.sysname
    case sysname
      of "Linux":
        result = "Linux"
      of "FreeBSD", "DragonFly":
        result = "FreeBSD"
      of "OpenBSD":
        result = "OpenBSD"
      of "NetBSD":
        result = "NetBSD"
      of "Darwin":
        result = getDarwinOsName($unix_info.release)
      of "AIX":
        result = "AIX"
      of "Solaris", "SunOS":
        result = "Solaris"
      of "Haiku":
        result = "Haiku"
      of "Windows":
        result = "Windows"