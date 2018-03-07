$packageName    = 'docker-machine'
$url            = 'https://github.com/docker/machine/releases/download/v0.14.0/docker-machine-Windows-i386.exe'
$checksum       = 'a05be607a58ea885adecdfe66bc6681e0e44a472d7225a94e35e6a75cf630cae'
$url64          = 'https://github.com/docker/machine/releases/download/v0.14.0/docker-machine-Windows-x86_64.exe'
$checksum64     = '2b01f844d77df2fca9347f940b46fe6361b3d0ddb38ae22c982004d86f3c5362'
$checksumType   = 'sha256'
$checksumType64 = 'sha256'

$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packageDir  = "$(Split-Path -parent $toolsDir)"
$installDir  = Join-Path "$packageDir" "bin"
$installBin  = "${packageName}.exe"
$installPath = Join-Path "$installDir" "$installBin"

if ([System.IO.Directory]::Exists("$env:ChocolateyInstall\lib\docker-machine")) {
  if ([System.IO.Directory]::Exists("$env:ChocolateyInstall\lib\docker-machine\tools")) {
    # clean old plugins and ignore files
    Write-Host "Removing old docker-machine plugins"
    Remove-Item "$env:ChocolateyInstall\lib\docker-machine\tools\docker-machine-*.*"
  }
}

New-Item -ItemType Directory -Force -Path "$installDir"
Get-ChocolateyWebFile "$packageName" "$installPath" "$url" "$url64" -checksum "$checksum" -checksumType "$checksumType" -checksum64 "$checksum64" -checksumType64 "$checksumType64"
