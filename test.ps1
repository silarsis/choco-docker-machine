param(
  [string]$cpu
)

if (!$cpu) {
  $cpu = "x64"
}
if ($cpu -eq "x86") {
  $options = "-forcex86"
}

"Running tests for $cpu"
$ErrorActionPreference = "Stop"

if ($env:APPVEYOR_BUILD_VERSION) {
  # run in CI
  $version = $env:APPVEYOR_BUILD_VERSION -replace('\.[^.\\/]+$')
} else {
  # run manually
  [xml]$spec = Get-Content docker-machine.nuspec
  $version = $spec.package.metadata.version
}

"TEST: Version $version in docker-machine.nuspec file should match"
[xml]$spec = Get-Content docker-machine.nuspec
if ($spec.package.metadata.version.CompareTo($version)) {
  Write-Error "FAIL: rong version in nuspec file!"
}

"TEST: Package should contain only install script"
Add-Type -assembly "system.io.compression.filesystem"
$zip = [IO.Compression.ZipFile]::OpenRead("$pwd\docker-machine.$version.nupkg")
if ($zip.Entries.Count -ne 5) {
  Write-Error "FAIL: Wrong count in nupkg!"
}
$zip.Dispose()

"TEST: Installation of package should work"
. choco install -y docker-machine $options -source .

"TEST: Version of binary should match"
if (-Not $(docker-machine --version).Contains("version $version,")) {
  Write-Error "FAIL: Wrong version of docker-machine installed!"
}

"TEST: Create a machine with driver none should work"
. docker-machine create -d none --url http://1.2.3.4:2375 test

"TEST: List should show the machine"
. docker-machine ls
if ($(docker-machine ls).Contains("test   -        none             http://127.0.0.1:2376")) {
  Write-Error "FAIL: machine not found"
}

"TEST: Remove the machine should work"
. docker-machine rm test

"TEST: Uninstall show remove the binary"
. choco uninstall -y docker-machine
try {
  . docker-machine
  Write-Error "FAIL: docker-machine binary still found"
} catch {
  Write-Host "PASS: docker-machine not found"
}

"TEST: Update from older version to single binary version works"
. choco install -y docker-machine $options -version 0.5.2
. choco install -y docker-machine $options -source . -version $version
. ls C:\programdata\chocolatey\lib\docker-machine
. ls C:\programdata\chocolatey\lib\docker-machine\tools
$numExe = (get-childitem -path C:\programdata\chocolatey\lib\docker-machine\tools\ | where { $_.extension -eq ".exe" }).Count
Write-Host "numExe $numExe"
$numIgnore = (get-childitem -path C:\programdata\chocolatey\lib\docker-machine\tools\ | where { $_.extension -eq ".ignore" }).Count
Write-Host "numIgnore $numIgnore"
if ($numExe - 1 -ne $numIgnore) {
  Write-Error "FAIL: Wrong number of ignored plugins!"
}
if ($numExe -ne 1) {
  Write-Error "FAIL: There mustn't be more than one exe file!"
}
if ($numIgnore -ne 0) {
  Write-Error "FAIL: There mustn't be any ignored plugins!"
}

"TEST: Uninstall show remove the binary"
. choco uninstall -y docker-machine
try {
  . docker-machine
  Write-Error "FAIL: docker-machine binary still found"
} catch {
  Write-Host "PASS: docker-machine not found"
}

"TEST: Finished"
