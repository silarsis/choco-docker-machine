$packageName    = 'docker-machine'
$url            = 'https://github.com/docker/machine/releases/download/v0.2.0/docker-machine_windows-386.exe'
$checksum       = 'c7c957dd0e8ce34a1cedc752447e217e'
$url64          = 'https://github.com/docker/machine/releases/download/v0.2.0/docker-machine_windows-amd64.exe'
$checksum64     = '5e8935f6ab2f6627b4163cb4c68191ef'
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