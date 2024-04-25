# Copyright (C) Dominik Picheta. All rights reserved.
# MIT License. Look at license.txt for more info.

## This module implements procedures which return various information about
## the user's computer.
when not defined(windows):
  {.error: "This module is only supported on Windows".}

import winlean
include ./windefs

type WindowsOSInfo* = object
  version*: string
  edition*: string
  sp*: string
  buildNumber*: int
  arch*: string

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

proc getOsInfo*(osvi: TVersionInfo): WindowsOSInfo =
  ## Turns a VersionInfo object into a string
  if osvi.platformID == VER_PLATFORM_WIN32_NT and osvi.majorVersion > 4:
    # result = "Microsoft"

    let si = getSystemInfo()
    # Test for the specific product
    if osvi.majorVersion == 10:
      if osvi.buildNumber >= 22000:
        if osvi.ProductType == VER_NT_WORKSTATION:
          result.version = "Windows 11"
        else: result.version = "Windows Server 2022"
      else:
        if osvi.ProductType == VER_NT_WORKSTATION:
          result.version = "Windows 10"
        else: result.version = "Windows Server 2016"
    if osvi.majorVersion == 6:
      if osvi.minorVersion == 0:
        if osvi.ProductType == VER_NT_WORKSTATION:
          result.version = "Windows Vista"
        else: result.version = "Windows Server 2008"
      elif osvi.minorVersion == 1:
        if osvi.ProductType == VER_NT_WORKSTATION:
          result.version = "Windows 7"
        else: result.version = "Windows Server 2008 R2"
      elif osvi.minorVersion == 2:
        if osvi.ProductType == VER_NT_WORKSTATION:
          result.version = "Windows 8"
        else: result.version = "Windows Server 2012"
      elif osvi.minorVersion == 3:
        if osvi.ProductType == VER_NT_WORKSTATION:
          result.version = "Windows 8.1"
        else: result.version = "Windows Server 2012 R2"

    # The GetProductInfo return result works when dwOSMajorVersion minimum value is 6.
    if osvi.majorVersion >= 6:
      let dwType = getProductInfo(osvi.majorVersion, osvi.minorVersion, 0, 0)
      case dwType
      of PRODUCT_PRO_WORKSTATION:
        result.edition = "Pro for Workstations"
      of PRODUCT_PRO_WORKSTATION_N:
       result.edition = "Pro for Workstations N"
      of PRODUCT_EDUCATION:
       result.edition = "Education"
      of PRODUCT_EDUCATION_N:
       result.edition = "Education N"
      of PRODUCT_ULTIMATE:
       result.edition = "Ultimate"
      of PRODUCT_PROFESSIONAL:
       result.edition = "Professional"
      of PRODUCT_HOME_PREMIUM:
       result.edition = "Home Premium"
      of PRODUCT_HOME_BASIC:
       result.edition = "Home Basic"
      of PRODUCT_ENTERPRISE:
       result.edition = "Enterprise"
      of PRODUCT_ENTERPRISE_E:
       result.edition = "Enterprise E"
      of PRODUCT_ENTERPRISE_EVALUATION:
       result.edition = "Enterprise Evaluation"
      of PRODUCT_ENTERPRISE_N:
       result.edition = "Enterprise N"
      of PRODUCT_ENTERPRISE_N_EVALUATION:
       result.edition = "Enterprise N Evaluation"
      of PRODUCT_ENTERPRISE_S:
       result.edition = "Enterprise 2015 LTSB"
      of PRODUCT_ENTERPRISE_S_EVALUATION:
       result.edition = "Enterprise 2015 LTSB Evaluation"
      of PRODUCT_ENTERPRISE_S_N:
       result.edition = "Enterprise 2015 LTSB N"
      of PRODUCT_ENTERPRISE_S_N_EVALUATION:
       result.edition = "Enterprise 2015 LTSB N Evaluation"
      of PRODUCT_BUSINESS:
       result.edition = "Business"
      of PRODUCT_STARTER:
       result.edition = "Starter"
      of PRODUCT_CLUSTER_SERVER:
       result.edition = "Cluster Server"
      of PRODUCT_DATACENTER_SERVER:
       result.edition = "Datacenter"
      of PRODUCT_DATACENTER_SERVER_CORE:
       result.edition = "Datacenter (core installation)"
      of PRODUCT_DATACENTER_SERVER_CORE_V:
       result.edition = "Server Datacenter without Hyper-V (core installation)"
      of PRODUCT_DATACENTER_SERVER_V:
       result.edition = "Server Datacenter without Hyper-V (full installation)"
      of PRODUCT_ENTERPRISE_SERVER:
       result.edition = "Server Enterprise (full installation)"
      of PRODUCT_ENTERPRISE_SERVER_CORE:
       result.edition = "Server Enterprise (core installation)"
      of PRODUCT_ENTERPRISE_SERVER_CORE_V:
       result.edition = "Server Enterprise without Hyper-V (core installation)"
      of PRODUCT_ENTERPRISE_SERVER_V:
       result.edition = "Server Enterprise without Hyper-V (full installation)"
      of PRODUCT_ENTERPRISE_SERVER_IA64:
       result.edition = "Server Enterprise for Itanium-based Systems"
      of PRODUCT_SMALLBUSINESS_SERVER:
       result.edition = "Small Business Server"
      of PRODUCT_STANDARD_SERVER:
       result.edition = "Standard"
      of PRODUCT_STANDARD_SERVER_CORE:
       result.edition = "Standard (core installation)"
      of PRODUCT_WEB_SERVER:
       result.edition = "Web Server"
      of PRODUCT_STORAGE_ENTERPRISE_SERVER:
       result.edition = "Storage Server Enterprise"
      of PRODUCT_STORAGE_ENTERPRISE_SERVER_CORE:
       result.edition = "Storage Server Enterprise (core installation)"
      of PRODUCT_STORAGE_EXPRESS_SERVER:
       result.edition = "Storage Server Express"
      of PRODUCT_STORAGE_STANDARD_SERVER:
       result.edition = "Storage Server Standard"
      of PRODUCT_STORAGE_WORKGROUP_SERVER:
       result.edition = "Storage Server Workgroup"
      else:
        discard
    # End of Windows 6.*

    elif osvi.majorVersion == 5 and osvi.minorVersion == 2:
      if getSystemMetrics(SM_SERVERR2) != 0:
        result.version = "Windows Server 2003 R2"
      elif (osvi.SuiteMask and VER_SUITE_PERSONAL) != 0: # Not sure if this will work
        result.version = "Windows Storage Server 2003"
      elif (osvi.SuiteMask and VER_SUITE_WH_SERVER) != 0:
        result.version = "Windows Home Server"
      elif osvi.ProductType == VER_NT_WORKSTATION: 
      # and
      #     si.wProcessorArchitecture==PROCESSOR_ARCHITECTURE_AMD64:
        result.version = "Windows XP Professional"
      else:
        result.version = "Windows Server 2003"

      # Test for the specific product
      if osvi.ProductType != VER_NT_WORKSTATION:
        if si.wProcessorArchitecture.uint == PROCESSOR_ARCHITECTURE_IA64:
          if (osvi.SuiteMask and VER_SUITE_DATACENTER) != 0:
            result.edition = "Datacenter for Itanium-based Systems"
          elif (osvi.SuiteMask and VER_SUITE_ENTERPRISE) != 0:
            result.edition = "Enterprise for Itanium-based Systems"
        # elif si.wProcessorArchitecture.uint == PROCESSOR_ARCHITECTURE_AMD64:
        #   if (osvi.SuiteMask and VER_SUITE_DATACENTER) != 0:
        #     result.edition = "Datacenter x64 Edition")
        #   elif (osvi.SuiteMask and VER_SUITE_ENTERPRISE) != 0:
        #     result.edition = "Enterprise x64 Edition")
        #   else:
        #     result.edition = "Standard x64 Edition")
        else:
          if (osvi.SuiteMask and VER_SUITE_COMPUTE_SERVER) != 0:
            result.edition = "Compute Cluster"
          elif (osvi.SuiteMask and VER_SUITE_DATACENTER) != 0:
            result.edition = "Datacenter"
          elif (osvi.SuiteMask and VER_SUITE_ENTERPRISE) != 0:
            result.edition = "Enterprise"
          elif (osvi.SuiteMask and VER_SUITE_BLADE) != 0:
            result.edition = "Web"
          else:
            result.edition = "Standard"
    # End of 5.2

    elif osvi.majorVersion == 5 and osvi.minorVersion == 1:
      result.version = "Windows XP"
      if (osvi.SuiteMask and VER_SUITE_PERSONAL) != 0:
        result.edition = "Home Edition"
      else:
        result.edition = "Professional"
    # End of 5.1

    elif osvi.majorVersion == 5 and osvi.minorVersion == 0:
      result.version = "Windows 2000"
      if osvi.ProductType == VER_NT_WORKSTATION:
        result.edition = "Professional"
      else:
        if (osvi.SuiteMask and VER_SUITE_DATACENTER) != 0:
          result.edition = "Datacenter Server"
        elif (osvi.SuiteMask and VER_SUITE_ENTERPRISE) != 0:
          result.edition = "Advanced Server"
        else:
          result.edition = "Server"
    # End of 5.0

    # Include service pack (if any) and build number.
    if len(osvi.SPVersion) > 0:
      result.sp = osvi.SPVersion
    result.buildNumber = osvi.buildNumber

    if osvi.majorVersion >= 6:
      if si.wProcessorArchitecture.uint == PROCESSOR_ARCHITECTURE_AMD64:
        result.arch = "x64"
      elif si.wProcessorArchitecture.uint == PROCESSOR_ARCHITECTURE_INTEL:
        result.arch = "x86"
  else:
    # Windows 98 etc...
    # result = "Unknown version of windows[Kernel version <= 4]"
    discard

proc getOsInfo*(): WindowsOSInfo =
  let osvi = getVersionInfo()
  getOsInfo(osvi)

proc `$`*(info: WindowsOSInfo): string = 
  result = info.version & " " & info.edition 
  if info.sp.len > 0:
    result.add " " & info.sp 
  result.add " " & "(build " & $info.buildNumber & ")" & ", " & info.arch

proc `$`*(osvi: TVersionInfo): string =
  $getOsInfo(osvi)

when isMainModule:

  echo getOsInfo()
