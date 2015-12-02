$packageName    = 'docker-machine'
$url            = 'https://github.com/docker/machine/releases/download/v0.5.2/docker-machine_windows-386.zip'
$checksum       = '93d5603098d0b4a79ffd91939f8adc02'
$url64          = 'https://github.com/docker/machine/releases/download/v0.5.2/docker-machine_windows-amd64.zip'
$checksum64     = '533759e13d66a7d5d536a8a96b5e1227'
$checksumType   = 'md5'
$checksumType64 = 'md5'
$unzipLocation = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

Install-ChocolateyZipPackage "docker-machine" "$url" "$unzipLocation" "$url64" `
 -checksum $checksum -checksumType $checksumType -checksum64 $checksum64 -checksumType64 $checksumType64
