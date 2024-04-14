import std/[os, osproc, strutils]
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

proc readLsbRelease(): string =
  let (output, _) = execCmdEx("/usr/bin/lsb_release -d -s", options = {})
  result = output.strip

proc getName(candidate: string): string =
  var index = 0
  var name = "Linux"

  while name == "Linux":
    inc index
    name = candidate.split(' ')[index]
  
  return name

proc getOsName*(): string =
  if fileExists("/usr/bin/lsb_release") and isExecutable("/usr/bin/lsb_release"):
    result = readLsbRelease()
  # elif fileExists("/etc/oracle-release"):
  #   # RedHat
  #   discard
  # elif fileExists("/etc/redhat-release"):
  #   # RedHat
  #   discard
  # elif fileExists("/etc/SuSE-release"):
  #   discard
  else:
    var candidates: seq[string]
    for file in ReleaseFileAndFormalNames.keys():
      if fileExists(file):
        candidates = ReleaseFileAndFormalNames[file]
        break
    if candidates.len == 1:
      
when isMainModule:
  echo getOsName()