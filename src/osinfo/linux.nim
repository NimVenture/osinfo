import std/[os, osproc, strutils]

proc isBinaryProgram(fileName: string): bool =
  var file = open(fileName, fmRead)
  var magicNumber: array[4, uint8]
  discard file.readBytes(magicNumber, 0,  4)
  file.close()
  return magicNumber == [127.uint8, 'E'.ord.uint8, 'L'.ord.uint8, 'F'.ord.uint8]

proc isExecutable(path: string): bool =
  let p = getFilePermissions(path)
  result = fpUserExec in p and fpGroupExec in p and fpOthersExec in p

proc readLsbRelease(): string =
  let (output, _) = execCmdEx("/usr/bin/lsb_release -d -s", options = {})
  result = output.strip

# On most Unix-like operating systems, including FreeBSD, DragonFly BSD, OpenBSD, NetBSD, AIX, SunOS (Solaris), and Haiku, the release information is typically stored in a file named etc/release or a similar location.

# Here are the common locations where you can find the release file on each of these operating systems:

# FreeBSD: /etc/release
# DragonFly BSD: /etc/release
# OpenBSD: /etc/version (Note: OpenBSD does not have a distinct release file like some other systems)
# NetBSD: /etc/release
# AIX: /etc/motd or use the oslevel -s command to get the AIX version
# Solaris (SunOS): /etc/release
# Haiku: /boot/system/build_info
# Here are examples of the contents of the release files on FreeBSD, DragonFly BSD, NetBSD, and Solaris (SunOS) to illustrate the differences in format and content:

# 1. **FreeBSD** (`/etc/release`):
# ```
# FreeBSD 12.0-RELEASE-p3 amd64
# ```

# 2. **DragonFly BSD** (`/etc/release`):
# ```
# DragonFly v5.6.0.354.gdbbc3c2-RELEASE
# ```

# 3. **NetBSD** (`/etc/release`):
# ```
# NetBSD 9.2 (GENERIC) #0: Tue Dec  1 14:25:41 UTC 2020
# ```

# 4. **Solaris (SunOS)** (`/etc/release`):
# ```
# Solaris 11.4.22.7.0
# ```


proc getOsName*(): string =
  if fileExists("/usr/bin/lsb_release") and isExecutable("/usr/bin/lsb_release"):
    result = readLsbRelease()
  elif fileExists("/etc/oracle-release"):
    # RedHat
    discard
  elif fileExists("/etc/redhat-release"):
    # RedHat
    discard
  elif fileExists("/etc/SuSE-release"):
    discard

when isMainModule:
  echo getOsName()