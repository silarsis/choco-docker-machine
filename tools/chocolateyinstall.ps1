$packageName    = 'docker-machine'
$url            = 'https://github.com/docker/machine/releases/download/v0.13.0/docker-machine-Windows-i386.exe'
$checksum       = '564c57e251ffa61fb6d03157f67a8c3cc10ecaaf592e589aca9307b6357561fc'
$url64          = 'https://github.com/docker/machine/releases/download/v0.13.0/docker-machine-Windows-x86_64.exe'
$checksum64     = 'ec304126dac48873e5f52c0df0d8333be4bd653a37ba1cf78793da0e858db9e3'
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
