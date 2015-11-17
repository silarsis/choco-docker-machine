$packageName    = 'docker-machine'
$url            = 'https://github.com/docker/machine/releases/download/v0.5.1/docker-machine_windows-386.zip'
$checksum       = 'ca6c2e5cc34977b1fb590070557bdbfa'
$url64          = 'https://github.com/docker/machine/releases/download/v0.5.1/docker-machine_windows-amd64.zip'
$checksum64     = 'd634acb92fe4b1c73f4b7dec2924291e'
$checksumType   = 'md5'
$checksumType64 = 'md5'
$unzipLocation = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

Install-ChocolateyZipPackage "docker-machine" "$url" "$unzipLocation" "$url64" `
 -checksum $checksum -checksumType $checksumType -checksum64 $checksum64 -checksumType64 $checksumType64
