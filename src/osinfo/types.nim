
type OsInfo* = ref object
  os*: string
  distro*: string
  edition*: string
  release*: string
  codename*: string

proc `$`*(info: OsInfo): string =
  when defined(windows):
    result = info.distro & " " & info.edition
  elif defined(macos) or defined(macosx):
    result = info.os & " " & info.release & " " & info.codename
  else:
    result = info.os & " " & info.distro & " " & info.codename
