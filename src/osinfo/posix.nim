# Copyright (C) Dominik Picheta. All rights reserved.
# MIT License. Look at license.txt for more info.

when not defined(posix):
  {.error: "This module is only supported on POSIX".}

when false:
  type
    Tstatfs {.importc: "struct statfs64",
              header: "<sys/statfs.h>", final, pure.} = object
      f_type: int
      f_bsize: int
      f_blocks: int
      f_bfree: int
      f_bavail: int
      f_files: int
      f_ffree: int
      f_fsid: int
      f_namelen: int

  proc statfs(path: string, buf: var Tstatfs): int {.
    importc, header: "<sys/vfs.h>".}

type
  Utsname* {.importc: "struct utsname",
              header: "<sys/utsname.h>",
              final, pure.} = object ## struct utsname
    sysname*,      ## Name of this implementation of the operating system.
      nodename*,   ## Name of this node within the communications
                   ## network to which this node is attached, if any.
      release*,    ## Current release level of this implementation.
      version*,    ## Current version level of this release.
      machine*: cstring ## Name of the hardware type on which the
                                     ## system is running.

proc uname*(a1: var Utsname): cint {.importc, header: "<sys/utsname.h>".}
