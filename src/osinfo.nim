import std/[os, strutils]
import osinfo/darwin

when defined(windows):
  import osinfo/win
elif defined(posix):
  import osinfo/posix

type OsInfo* = ref object
  os*: string
  distro*: string
  version*: string
  codename*: string

proc getOsInfo(): OsInfo =
  result = new OsInfo
  when defined(windows):
    discard
  elif defined(bsd):
    discard
  elif defined(linux):
    var unix_info: Utsname
    if uname(unix_info) != 0:
      raiseOSError(osLastError())
    let sysname = $unix_info.sysname
    case sysname
      of "Linux":
        result = "Linux"
      of "FreeBSD", "DragonFly":
        # no code name
        result = "FreeBSD"
      of "OpenBSD":
        # no code name
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
        # System Name: Haiku
        # Node Name: haiku
        # Release: R1/beta1
        # Version: hrev55220+1
        # Machine: x86_64
        result = "Haiku"
      of "Windows":
        result = "Windows"
      of "OS/390":
        # no code name
        discard 
      of "MVS":
        # no code name
        discard
      of "z/OS":
        # no code name
        discard
  elif defined(haiku):
    discard
  elif defined(macox) or defined(macosx):
    discard