$packageName    = 'docker-machine'
$url            = 'https://github.com/docker/machine/releases/download/v0.15.0/docker-machine-Windows-i386.exe'
$checksum       = '4a73899dd230b748282d70c3d19f3baa8485005a7c36f5fdec9bc9fe5d386de5'
$url64          = 'https://github.com/docker/machine/releases/download/v0.15.0/docker-machine-Windows-x86_64.exe'
$checksum64     = '5af3952cbd571b37f8fd74fa8269bc2d8c38c521ffb0202cb4a71a315374f0df'
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
