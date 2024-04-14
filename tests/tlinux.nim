import ./distros
import osinfo/[types, linux]

block ubuntu:
  var os = new OsInfo
  ubuntuCustomLogic(os, Ubuntu)
  doAssert os.release == "20.04"
  doAssert os.codename == "focal"

block centos:
  var os = new OsInfo
  centosCustomLogic(os, CentOS)
  doAssert os.release == "8.4.2105"
  doAssert os.codename == ""

block redhat:
  var os = new OsInfo
  centosCustomLogic(os, RedHat)
  doAssert os.release == "8.4"
  doAssert os.codename == "Ootpa"

block suse:
  var os = new OsInfo
  suseCustomLogic(os, Suse)
  doAssert os.release == "15.0"

block debian:
  var os = new OsInfo
  debianCustomLogic(os, Debian)
  doAssert os.release == "10"
  doAssert os.codename == "buster"

block fedora:
  var os = new OsInfo
  fedoraCustomLogic(os, Fedora)
  doAssert os.release == "17"
  doAssert os.codename == "Beefy Miracle"