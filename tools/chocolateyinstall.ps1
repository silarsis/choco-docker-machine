$packageName    = 'docker-machine'
$url            = 'https://github.com/docker/machine/releases/download/v0.12.1/docker-machine-Windows-i386.exe'
$checksum       = 'c349b6389c369fc5ecf2632fd4f4975fbbaeffb617f3f0f0612556bebd515f54'
$url64          = 'https://github.com/docker/machine/releases/download/v0.12.1/docker-machine-Windows-x86_64.exe'
$checksum64     = '492d7317432283eca96028319205b112db8b519b5ba4d5b2d33e54c1c8fc3c66'
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
