$packageName    = 'docker-machine'
$url            = 'https://github.com/docker/machine/releases/download/v0.3.0/docker-machine_windows-386.exe'
$checksum       = '90d265d8a24d7266538727ced4774348'
$url64          = 'https://github.com/docker/machine/releases/download/v0.3.0/docker-machine_windows-amd64.exe'
$checksum64     = 'e3a967d2dad5cc0628c8f9a428f11a75'
$checksumType   = 'md5'
$checksumType64 = 'md5'
$validExitCodes = @(0)

$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packageDir  = "$(Split-Path -parent $toolsDir)"
$installDir  = Join-Path "$packageDir" "bin"
$installBin  = "${packageName}.exe"
$installPath = Join-Path "$installDir" "$installBin"

New-Item -ItemType Directory -Force -Path "$installDir"
Get-ChocolateyWebFile "$packageName" "$installPath" "$url" "$url64" -checksum "$checksum" -checksumType "$checksumType" -checksum64 "$checksum64" -checksumType64 "$checksumType64"
