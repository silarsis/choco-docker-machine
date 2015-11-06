# Maintainer's Guide

This document explains how to maintain the Chocolatey package
for docker-machine for Windows.

## How it works

This Chocolatey package is designed to download the docker-machine
client binary (.exe) and place it in `%PATH%`.

Main installation script is written in PowerShell and is in
`tools\chocolateyInstall.ps1`.

## Setting up development environment.

1. Install Chocolatey (http://chocolatey.org) on your
   Windows machine.
3. Clone this repository.

## Making a new release

#### 1. Update `docker.nuspec`

You need to update the value in `<version>` tag with
the official docker-machine version string correctly.

#### 2. Update `tools\chocolateyInstall.ps1`

You need to update `$url`, `$url64`, `$checksum` and `$checksum64`
variables below.

* You can get the urls and checksums from the "release" tab at
  https://github.com/docker/machine/releases

Example:

$url            = 'https://github.com/docker/machine/releases/download/v0.2.0/docker-machine_windows-386.exe'
$checksum       = 'c7c957dd0e8ce34a1cedc752447e217e'
$url64          = 'https://github.com/docker/machine/releases/download/v0.2.0/docker-machine_windows-amd64.exe'
$checksum64     = '5e8935f6ab2f6627b4163cb4c68191ef'

#### 4. Update appveyor.yml

You need to update `version` with the official docker-machine version.

#### 5. Git push

Push your changes to GitHub and check the AppVeyor build. See the AppVeyor build section below for details.

    git push

#### 6. Git tag

After a successfull AppVeyor build tag the sources and push the new tag to GitHub. This step builds and tests the package and pushes the new package to Chocolatey.

    git tag 0.5.0
    git push --tags

## AppVeyor build

The docker-machine chocolatey package is built with the AppVeyor CI service.

### Build steps

#### Package it

Open a command line window and run the following command in the folder
where `docker.nuspec` exists:

    cpack

It might show some warnings, but if there's no errors, it's completed.
Check if a `.nupkg` file exists in the same directory after this.

### Test steps

#### Install it locally

First, make sure `docker-machine` is not installed (or not in %PATH%). (Cleanest
way to do this is to run inside a clean virtual machine but that's not
always necessary).

Use the following command in powershell to install the nupkg locally, assuming
you're currently in the :

    choco install docker-machine -source $pwd

> NOTE: If the version is pre-release (e.g. a RC), you need to provide
> `-pre` flag to the command above as well.

The command above must be installing docker-machine correctly. Run `docker-machine -v`
to verify if it is installed.

#### Run further tests

Run the following commands to verify uninstallation works:

    choco uninstall docker-machine
    docker-machine // shouldn't work

See the script `test.ps1` for all tests that run on AppVeyor.

### Deploy steps

#### Push the package

You need your API key to push Chocolatey packages.
Go to http://chocolatey.org and log in.

Go to your account settings and show your API key.

Copy the example command with your key

    choco apiKey -k your-api-key -source https://chocolatey.org/

Push the package

    choco push docker-machine.0.5.0.nupkg

While in moderation you can push the package again to fix errors in the description or installation script etc.

## Approval Process

If you are submitting a stable version, Chocolatey moderators need to
allow the package before it is published. This usually takes a day or
so. (If it takes any longer, ping @ferventcoder).

If a package is **pre-release** (i.e. has `-rc1`, `-beta` like strings
in its version) then the submission **does not need moderator approval**
and you will see a message like this:

> "*This package is exempt from moderation. While it is likely safe for you,
> there is more risk involved.*"

The difference is, users install stable packages with:

    choco install docker-machine

and pre-release packages with:

    choco install docker-machine -pre

command and Chocolatey usually prompts users with more confirmation
messages if the package is pre-release.

## Profit

Package will be published at https://chocolatey.org/packages/docker-machine
