import tinyre
import ./types

proc fedoraOsRelease*(os: OsInfo, file: string) =
  let releaseRegex = reU"VERSION_ID=(\d+)"
  let codenameRegex = reU"\(([^\)]+)\)"
  let release = file.match(releaseRegex)
  if release.len == 2: os.release = release[1]
  let codename = file.match(codenameRegex)
  if codename.len == 2: os.codename = codename[1]

proc readhatOsRelease*(os: OsInfo, file: string) =
  let releaseRegex = reU"""VERSION_ID="([^"]+)"""
  let codenameRegex = reU"""VERSION="\d+\.\d+\s\((\w+)\)"""
  let release = file.match(releaseRegex)
  if release.len == 2: os.release = release[1]
  let codename = file.match(codenameRegex)
  if codename.len == 2: os.codename = codename[1]

proc osRelease*(os: OsInfo, file: string) =
  let releaseRegex = reU"""VERSION_ID="([^"]+)"""
  let codenameRegex = reU"VERSION_CODENAME=(\w+)"
  # In some versions of Solaris, the /etc/os-release file may not include a VERSION_ID field
  let versionRegex = reU"""VERSION="?([^"]+)"""
  let release = file.match(releaseRegex)
  if release.len == 2: 
    os.release = release[1]
  else:
    let version = file.match(versionRegex)
    if version.len == 2:
      os.release = version[1]

  let codename = file.match(codenameRegex)
  if codename.len == 2: 
    os.codename = codename[1]
