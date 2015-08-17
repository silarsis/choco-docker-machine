$packageName    = 'docker-machine'
$url            = 'https://github.com/docker/machine/releases/download/v0.4.0/docker-machine_windows-386.exe'
$checksum       = 'afaf538ffbda25284235e2ab226c4542'
$url64          = 'https://github.com/docker/machine/releases/download/v0.4.0/docker-machine_windows-amd64.exe'
$checksum64     = '2112f512f9beb5df31e1e224a14f3567'
$checksumType   = 'md5'
$checksumType64 = 'md5'
$validExitCodes = @(0)

$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packageDir  = "$(Split-Path -parent $toolsDir)"
$installDir  = Join-Path "$packageDir" "bin"
$installBin  = "${packageName}.exe"
$installPath = Join-Path "$installDir" "$installBin"

New-Item -ItemType Directory -Force -Path "$installDir"
Get-ChocolateyWebFile "$packageName" "$installPath" "$url" "$url64" -checksum "$checksum" -checksumType "$checksumType" -checksum64 "$checksum64" -checksumType64 "$checksumType64"
