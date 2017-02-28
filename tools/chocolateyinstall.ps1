$packageName    = 'docker-machine'
$url            = 'https://github.com/docker/machine/releases/download/v0.10.0/docker-machine-Windows-i386.exe'
$checksum       = '428def25cc6bb60c6d1b341ced0200aa3281794d661dd8c57a8d54357a532541'
$url64          = 'https://github.com/docker/machine/releases/download/v0.10.0/docker-machine-Windows-x86_64.exe'
$checksum64     = 'd923120bd029fb8a79025288fbc33ad65f7c7c072272aa95ad7d5d5bef0f1434'
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
