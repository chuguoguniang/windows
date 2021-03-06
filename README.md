# Setting-up scripts for Windows 10

[TOC levels=1-3]: # ""

- [Setting-up scripts for Windows 10](#setting-up-scripts-for-windows-10)
  - [Get ISO](#get-iso)
  - [Install, active and update Windows](#install-active-and-update-windows)
  - [Enable some optional features of Windows 10](#enable-some-optional-features-of-windows-10)
  - [WSL 2](#wsl-2)
  - [Ubuntu 18.04](#ubuntu-1804)
  - [Install `winget` and `Windows Terminal`](#install-winget-and-windows-terminal)
  - [Optional: Adjusting Windows](#optional-adjusting-windows)
  - [Optional: winget-pkgs](#optional-winget-pkgs)
  - [Optional: Windows 7 games](#optional-windows-7-games)
  - [Optional: Packages Managements](#optional-packages-managements)
  - [Optional: Rust and C/C++](#optional-rust-and-cc)
  - [Directory Organization](#directory-organization)


Most following commands should be pasted to `Powershell`.

## Get ISO

Some features of Windows 10 (20H1) are needed here, so download [Windows 10 Enterprise VL Insider
Preview](https://docs.microsoft.com/en-us/windows-insider/flight-hub/) first:

* Build 19041.84
* English or Chinese Simplified
* 64-bit

## Install, active and update Windows

* Enable Virtualization in BIOS or VM

* Active Windows 10 via KMS, <http://kms.nju.edu.cn/>

* Update Windows and then check system info

```ps1
# simple
winver

# details
systeminfo

```

After Windows updating, Windows version is 19041.264 as my current date.

## Enable some optional features of Windows 10

* Mount Windows ISO to D: (or others)

* Open PowerShell as an Administrator

```ps1
# .Net 2.5 and 3
DISM /Online /Enable-Feature /FeatureName:NetFx3 /All /LimitAccess /Source:D:\sources\sxs

# SMB 1
Enable-WindowsOptionalFeature -Online -FeatureName SMB1Protocol -All

```

## WSL 2

* Follow instructions of [this page](https://docs.microsoft.com/en-us/windows/wsl/wsl2-install)

* Open PowerShell as an Administrator

```ps1
# WSL
Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux

# HyperV
Enable-WindowsOptionalFeature -Online -FeatureName VirtualMachinePlatform

```

Update the [WSL 2](https://docs.microsoft.com/en-us/windows/wsl/wsl2-kernel) Linux kernel if
necessarily.

Restart, then set WSL 2 as default.

```ps1
wsl --set-default-version 2

```

## Ubuntu 18.04

Search `bash` in Microsoft Store or use the following command lines.

```ps1
if (!(Test-Path Ubuntu.appx -PathType Leaf)) {
    Invoke-WebRequest -Uri https://aka.ms/wsl-ubuntu-1804 -OutFile Ubuntu.appx -UseBasicParsing
}
Add-AppxPackage .\Ubuntu.appx

```

Launch the distro from the Start menu, wait for a minute or two for the installation to complete,
and set up a new Linux user account.

The following command verifies the status of WSL:

```ps1
wsl -l -v

```

## Install `winget` and `Windows Terminal`

```ps1
if (!(Test-Path Microsoft.WindowsTerminal.msixbundle -PathType Leaf)) {
    Invoke-WebRequest 'https://github.com/microsoft/winget-cli/releases/download/v0.1.4331-preview/Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.appxbundle' -OutFile 'Microsoft.DesktopAppInstaller.appxbundle'
}
Add-AppxPackage -path Microsoft.DesktopAppInstaller.appxbundle

winget install Terminal

winget install -e --id Git.Git

```

## Optional: Adjusting Windows

```ps1
mkdir -p ~/Scripts
cd ~/Scripts
git clone --recursive https://github.com/wang-q/windows

cd ~/Scripts/windows/setup
powershell.exe -NoProfile -ExecutionPolicy Bypass -File "Win10-Initial-Setup-Script/Win10.ps1" -include "Win10-Initial-Setup-Script/Win10.psm1" -preset "Default.preset"

```

Get updates from Microsoft Store.

## Optional: winget-pkgs

```ps1
# programming
winget install AdoptOpenJDK.OpenJDK
winget install Python.Python
winget install 'Strawberry Perl'
winget install cmake

# utils
winget install everything
winget install Bandizip
winget install Rufus
winget install QuickLook

# develpment
winget install 'GitHub Desktop'
winget install WinSCP
winget install vscode
winget install 'Beyond Compare 4'

# GUI
winget install Firefox
winget install 'Adobe Acrobat Reader DC'

```

## Optional: Windows 7 games

<https://winaero.com/download.php?view.1836>

## Optional: Packages Managements

* [`scoop.md`](setup/scoop.md)
* [`msys2.md`](setup/msys2.md)

## Optional: Rust and C/C++

* [`rust.md`](setup/rust.md)

## Directory Organization

* [`packer/`](packer/): Scirpts for building a Windows 10 box for Parallels.

* [`setup/`](setup/): Scirpts for setting-up Windows.

