import std/[os, osproc, strutils, options]
import ./release_file

proc isBinaryProgram(fileName: string): bool =
  var file = open(fileName, fmRead)
  var magicNumber: array[4, uint8]
  discard file.readBytes(magicNumber, 0,  4)
  file.close()
  return magicNumber == [127.uint8, 'E'.ord.uint8, 'L'.ord.uint8, 'F'.ord.uint8]

proc isExecutable(path: string): bool =
  let p = getFilePermissions(path)
  result = fpUserExec in p and fpGroupExec in p and fpOthersExec in p

proc execLsbRelease(): Option[string] =
  let (output, code) = execCmdEx("/usr/bin/lsb_release -i -r -c -s", options = {})
  if code == 0:
    result = some(output.strip)
  else:
    result = none(string)

proc getLsbInfo(): Option[(string, string, string)] =
  ## Ubuntu, Debian, CentOS, Fedora, openSUSE, Arch Linux supported
  let output = execLsbRelease()
  if output.isSome:
    let arr = output.get().splitLines()
    if arr.len == 3:
      result = some((arr[0], arr[1],arr[2]))

proc getLinuxOsInfo*(): (string, string, string) =
  if fileExists("/usr/bin/lsb_release") and isExecutable("/usr/bin/lsb_release"):
    let lsbInfo = getLsbInfo()
    if lsbInfo.isSome:
      result = getLsbInfo().get()
  else:
    var candidates: seq[string]
    for file in ReleaseFileAndFormalNames.keys():
      if fileExists(file):
        candidates = ReleaseFileAndFormalNames[file]
        break
    if candidates.len == 1:
      
when isMainModule:
  echo getLinuxOsInfo()