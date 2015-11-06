"Running tests"
$ErrorActionPreference = "Stop"
$version = $env:APPVEYOR_BUILD_VERSION -replace('\.[^.\\/]+$')

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
. choco install -y docker-machine -source .

"TEST: Version of binary should match"
if (-Not $(docker-machine --version).Contains("version $version ")) {
  Write-Error "FAIL: Wrong version of docker-machine installed!"
}

"TEST: Create a machine with driver none should work"
. docker-machine create -d none --url http://127.0.0.1:2376 test

"TEST: List should show the machine"
. docker-machine ls
if ($(docker-machine ls).Contains("test   -        none             http://127.0.0.1:2376")) {
  Write-Error "FAIL: machine not found"
}

"TEST: Uninstall show remove the binary"
. choco uninstall docker-machine
try {
  . docker-machine
  Write-Error "FAIL: docker-machine binary still found"
} catch {
  Write-Host "PASS: docker-machine not found"
}

"TEST: Finished"
