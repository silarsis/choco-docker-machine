$packageName    = 'docker-machine'
$url            = 'https://github.com/docker/machine/releases/download/v0.5.4/docker-machine_windows-386.exe'
$checksum       = 'ab53930550dc9cc269106651af1ead63'
$url64          = 'https://github.com/docker/machine/releases/download/v0.5.4/docker-machine_windows-amd64.exe'
$checksum64     = '7735afc2f5f431d9b685b74fc9884c59'
$checksumType   = 'md5'
$checksumType64 = 'md5'

$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packageDir  = "$(Split-Path -parent $toolsDir)"
$installDir  = Join-Path "$packageDir" "bin"
$installBin  = "${packageName}.exe"
$installPath = Join-Path "$installDir" "$installBin"

New-Item -ItemType Directory -Force -Path "$installDir"
Get-ChocolateyWebFile "$packageName" "$installPath" "$url" "$url64" -checksum "$checksum" -checksumType "$checksumType" -checksum64 "$checksum64" -checksumType64 "$checksumType64"
