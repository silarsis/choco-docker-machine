$packageName    = 'docker-machine'
$url            = 'https://github.com/docker/machine/releases/download/v0.11.0/docker-machine-Windows-i386.exe'
$checksum       = 'e4ebdb1ea127659e34513e43559e7d964ca365236f652df613ae8671682db44f'
$url64          = 'https://github.com/docker/machine/releases/download/v0.11.0/docker-machine-Windows-x86_64.exe'
$checksum64     = '540a98ad93f52dd1529a4803ef70a5847a97dc1a1f612cdf67201c26cf80c0cc'
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
