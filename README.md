# Windows Dotfiles

My windows dotfiles.

Managed by [Dotted](https://volllly.github.io/Dotted/).

# Installation

## Chocolatey
Open PowerShell as admin

```powershell
$ Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
$
$ choco install gsudo
```

## Dotfiles

```powershell

$ Install-Module Dotted powershell-yaml npm-completion oh-my-posh posh-git PSFzf Terminal-Icons z
```

Reopen PowerShell
```powershell
$ Clone-Dots git@github.com:magicmonty/dotfiles-windows.git
$ Install-Dots
$ Link-Dots
```

