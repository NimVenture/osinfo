import std/[os, strutils, options, tables]
  
proc getValue(s: string, name: static[string]): string =
  let idx = s.find(name & "=")
  let startLen = name.len + 1
  if idx == 0:
    if s[idx + startLen] == '"':
      result = s[idx + startLen + 1 ..< s.len - 1]
    else:
      result = s[idx + startLen ..< s.len]

const OsId2Name = {
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
  "amzn": "Amazon Linux",
  "gentoo": "Gentoo Linux",
  "void": "Void Linux",
  "almalinux": "AlmaLinux"
}.toTable

const DistribId2Name = {
  "elementaryOS": "elementary OS",
  "Neon": "KDE neon",
  "LinuxMint": "Linux Mint",
  "Arch": "Arch Linux",
  "ManjaroLinux": "Manjaro Linux",
  "Kali": "Kali Linux",
  "Void": "Void Linux"
}.toTable

proc isVersion(s: string): bool =
  s.len > 0 and (s[0] in {'0'..'9'} or (s.len > 1 and s[0] == 'v' and s[1] in {'0'..'9'})) and
  s.contains('.')

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
          result[1] = cols[1][1 .. ^1]
        else:
          result[1] = cols[1]
      else:
        let parts = line.split()
        var handled = false
        
        # Case 1: Handle "release X.X" pattern first
        for i in 0..<parts.len:
          if parts[i].toLowerAscii == "release" and i+1 < parts.len:
            result[0] = parts[0..i-1].join(" ")
            result[1] = parts[i+1]
            if parts.len > i+2:
              result[2] = parts[i+2..^1].join(" ")
            handled = true
            break
        
        if not handled:
          # Case 2: Void Linux handling
          if parts.len > 0 and parts[0].replace("-", "").toLowerAscii == "voidlive":
            result[0] = "Void Linux"
            result[2] = parts[1..^1].join(" ")
            handled = true
          
        if not handled:
          # Case 3: Version detection
          var versionIndex = -1
          for i in 0..<parts.len:
            if isVersion(parts[i]):
              versionIndex = i
              break
          
          if versionIndex != -1:
            result[0] = parts[0..<versionIndex].join(" ")
            result[1] = parts[versionIndex]
            if parts.len > versionIndex+1:
              result[2] = parts[versionIndex+1..^1].join(" ")
          else:
            result[0] = line
        
        # Normalization
        let lookupKey = result[0].replace(" ", "").replace("-", "")
        if lookupKey in DistribId2Name:
          result[0] = DistribId2Name[lookupKey]
  else:
    var
      idFound = result[0].len > 0
      releaseFound = result[1].len > 0
      codeFound = result[2].len > 0
    
    if not (idFound and releaseFound and codeFound):
      for line in lines:
        if not idFound:
          let id = line.getValue("DISTRIB_ID")
          if id.len > 0:
            result[0] = DistribId2Name.getOrDefault(id, id)
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
    
    # Special case: Oracle Solaris
    if result[0].len == 0 or result[1].len == 0:
      # Unified special case handling
      let firstLine = if lines.len > 0: lines[0] else: ""
      case firstLine.splitWhiteSpace(1)[0]
      of "Oracle":
        # Oracle Solaris handling
        let firstLineParts = firstLine.split()
        if firstLineParts.len >= 3:
          result[0] = "Oracle Solaris"
          result[1] = firstLineParts[2]
          if firstLineParts.len > 3:
            result[2] = firstLineParts[3..^1].join(" ")
      
      of "openSUSE":
        # openSUSE handling
        result[0] = "openSUSE"
        # Extract version from either first line or VERSION field
        if result[1].len == 0:
          let versionParts = firstLine.split({' ', '('})
          if versionParts.len >= 2:
            result[1] = versionParts[1]
        # Prioritize CODENAME field over architecture
        if result[2] == "x86_64" or result[2].contains('('):
          result[2] = ""  # Reset if we got architecture instead of codename
        for line in lines:
          if line.startsWith("CODENAME"):
            result[2] = line.split("=")[1].strip()
            break
      
      else:
        # Add other special cases here
        discard

    # Final normalization pass
    if result[0] in ["openSUSE", "Oracle Solaris"] and result[2].len == 0:
      # Ensure codename is cleared if not found
      result[2] = ""

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
        result[0] = OsId2name.getOrDefault(id, name)
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
    # if i == 5:
    #   break
    # when comes to ubuntu, gentoo, Manjaro this fails

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

  if fileExists("/etc/os-release"):
    # https://www.linux.org/docs/man5/os-release.html
    let content = readFile("/etc/os-release")
    result = extractOsRelease(content)
  elif fileExists("/usr/lib/os-release"):
    let content = readFile("/usr/lib/os-release")
    result = extractOsRelease(content)
  elif fileExists("/etc/lsb-release"):
    let content = readFile("/etc/lsb-release")
    result = extractRelease(content)
  # elif fileExists("/usr/bin/lsb_release") and isExecutable("/usr/bin/lsb_release"):
  #   let lsbInfo = getLsbInfo()
  #   if lsbInfo.isSome:
  #     result = getLsbInfo().get()
  else:
    discard
    # FIXME: check distribution specific release file
      
when isMainModule:
  # https://github.com/retrohacker/getos/issues/109
  echo getLinuxOsInfo()