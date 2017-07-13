$packageName    = 'docker-machine'
$url            = 'https://github.com/docker/machine/releases/download/v0.12.2/docker-machine-Windows-i386.exe'
$checksum       = '52b1d057d76bbb4407f65c2e05dd7ff85a42dfae9c208f122b08f33ef784ae59'
$url64          = 'https://github.com/docker/machine/releases/download/v0.12.2/docker-machine-Windows-x86_64.exe'
$checksum64     = 'f99f200de796a4b3b01eab4bd71a461faec792776d74fbc7727e77729bb32ae3'
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
