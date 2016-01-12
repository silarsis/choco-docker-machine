$packageName    = 'docker-machine'
$url            = 'https://github.com/docker/machine/releases/download/v0.5.6/docker-machine_windows-386.exe'
$checksum       = 'a7601f0a8fa6fd7bd6dac9f6c45b8359'
$url64          = 'https://github.com/docker/machine/releases/download/v0.5.6/docker-machine_windows-amd64.exe'
$checksum64     = '45d138c559b184337b0fad59f1d48d67'
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
