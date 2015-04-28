# chocolatey installer for docker-machine

This is a chocolatey package for docker-machine. Please see MAINTENANCE.md
for information on how to upkeep it.

To use, simply run `choco install docker-machine -y` (this may need a `-pre`
flag also if it hasn't gone through moderation).

# Links

* https://github.com/docker/machine - docker-machine
* https://github.com/ahmetalpbalkan/docker-chocolatey - docker client choco package, inspiration for this package

# Known Issues

* Currently uninstalling will leave the various certificates etc there, rather than remove them. This may be argued to be a feature.
