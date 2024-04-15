import std/[os, osproc, strutils, options, tables]
import ./release_file

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
  "kde-neon": "KDE neon",
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
  "dragonfly": "DragonFly BSD",
  "solaris": "Solaris",
  "amzn": "Amazon Linux"
}.toTable

proc extractRelease*(content: string): (string, string, string) =
  let lines = content.splitLines
  if lines.len == 1:
    let line = lines[0]
    let lQuote = line.find("(")
    if lQuote != -1:
      let rQuote = line.find(")", lQuote + 1)
      if rQuote != -1:
        result[2] = line[lQuote + 1 ..< rQuote]
        var idx = lQuote - 2
        var ver = newStringOfCap(idx)
        while line[idx] != ' ':
          ver.add line[idx]
          idx = idx - 1
        let probRelease = line[idx - "release".len ..< idx]
        result[1] = ver
        if probRelease == "release":
          result[0] = line[0 ..< idx - "release".len - 1]
        else:
          result[0] = line[0 ..< idx]
    else:
      let spaceCount = line.count(' ')
      if spaceCount == 1:
        let cols = line.split(' ')
        result[0] = cols[0]
        if cols[1][0] == 'v':
          # DragonFly v6.2.0.1
          result[1] = cols[1][1 .. ^1]
        else:
          result[1] = cols[1]
      else:
        echo line
        echo spaceCount
  else:
    var
      idFound = false
      releaseFound = false
      codeFound = false
    for line in lines:
      if not idFound:
        let id = line.getValue("DISTRIB_ID")
        if id.len > 0:
          result[0] = id
          idFound = true
      if not releaseFound:
        let release = line.getValue("DISTRIB_RELEASE")
        if release.len > 0:
          result[1] = release
          releaseFound = true
      if not codeFound:
        let code = line.getValue("DISTRIB_CODENAME")
        if code.len > 0:
          result[2] = code
          codeFound = true
      if idFound and releaseFound and codeFound:
        break

proc extractOsRelease*(content: string): (string, string, string) =
  let lines = splitLines(content)

  var
    nameFound = false
    idFound = false
    versionIdFound = false
    versionFound = false
    codeFound = false
    name = ""
    version = ""
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
    if not versionIdFound:
      let versionId = line.getValue("VERSION_ID")
      if versionId.len > 0:
        result[1] = versionId
        versionIdFound = true
    if not versionFound:
      version = line.getValue("VERSION")
      if version.len > 0:
        versionFound = true

    if not codeFound:
      let code = line.getValue("VERSION_CODENAME")
      if code.len > 0:
        result[2] = code
        codeFound = true
    if i == 5:
      break

  if not codeFound:
    let l = version.find("(")
    if l != -1:
      # redhat, centos, fedora, ubuntu version contains code
      # eg. VERSION="17 (Beefy Miracle)"
      let lSpace = version.find(" ")
      if not versionIdFound:
        result[1] = version[0 ..< lSpace]
      let code = version[l + 1 ..< version.len - 1]
      result[2] = code
    elif not versionIdFound:
      result[1] = version
  
proc getLinuxOsInfo*(): (string, string, string) =
  ## returns (id, release, codename)
  let etcRelease = fileExists("/etc/os-release")
  let usrlibRelease = fileExists("/usr/lib/os-release")
  if etcRelease or usrlibRelease:
    # https://www.linux.org/docs/man5/os-release.html
    let content = readFile(if etcRelease: "/etc/os-release" else: "/usr/lib/os-release")
    result = extractOsRelease(content)
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