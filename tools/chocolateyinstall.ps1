$packageName    = 'docker-machine'
$url            = 'https://github.com/docker/machine/releases/download/v0.12.0/docker-machine-Windows-i386.exe'
$checksum       = '253e63571ce613d4ab835c4199ffffaa1daf1dbc8bcf284995bc60de1fa67d8c'
$url64          = 'https://github.com/docker/machine/releases/download/v0.12.0/docker-machine-Windows-x86_64.exe'
$checksum64     = 'ba2eeee57aa1774e9841ebcb918212ea559e08587e13b152f3f2ca7d9c6f7a25'
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
