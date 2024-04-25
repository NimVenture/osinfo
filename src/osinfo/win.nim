# Copyright (C) Dominik Picheta. All rights reserved.
# MIT License. Look at license.txt for more info.

## This module implements procedures which return various information about
## the user's computer.
when not defined(windows):
  {.error: "This module is only supported on Windows".}

import winlean
include ./windefs

proc getVersionInfo*(): TVersionInfo =
  ## Retrieves operating system info
  var osvi: TOSVERSIONINFOEX
  osvi.dwOSVersionInfoSize = sizeof(osvi).int32
  discard getVersionEx(osvi)
  if osvi.dwMajorVersion >= 6:
    # Starting with Windows 8, Windows does not report
    # honest version info from the above function, so we
    # need to use rtlGetVersion. Keeping the above
    # usage for backwards compatibility.
    #
    # See https://stackoverflow.com/a/39173324 for more.
    discard rtlGetVersion(osvi)

  result.majorVersion = osvi.dwMajorVersion
  result.minorVersion = osvi.dwMinorVersion
  result.buildNumber = osvi.dwBuildNumber
  result.platformID = osvi.dwPlatformId
  result.SPVersion = $cast[cstring](addr osvi.szCSDVersion)
  result.SPMajor = osvi.wServicePackMajor
  result.SPMinor = osvi.wServicePackMinor
  result.SuiteMask = osvi.wSuiteMask
  result.ProductType = osvi.wProductType

proc getProductInfo(majorVersion, minorVersion, SPMajorVersion,
                     SPMinorVersion: int): int =
  ## Retrieves Windows' ProductInfo, this function only works in Vista and 7
  let pGPI = cast[proc (dwOSMajorVersion, dwOSMinorVersion,
              dwSpMajorVersion, dwSpMinorVersion: int32, outValue: ptr int32){.stdcall.}](getProcAddress(
                getModuleHandleA("kernel32.dll"), "GetProductInfo"))

  if pGPI != nil:
    var dwType: int32
    pGPI(int32(majorVersion), int32(minorVersion), int32(SPMajorVersion), int32(SPMinorVersion), addr(dwType))
    result = int(dwType)
  else:
    return PRODUCT_UNDEFINED

proc getSystemInfo(): TSYSTEM_INFO =
  ## Returns the SystemInfo

  # Use GetNativeSystemInfo if it's available
  var pGNSI = cast[proc (lpSystemInfo: LPSYSTEM_INFO){.stdcall.}](getProcAddress(
                getModuleHandleA("kernel32.dll"), "GetNativeSystemInfo"))

  var systemi: TSYSTEM_INFO
  if pGNSI != nil:
    pGNSI(addr(systemi))
  else:
    getSystemInfo(addr(systemi))

  return systemi

proc getOsInfo*(osvi: TVersionInfo, includeEdition = false, includeSp = false, includeBuild = false, includeArch = false): string =
  ## Turns a VersionInfo object into a string
  if osvi.platformID == VER_PLATFORM_WIN32_NT and osvi.majorVersion > 4:
    result = "Microsoft"

    let si = getSystemInfo()
    # Test for the specific product
    if osvi.majorVersion == 10:
      if osvi.buildNumber >= 22000:
        if osvi.ProductType == VER_NT_WORKSTATION:
          result.add(" Windows 11")
        else: result.add(" Windows Server 2022")
      else:
        if osvi.ProductType == VER_NT_WORKSTATION:
          result.add(" Windows 10")
        else: result.add(" Windows Server 2016")
    if osvi.majorVersion == 6:
      if osvi.minorVersion == 0:
        if osvi.ProductType == VER_NT_WORKSTATION:
          result.add(" Windows Vista")
        else: result.add(" Windows Server 2008")
      elif osvi.minorVersion == 1:
        if osvi.ProductType == VER_NT_WORKSTATION:
          result.add(" Windows 7")
        else: result.add(" Windows Server 2008 R2")
      elif osvi.minorVersion == 2:
        if osvi.ProductType == VER_NT_WORKSTATION:
          result.add(" Windows 8")
        else: result.add(" Windows Server 2012")
      elif osvi.minorVersion == 3:
        if osvi.ProductType == VER_NT_WORKSTATION:
          result.add(" Windows 8.1")
        else: result.add(" Windows Server 2012 R2")

    # The GetProductInfo return result works when dwOSMajorVersion minimum value is 6.
    if includeEdition and osvi.majorVersion >= 6:
      let dwType = getProductInfo(osvi.majorVersion, osvi.minorVersion, 0, 0)
      case dwType
      of PRODUCT_PRO_WORKSTATION:
        result.add(" Pro for Workstations")
      of PRODUCT_PRO_WORKSTATION_N:
        result.add(" Pro for Workstations N")
      of PRODUCT_EDUCATION:
        result.add(" Education")
      of PRODUCT_EDUCATION_N:
        result.add(" Education N")
      of PRODUCT_ULTIMATE:
        result.add(" Ultimate")
      of PRODUCT_PROFESSIONAL:
        result.add(" Professional")
      of PRODUCT_HOME_PREMIUM:
        result.add(" Home Premium")
      of PRODUCT_HOME_BASIC:
        result.add(" Home Basic")
      of PRODUCT_ENTERPRISE:
        result.add(" Enterprise")
      of PRODUCT_ENTERPRISE_E:
        result.add(" Enterprise E")
      of PRODUCT_ENTERPRISE_EVALUATION:
        result.add(" Enterprise Evaluation")
      of PRODUCT_ENTERPRISE_N:
        result.add(" Enterprise N")
      of PRODUCT_ENTERPRISE_N_EVALUATION:
        result.add(" Enterprise N Evaluation")
      of PRODUCT_ENTERPRISE_S:
        result.add(" Enterprise 2015 LTSB")
      of PRODUCT_ENTERPRISE_S_EVALUATION:
        result.add(" Enterprise 2015 LTSB Evaluation")
      of PRODUCT_ENTERPRISE_S_N:
        result.add(" Enterprise 2015 LTSB N")
      of PRODUCT_ENTERPRISE_S_N_EVALUATION:
        result.add(" Enterprise 2015 LTSB N Evaluation")
      of PRODUCT_BUSINESS:
        result.add(" Business")
      of PRODUCT_STARTER:
        result.add(" Starter")
      of PRODUCT_CLUSTER_SERVER:
        result.add(" Cluster Server")
      of PRODUCT_DATACENTER_SERVER:
        result.add(" Datacenter")
      of PRODUCT_DATACENTER_SERVER_CORE:
        result.add(" Datacenter (core installation)")
      of PRODUCT_DATACENTER_SERVER_CORE_V:
        result.add(" Server Datacenter without Hyper-V (core installation)")
      of PRODUCT_DATACENTER_SERVER_V:
        result.add(" Server Datacenter without Hyper-V (full installation)")
      of PRODUCT_ENTERPRISE_SERVER:
        result.add(" Server Enterprise (full installation)")
      of PRODUCT_ENTERPRISE_SERVER_CORE:
        result.add(" Server Enterprise (core installation)")
      of PRODUCT_ENTERPRISE_SERVER_CORE_V:
        result.add(" Server Enterprise without Hyper-V (core installation)")
      of PRODUCT_ENTERPRISE_SERVER_V:
        result.add(" Server Enterprise without Hyper-V (full installation)")
      of PRODUCT_ENTERPRISE_SERVER_IA64:
        result.add(" Server Enterprise for Itanium-based Systems")
      of PRODUCT_SMALLBUSINESS_SERVER:
        result.add(" Small Business Server")
      of PRODUCT_STANDARD_SERVER:
        result.add(" Standard")
      of PRODUCT_STANDARD_SERVER_CORE:
        result.add(" Standard (core installation)")
      of PRODUCT_WEB_SERVER:
        result.add(" Web Server")
      of PRODUCT_STORAGE_ENTERPRISE_SERVER:
        result.add(" Storage Server Enterprise")
      of PRODUCT_STORAGE_ENTERPRISE_SERVER_CORE:
        result.add(" Storage Server Enterprise (core installation) ")
      of PRODUCT_STORAGE_EXPRESS_SERVER:
        result.add(" Storage Server Express")
      of PRODUCT_STORAGE_STANDARD_SERVER:
        result.add(" Storage Server Standard")
      of PRODUCT_STORAGE_WORKGROUP_SERVER:
        result.add(" Storage Server Workgroup")
      else:
        discard
    # End of Windows 6.*

    elif osvi.majorVersion == 5 and osvi.minorVersion == 2:
      if getSystemMetrics(SM_SERVERR2) != 0:
        result.add(" Windows Server 2003 R2")
      elif (osvi.SuiteMask and VER_SUITE_PERSONAL) != 0: # Not sure if this will work
        result.add(" Windows Storage Server 2003")
      elif (osvi.SuiteMask and VER_SUITE_WH_SERVER) != 0:
        result.add(" Windows Home Server")
      elif osvi.ProductType == VER_NT_WORKSTATION: 
      # and
      #     si.wProcessorArchitecture==PROCESSOR_ARCHITECTURE_AMD64:
        result.add(" Windows XP Professional")
      else:
        result.add(" Windows Server 2003")

      # Test for the specific product
      if includeEdition and osvi.ProductType != VER_NT_WORKSTATION:
        if si.wProcessorArchitecture.uint == PROCESSOR_ARCHITECTURE_IA64:
          if (osvi.SuiteMask and VER_SUITE_DATACENTER) != 0:
            result.add(" Datacenter for Itanium-based Systems")
          elif (osvi.SuiteMask and VER_SUITE_ENTERPRISE) != 0:
            result.add(" Enterprise for Itanium-based Systems")
        # elif si.wProcessorArchitecture.uint == PROCESSOR_ARCHITECTURE_AMD64:
        #   if (osvi.SuiteMask and VER_SUITE_DATACENTER) != 0:
        #     result.add("Datacenter x64 Edition")
        #   elif (osvi.SuiteMask and VER_SUITE_ENTERPRISE) != 0:
        #     result.add("Enterprise x64 Edition")
        #   else:
        #     result.add("Standard x64 Edition")
        else:
          if (osvi.SuiteMask and VER_SUITE_COMPUTE_SERVER) != 0:
            result.add(" Compute Cluster")
          elif (osvi.SuiteMask and VER_SUITE_DATACENTER) != 0:
            result.add( "Datacenter")
          elif (osvi.SuiteMask and VER_SUITE_ENTERPRISE) != 0:
            result.add(" Enterprise")
          elif (osvi.SuiteMask and VER_SUITE_BLADE) != 0:
            result.add(" Web")
          else:
            result.add(" Standard")
    # End of 5.2

    elif osvi.majorVersion == 5 and osvi.minorVersion == 1:
      result.add(" Windows XP")
      if (osvi.SuiteMask and VER_SUITE_PERSONAL) != 0:
        result.add(" Home Edition")
      else:
        result.add(" Professional")
    # End of 5.1

    elif osvi.majorVersion == 5 and osvi.minorVersion == 0:
      result.add(" Windows 2000")
      if osvi.ProductType == VER_NT_WORKSTATION:
        result.add(" Professional")
      else:
        if (osvi.SuiteMask and VER_SUITE_DATACENTER) != 0:
          result.add(" Datacenter Server")
        elif (osvi.SuiteMask and VER_SUITE_ENTERPRISE) != 0:
          result.add(" Advanced Server")
        else:
          result.add(" Server")
    # End of 5.0

    # Include service pack (if any) and build number.
    if includeSp and len(osvi.SPVersion) > 0:
      result.add(" ")
      result.add(osvi.SPVersion)
    if includeBuild:
      result.add(" (build " & $osvi.buildNumber & ")")

    if includeArch and osvi.majorVersion >= 6:
      if si.wProcessorArchitecture.uint == PROCESSOR_ARCHITECTURE_AMD64:
        result.add(", 64-bit")
      elif si.wProcessorArchitecture.uint == PROCESSOR_ARCHITECTURE_INTEL:
        result.add(", 32-bit")
  else:
    # Windows 98 etc...
    result = "Unknown version of windows[Kernel version <= 4]"

proc `$`*(osvi: TVersionInfo): string = osvi.getOsInfo(true, true, true, true)

when isMainModule:

  let osvi = getVersionInfo()

  echo($osvi)
