using namespace System.Management.Automation
using namespace System.Management.Automation.Language

Import-Module -Name Terminal-Icons

# For Git Autocompletion
Import-Module -Name posh-git
Import-Module -Name npm-completion

$env:PATH = "$env:LOCALAPPDATA\Programs\oh-my-posh\bin;" + $env:PATH 

if ($host.Name -eq 'ConsoleHost')
{
  Import-Module PSReadline  

  Set-PSReadlineKeyHandler -Key Ctrl+Delete    -Function KillWord
  Set-PSReadlineKeyHandler -Key Ctrl+Backspace -Function BackwardKillWord
  Set-PSReadlineKeyHandler -Key Shift+Backspace -Function BackwardKillWord
  Set-PSReadlineKeyHandler -Key UpArrow        -Function HistorySearchBackward
  Set-PSReadlineKeyHandler -Key DownArrow      -Function HistorySearchForward
  Set-PSReadlineKeyHandler -Key Tab            -Function Complete

  # History as browsable list
  Set-PSReadLineOption -HistorySearchCursorMovesToEnd
  if ($host.Version.Major -gt 5)
  {
    Set-PSReadLineOption -PredictionViewStyle ListView
    Set-PSReadLineOption -PredictionSource History
  }
  Set-PSReadLineOption -EditMode Windows
  Remove-PSReadlineKeyHandler 'Ctrl+r'

  Set-PSReadLineKeyHandler -Key Ctrl+r `
    -BriefDescription SearchHistory `
    -LongDescription "Search History with FZF" `
    -ScriptBlock {
    $command = Get-Content (Get-PSReadLineOption).HistorySavePath | awk '!a[$0]++' | fzf --tac
    [Microsoft.PowerShell.PSConsoleReadLine]::Insert($command)
  }

  # Build a directory with <C-S-b>
  Set-PSReadLineKeyHandler -Key Ctrl+Shift+b `
    -BriefDescription BuildCurrentDirectory `
    -LongDescription "Build the current directory" `
    -ScriptBlock {
    [Microsoft.PowerShell.PSConsoleReadLine]::RevertLine()
    [Microsoft.PowerShell.PSConsoleReadLine]::Insert("dotnet build")
    [Microsoft.PowerShell.PSConsoleReadLine]::AcceptLine()
  }

  # Run tests directory with <C-S-t>
  Set-PSReadLineKeyHandler -Key Ctrl+Shift+t `
    -BriefDescription TestCurrentDirectory `
    -LongDescription "Run tests in the current directory" `
    -ScriptBlock {
    [Microsoft.PowerShell.PSConsoleReadLine]::RevertLine()
    [Microsoft.PowerShell.PSConsoleReadLine]::Insert("dotnet test")
    [Microsoft.PowerShell.PSConsoleReadLine]::AcceptLine()
  }

  Set-PSReadlineKeyHandler -Key Ctrl+d -Function DeleteCharOrExit
}


[Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8

function Set-Location-Cms ()
{ Set-Location C:\Projects\tdsuite-cms 
}
Set-Alias cdc Set-Location-Cms

function Set-Location-AngularFrontend
{ Set-Location Code\Web\ClientApp 
}
Set-Alias cdcw Set-Location-AngularFrontend

function Set-Location-BackToRoot
{ Set-Location ..\..\.. 
}
Set-Alias cdb Set-Location-BackToRoot

function Set-Location-Development
{ Set-Location C:\Projects 
}
Set-Alias cdd Set-Location-Development

function Set-Location-Dir-Up
{ Set-Location .. 
}
Set-Alias .. Set-Location-Dir-Up

function Open-Explorer ([string]$Directory)
{ explorer.exe $Directory 
}
Set-Alias e Open-Explorer

function Open-Explorer-Here
{ e . 
}
Set-Alias e. Open-Explorer-Here

function Open-SourceTree ([string]$Directory)
{ 
  if ($Directory)
  {
    Start-Process $env:LOCALAPPDATA\SourceTree\SourceTree.exe "-f $Directory status"
  } else
  {
    Start-Process $env:LOCALAPPDATA\SourceTree\SourceTree.exe  "-f $PWD status"
  }
}
Set-Alias st Open-SourceTree

function Open-VSCode ([string]$Directory)
{ code $Directory 
}
Set-Alias c Open-VSCode

function Open-VSCode-Here
{ c . 
}
Set-Alias c. Open-VSCode-Here

function Kill-All ([string]$ProcessName)
{ pskill $ProcessName 
}
Set-Alias kil Kill-All

function Kill-All-MSBuild
{ Kill-All MSBuild.exe 
}
Set-Alias kb Kill-All-MSBuild

function Search-Todo
{ rg -tcsharp TODO 
}
Set-Alias todo Search-Todo

function Search-Fixme
{ rg -tcsharp TODO 
}
Set-Alias fixme Search-Fixme

function vi
{ nvim $args 
}
Set-Alias vim vi 
Set-Alias v vi 

Set-Alias l ls

Set-Alias lg lazygit

function  Edit-Profile
{ vi $profile.CurrentUserCurrentHost 
}

# Paket
function pi
{ .paket\paket.exe install 
}
function pu
{ .paket\paket.exe update 
}

# Git
function gg
{ C:\Tools\lazygit.exe 
}
function gs
{ git status $args 
}
function gst
{ git st $args 
}
function gstu
{ git stu $args 
}
function gci
{ git ci $args 
}
function gcz
{ git cz $args
}
function gcim
{ git cim $args 
}
function gcima
{ git cima $args 
}
function gtype
{ git type $args 
}
function gdump
{ git dump $args 
}
function amend
{ git amend $args 
}
function reword
{ git reword $args 
}
function gundo
{ git undo $args 
}
function grh
{ git rh $args 
}
function ga
{ git a $args 
}
function gaa
{ git aa $args 
}
function unstage
{ git unstage $args 
}
function gco
{ git co $args 
}

function yi
{ yarn install 
}
function yif
{ yarn install --frozen-lockfile 
}
function ngs
{ ng serve 
}
function ngso
{ ng serve --open 
}
function gom
{ git co main 
}
function goma
{ git co master 
}
function god
{ git co development 
}
function gof
{ git co -b features/$args 
}
function gbr
{ git br $args 
}
function gb
{ git b $args 
}
function gbrs
{ git brs $args 
}
function grv
{ git rv $args 
}
function gd
{ git d $args 
}
function gdf
{ git df $args 
}
function gdc
{ git dc $args 
}
function preview
{ git preview $args 
}
function gdt
{ git dt $args 
}
function gmt
{ git mt $args 
}
function gunresolve
{ git unresolve $args 
}
function ll
{ git ll $args 
}
function gl
{ git l $args 
}
function gld
{ git ld $args 
}
function ggl
{ git gl $args 
}
function glog
{ git glog $args 
}
function ghist
{ git hist $args 
}
function gwho
{ git who $args 
}
function wdw
{ git wdw $args 
}
function mostchanged
{ git most-changed $args 
}
function gcleanf
{ git cleanf $args 
}
function gtags
{ git tags $args 
}
function gtagm
{ git tagm $args 
}
function gtagd
{ git tagd $args 
}
function gpush
{ git push $args 
}
function gpushf
{ git push --force-with-lease $args 
}
function gpull
{ git pull $args 
}
function gls
{ git log --graph --oneline --decorate --all --color=always | fzf --ansi +s --preview='git show --color=always {2}'  --bind='pgdn:preview-page-down'  --bind='pgup:preview-page-up'  --bind='enter:execute:git show --color=always {2}'  --bind='ctrl-x:execute:git checkout {2} .' 
}
function go
{ git checkout $args 
}
function rtags
{
  git tag -d $(git tag)
  git fetch --tags
}
function gra
{ git rebase --abort $args 
}
function grc
{ git rebase --continue $args 
}
function grm
{ git rebase main 
}
function grma
{ git rebase master 
}
function grd
{ git rebase development 
}
function hello
{ utt hello 
}
function t
{ utt add $args 
}

if ($Host.Version.Major -gt 6)
{
  function report
  { utt report 
  }
  Set-Alias r report
}

function grep
{
  $count = @($input).Count
  $input.Reset()

  if ($count)
  {
    $input | rg.exe --hidden $args
  } else
  {
    rg.exe --hidden $args
  }
}

# Chocolatey profile
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile))
{
  Import-Module "$ChocolateyProfile"
}

Register-ArgumentCompleter -Native -CommandName winget -ScriptBlock {
  param($wordToComplete, $commandAst, $cursorPosition)
  [Console]::InputEncoding = [Console]::OutputEncoding = $OutputEncoding = [System.Text.Utf8Encoding]::new()
  $Local:word = $wordToComplete.Replace('"', '""')
  $Local:ast = $commandAst.ToString().Replace('"', '""')
  winget complete --word="$Local:word" --commandline "$Local:ast" --position $cursorPosition | ForEach-Object {
    [System.Management.Automation.CompletionResult]::new($_, $_, 'ParameterValue', $_)
  }
}

Register-ArgumentCompleter -Native -CommandName dotnet -ScriptBlock {
  param($wordToComplete, $commandAst, $cursorPosition)
  dotnet complete --position $cursorPosition "$wordToComplete" | ForEach-Object {
    [System.Management.Automation.CompletionResult]::new($_, $_, 'ParameterValue', $_)
  }
}

## Invoke the specified batch file (and parameters) but also propagate any
## environment variable changes back to the PowerShell environment that
## called it
function Invoke-CmdScript()
{
  param([string] $script, [string] $parameters)
  $tempFile = [IO.Path]::GetTempFileName()

  ## Store the output of cmd.exe. We also ask cmd.exe to output
  ## the environment rable after the batch file completes 
  cmd /c "`"$script`" $parameters > NUL && set > `"$tempFile`" "

  ## Go through the environment variables in the temp file
  ## For each of them, set the variable in our local environment
  Get-Content $tempFile | Foreach-Object {
    if($_ -match "^(.*?)=(.*)$")
    { 
      Set-Content "env:\$($matches[1])" $matches[2] 
    }
  }

  Remove-Item $tempFile
}

class Software
{
  [string]$Name
  [string]$Id
  [string]$Version
  [string]$AvailableVersion
}

function Update-Winget()
{

  $upgradeResult = winget upgrade | Out-String
  $lines = $upgradeResult.Split([Environment]::NewLine)

  # Find the line that starts with Name, it contains the header
  $fl = 0
  while (-not $lines[$fl].StartsWith("Name"))
  {
    $fl++
  }

  # Line $i has the header, we can find char where we find ID and Version
  $idStart = $lines[$fl].IndexOf("ID")
  $versionStart = $lines[$fl].IndexOf("Version")
  $availableStart = $lines[$fl].IndexOf("Verfügbar")
  $sourceStart = $lines[$fl].IndexOf("Quelle")

  # Now cycle in real package and split accordingly
  $upgradeList = @()
  For ($i = $fl + 1; $i -le $lines.Length; $i++) 
  {
    $line = $lines[$i]
    if ($line.Length -gt ($availableStart + 1) -and -not $line.StartsWith('-'))
    {
      $name = $line.Substring(0, $idStart).TrimEnd()
      $id = $line.Substring($idStart, $versionStart - $idStart).TrimEnd()
      $version = $line.Substring($versionStart, $availableStart - $versionStart).TrimEnd()
      $available = $line.Substring($availableStart, $sourceStart - $availableStart).TrimEnd()
      $software = New-Object PsObject -Property @{ Name=$name ; Id=$id ; Version = $version ; AvailableVersion = $available }
      # $software.Name = $name;
      # $software.Id = $id;
      # $software.Version = $version
      # $software.AvailableVersion = $available;

      $upgradeList += $software
    }
  }

  return $upgradeList | Where-Object {($_.Id -notcontains "Microsoft.Office" -and $_.Id -notcontains "Microsoft.Teams") -and ($_.Id -notcontains "EclipseAdoptium.Temurin.18.JRE") -and ($_.Id -notcontains "JetBrains.ReSharper")
  }
}

function Update-Winget-All()
{
  foreach ($item in Update-Winget) { 
    winget upgrade --id $item.Id 
  }
}


# Invoke-CmdScript "C:\Program Files (x86)\Microsoft Visual Studio\2019\BuildTools\VC\Auxiliary\Build\vcvars64.bat"
Invoke-CmdScript "C:\Program Files (x86)\Microsoft Visual Studio\2019\Professional\Common7\Tools\VsDevCmd.bat"

if ($Host.Version.Major -gt 6)
{
  Invoke-Expression (& {
   (zoxide init --hook "pwd" powershell) -join "`n"
    })
} else
{
  Invoke-Expression (& {
   (zoxide init --hook "none" powershell) -join "`n"
    })
}

function zz
{ z - 
}

if ($Host.Name -ne 'Package Manager Host')
{
  oh-my-posh --init --shell pwsh --config $env:USERPROFILE/.dotfiles/powershell/.oh-my-posh.omp.json | Invoke-Expression
}
