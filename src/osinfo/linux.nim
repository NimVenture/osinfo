import std/[os, osproc, strutils, options, tables, parseutils]
import tinyre
import ./release_file
import ./types

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
  ## returns (id, release, codename)
  ## Ubuntu, Debian, CentOS, Fedora, openSUSE, Arch Linux supported
  let output = execLsbRelease()
  if output.isSome:
    let arr = output.get().splitLines()
    if arr.len == 3:
      result = some((arr[0], arr[1],arr[2]))

proc ubuntuLsbRelease*(os: OsInfo, file: string) =
  let releaseRegex = reU"DISTRIB_RELEASE=(\d+\.\d+)"
  let codenameRegex = reU"DISTRIB_CODENAME=(\w+)"
  let release = file.match(releaseRegex)
  if release.len == 2: os.release = release[1]
  let codename = file.match(codenameRegex)
  if codename.len == 2: os.codename = codename[1]

proc redhatLsbRelease*(os: OsInfo, file: string) =
  let releaseRegex = re"release\s([^\s]+)"
  let codenameRegex = re"\(([^\)]+)\)"
  let release = file.match(releaseRegex)
  if release.len == 2: os.release = release[1]
  let codename = file.match(codenameRegex)
  if codename.len == 2: os.codename = codename[1]

proc centosLsbRelease*(os: OsInfo, file: string) =
  let releaseRegex = re"release\s([^\s]+)"
  let release = file.match(releaseRegex)
  if release.len == 2: os.release = release[1]
 
proc suseLsbRelease*(os: OsInfo, file: string) =
  let releaseRegex = reU"VERSION\s=\s(\d+\.\d+)"
  let codenameRegex = reU"CODENAME\s=\s(\w+)"
  let release = file.match(releaseRegex)
  if release.len == 2: os.release = release[1]
  let codename = file.match(codenameRegex)
  if codename.len == 2: os.codename = codename[1]
  
proc getValue(s: string, name: static[string]): string =
  let idx = s.find(name & "=")
  let startLen = name.len + 1
  if idx == 0:
    if s[idx + startLen] == '"':
      result = s[idx + startLen + 1 ..< s.len - 1]
    else:
      result = s[idx + startLen ..< s.len]

const OsId2LsbId = {
  "arch": "Arch Linux",
  "amzn": "Amazon Linux",
  "alpine": "Alpine Linux",
  "fedora": "Fedora",
  "zorin": "Zorin OS",
  "manjaro": "Manjaro Linux",
  "linuxmint": "Linux Mint", # notice: in lsb release file: DISTRIB_ID=LinuxMint
  "kde-neon": "Neon",
  "debian": "Debian",
  "opensuse": "openSUSE",
  "rhel": "Red Hat Enterprise Linux",
  "centos": "CentOS Linux",
  "freebsd": "FreeBSD",
  "netbsd": "NetBSD",
  "aix": "AIX",
  "openbsd": "OpenBSD",
  "raspbian": "Raspbian GNU/Linux",
  "ubuntu": "Ubuntu",
  "dragonfly": "DragonFly",
  "solaris": "Solaris"
}.toTable

proc extractOsRelase*(content: string): (string, string, string) =
  let lines = splitLines(content)

  var
    nameFound = false
    idFound = false
    versionFound = false
    codeFound = false
    name = ""
  for i, line in lines:
    if not nameFound:
      name = line.getValue("NAME")
      if name.len > 0:
        nameFound = true
    if not idFound:
      let id = line.getValue("ID")
      if id.len > 0:
        # failback to name, if unified name not found
        result[0] = OsId2LsbId.getOrDefault(id, name)
        idFound = true
    if not versionFound:
      let versionId = line.getValue("VERSION_ID")
      if versionId.len > 0:
        result[1] = versionId
        versionFound = true
      else:
        let version = line.getValue("VERSION")
        if version.len > 0:
          let l = version.find("(")
          if l != -1:
            # redhat, centos, fedora, ubuntu version contains code
            # eg. VERSION="17 (Beefy Miracle)"
            let lSpace = version.find(" ")
            result[1] = version[0 ..< lSpace]
            let code = version[l + 1 ..< version.len - 1]
            result[2] = code
            codeFound = true
          else:
            result[1] = version
          versionFound = true

    if not codeFound:
      let code = line.getValue("VERSION_CODENAME")
      if code.len > 0:
        result[2] = code
        codeFound = true
    if i == 5:
      break

proc getLinuxOsInfo*(): (string, string, string) =
  ## returns (id, release, codename)
  let etcRelease = fileExists("/etc/os-release")
  let usrlibRelease = fileExists("/usr/lib/os-release")
  if etcRelease or usrlibRelease:
    # https://www.linux.org/docs/man5/os-release.html
    let content = readFile(if etcRelease: "/etc/os-release" else: "/usr/lib/os-release")
    result = extractOsRelase(content)
  elif fileExists("/usr/bin/lsb_release") and isExecutable("/usr/bin/lsb_release"):
    let lsbInfo = getLsbInfo()
    if lsbInfo.isSome:
      result = getLsbInfo().get()
  else:
    var candidates: seq[string]
    for file in ReleaseFileAndFormalNames.keys():
      if fileExists(file):
        candidates = ReleaseFileAndFormalNames[file]
        break
    # if candidates.len == 1:
      
when isMainModule:
  # https://github.com/retrohacker/getos/issues/109
  echo getLinuxOsInfo()