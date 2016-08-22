$packageName    = 'docker-machine'
$url            = 'https://github.com/docker/machine/releases/download/v0.8.1/docker-machine-Windows-i386.exe'
$checksum       = 'efdd1f80db4db0828525e074b2825c27'
$url64          = 'https://github.com/docker/machine/releases/download/v0.8.1/docker-machine-Windows-x86_64.exe'
$checksum64     = '28d193966e6e1f5d7b5aad63a6f217b8'
$checksumType   = 'md5'
$checksumType64 = 'md5'

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
