$packageName    = 'docker-machine'
$url            = 'https://github.com/docker/machine/releases/download/v0.16.0/docker-machine-Windows-i386.exe'
$checksum       = '475cb2b894201653cda30ae6955f8c5d9cf9d8fc6d171dbc3995bc0ef9589fa3'
$url64          = 'https://github.com/docker/machine/releases/download/v0.16.0/docker-machine-Windows-x86_64.exe'
$checksum64     = '90ec9329ea8657791e421fc8c74da75ebda567786cd4a50266f35d895ecd8dea'
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

Get-ChocolateyWebFile `
  -PackageName    $packageName `
  -FileFullPath   $installPath `
  -Url            $url `
  -Url64bit       $url64 `
  -Checksum       $checksum `
  -Checksum64     $checksum64 `
  -ChecksumType   $checksumType `
  -ChecksumType64 $checksumType64
