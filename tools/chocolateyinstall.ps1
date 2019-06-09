$packageName    = 'docker-machine'
$url            = 'https://github.com/docker/machine/releases/download/v0.16.1/docker-machine-Windows-i386.exe'
$checksum       = '12de35cfb21898dc5a72fec265d660bed5236f2198c6ffed78cda275e68e2cba'
$url64          = 'https://github.com/docker/machine/releases/download/v0.16.1/docker-machine-Windows-x86_64.exe'
$checksum64     = '2d3b55682b704f9d61b74d1db9b4f6ddbb4f80302c4333aef7e5dc746049b1d9'
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
