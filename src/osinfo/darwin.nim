
import std/[strutils]

proc getDarwinOsInfo*(release: string): (string, string, string) = 
  var rel = release
  if '.' in rel:
    let split = rel.split(".")
    rel = split[0]
  result[0] = case rel
    of "1.3", "1.4", "6","7","8","9","10","11","12","13","14","15":
      "Mac OS X"
    else:
      "macOS"

  case rel
  of "23":
    result[1] = "14"
    result[2] = "Sonoma"
  of "22":
    result[1] = "13"
    result[2] = "Ventura"
  of "21":
    result[1] = "12"
    result[2] = "Monterey"
  of "20": 
    result[1] = "11"
    result[2] = "Big Sur"
  of "19":
    result[1] = "10.15"
    result[2] = "Catalina"
  of "18":
    result[1] = "10.14"
    result[2] = "Mojave"
  of "17":
    result[1] = "10.13"
    result[2] = "High Sierra"
  of "16":
    result[1] = "10.12"
    result[2] = "Sierra"
  of "15":
    result[1] = "10.11"
    result[2] = "El Capitan"
  of "14":
    result[1] = "10.10"
    result[2] = "Yosemite"
  of "13":
    result[1] = "10.9"
    result[2] = "Mavericks"
  of "12":
    result[1] = "10.8"
    result[2] = "Mountain Lion"
  of "11":
    result[1] = "10.7"
    result[2] = "Lion"
  of "10":
    result[1] = "10.6"
    result[2] = "Snow Leopard"
  of "9":
    result[1] = "10.5"
    result[2] = "Leopard"
  of "8":
    result[1] = "10.4"
    result[2] = "Tiger"
  of "7":
    result[1] = "10.3"
    result[2] = "Panther"
  of "6":
    result[1] = "10.2"
    result[2] = "Jaguar"
  of "1.4":
    result[1] = "10.1"
    result[2] = "Puma"
  of "1.3":
    result[1] = "10.0"
    result[2] = "Cheetah"
  else: discard
  