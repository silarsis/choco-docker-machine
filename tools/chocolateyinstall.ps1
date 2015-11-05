$packageName    = 'docker-machine'
$url            = 'https://github.com/docker/machine/releases/download/v0.5.0/docker-machine_windows-386.zip'
$checksum       = 'cc296a14870263c5bd5417b3b997f324'
$url64          = 'https://github.com/docker/machine/releases/download/v0.5.0/docker-machine_windows-amd64.zip'
$checksum64     = 'f23e4fa31a49c9ca969e909f6d5efd9f'
$checksumType   = 'md5'
$checksumType64 = 'md5'
$unzipLocation = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

Install-ChocolateyZipPackage "docker-machine" "$url" "$unzipLocation" "$url64" `
 -checksum $checksum -checksumType $checksumType -checksum64 $checksum64 -checksumType64 $checksumType64
