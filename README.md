# Windows Dotfiles

My windows dotfiles.

Managed by [Dotted](https://volllly.github.io/Dotted/).

# Installation

## Chocolatey
Open PowerShell as admin

```powershell
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
```

```powershell
$ cinst ChocolateyGui gsudo
```

### Dotfiles

Open PowerShell as Admin
```powershell

$ Install-Module Dotted
$ Install-Module powershell-yaml
```

Open PowerShell normally
```powershell
$ Clone-Dots git@github.com:magicmonty/dotfiles-windows.git
$ Install-Dots
$ Link-Dots
```
