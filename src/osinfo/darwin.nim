
import std/[strutils]

proc getDarwinOsName*(release: string): string = 
  var rel = release
  if '.' in rel:
    let split = rel.split(".")
    rel = split[0]
  result = "Mac OS X "
  result.add(
    case rel
    of "20": "v11 Big Sur"
    of "19": "v10.15 Catalina"
    of "18": "v10.14 Mojave"
    of "17": "v10.13 High Sierra"
    of "16": "v10.12 Sierra"
    of "15": "v10.11 El Capitan"
    of "14": "v10.10 Yosemite"
    of "13": "v10.9 Mavericks"
    of "12": "v10.8 Mountain Lion"
    of "11": "v10.7 Lion"
    of "10": "v10.6 Snow Leopard"
    of "9": "v10.5 Leopard"
    of "8": "v10.4 Tiger"
    of "7": "v10.3 Panther"
    of "6": "v10.2 Jaguar"
    of "1.4": "v10.1 Puma"
    of "1.3": "v10.0 Cheetah"
    else: "Unknown version ($1)" % [release]
    )