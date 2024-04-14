
type OsInfo* = ref object
  os*: string
  distro*: string
  release*: string
  codename*: string

proc `$`*(info: OsInfo): string =
  info.os & " " & info.distro & " " & info.release & " " & info.codename
