import tinyre
import ./types

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