$packageName    = 'docker-machine'
$url            = 'https://github.com/docker/machine/releases/download/v0.16.2/docker-machine-Windows-i386.exe'
$checksum       = '2b67d7b6cd95983bdb01da472a541052f3ca236950354c7e76f215fbf9188745'
$url64          = 'https://github.com/docker/machine/releases/download/v0.16.2/docker-machine-Windows-x86_64.exe'
$checksum64     = 'dcf774857069749b5d973f85b15d926544a7c5556c3478c45b4f35cf86494130'
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
