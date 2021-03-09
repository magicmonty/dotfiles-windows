function Get-ChildItem-Color
{
  if ($Args[0] -eq $true)
  {
    $ifwide = $true
    
    if ($Args.Length -gt 1)
    {
      $Args = $Args[1..($Args.length - 1)]
    } else
    {
      $Args = @()
    }
  } else
  {
    $ifwide = $false
  }
  
  if (($Args[0] -eq "-a") -or ($Args[0] -eq "--all"))
  {
    $Args[0] = "-Force"
  }

  $width =  $host.UI.RawUI.WindowSize.Width
    
  $items = Invoke-Expression "Get-ChildItem `"$Args`"";
  $lnStr = $items | select-object Name | sort-object { "$_".length } -descending | select-object -first 1
  $len = $lnStr.name.length
  $cols = If ($len)
  {($width+1)/($len+2)
  } Else
  {1
  };
  $cols = [math]::floor($cols);
  if(!$cols)
  { $cols=1;
  }

  $color_fore = $Host.UI.RawUI.ForegroundColor

  $compressed_list = @(".7z", ".gz", ".rar", ".tar", ".zip")
  $executable_list = @(".exe", ".bat", ".cmd", ".py", ".pl", ".ps1",
    ".psm1", ".vbs", ".rb", ".reg", ".fsx")
  $dll_pdb_list = @(".dll", ".pdb")
  $text_files_list = @(".csv", ".lg", "markdown", ".rst", ".txt")
  $configs_list = @(".cfg", ".config", ".conf", ".ini")

  $color_table = @{}
  foreach ($Extension in $compressed_list)
  {
    $color_table[$Extension] = "Yellow"
  }

  foreach ($Extension in $executable_list)
  {
    $color_table[$Extension] = "Blue"
  }

  foreach ($Extension in $text_files_list)
  {
    $color_table[$Extension] = "Cyan"
  }

  foreach ($Extension in $dll_pdb_list)
  {
    $color_table[$Extension] = "Darkgreen"
  }

  foreach ($Extension in $configs_list)
  {
    $color_table[$Extension] = "DarkYellow"
  }

  $i = 0
  $pad = [math]::ceiling(($width+2) / $cols) - 3
  $nnl = $false

  $items |
    %{
      if ($_.GetType().Name -eq 'DirectoryInfo')
      {
        $c = 'Green'
        $length = ""
      } else
      {
        $c = $color_table[$_.Extension]

        if ($c -eq $none)
        {
          $c = $color_fore
        }

        $length = $_.length
      }

      # get the directory name
      if ($_.GetType().Name -eq "FileInfo")
      {
        $DirectoryName = $_.DirectoryName
      } elseif ($_.GetType().Name -eq "DirectoryInfo")
      {
        $DirectoryName = $_.Parent.FullName
      }
         
      if ($ifwide)
      {  # Wide (ls)
        if ($LastDirectoryName -ne $DirectoryName)
        {  # change this to `$LastDirectoryName -ne $DirectoryName` to show DirectoryName
          if($i -ne 0 -AND $host.ui.rawui.CursorPosition.X -ne 0)
          { # conditionally add an empty line
            write-host ""
          }
          Write-Host -Fore $color_fore ("`n   Directory: $DirectoryName`n")
        }
 
        $nnl = ++$i % $cols -ne 0
 
        # truncate the item name
        $towrite = $_.Name
        if ($towrite.length -gt $pad)
        {
          $towrite = $towrite.Substring(0, $pad - 3) + "..."
        }
 
        Write-Host ("{0,-$pad}" -f $towrite) -Fore $c -NoNewLine:$nnl
        if($nnl)
        {
          write-host "  " -NoNewLine
        }
      } else
      {
        If ($LastDirectoryName -ne $DirectoryName)
        {  # first item - print out the header
          Write-Host "`n    Directory: $DirectoryName`n"
          Write-Host "Mode                LastWriteTime     Length Name"
          Write-Host "----                -------------     ------ ----"
        }
        $Host.UI.RawUI.ForegroundColor = $c
 
        Write-Host ("{0,-7} {1,25} {2,10} {3}" -f $_.mode,
          ([String]::Format("{0,10}  {1,8}",
              $_.LastWriteTime.ToString("d"),
              $_.LastWriteTime.ToString("t"))),
          $length, $_.name)
            
        $Host.UI.RawUI.ForegroundColor = $color_fore
 
        ++$i  # increase the counter
      }
      $LastDirectoryName = $DirectoryName
    }

  if ($nnl)
  {  # conditionally add an empty line
    Write-Host ""
  }
}

function Get-ChildItem-Format-Wide
{
  $New_Args = @($true)
  $New_Args += "$Args"
  Invoke-Expression "Get-ChildItem-Color $New_Args"
}

Set-Alias ls Get-ChildItem-Color -option AllScope -Force
Set-Alias dir Get-ChildItem-Color -option AllScope -Force

if ($host.version.Major -ge 3)
{
  if ($host.Name -eq 'ConsoleHost')
  {
    Import-Module PSReadline
    Import-Module -Name PSFzf
 
    Set-PSReadlineKeyHandler -Key Ctrl+Delete    -Function KillWord
    Set-PSReadlineKeyHandler -Key Ctrl+Backspace -Function BackwardKillWord
    Set-PSReadlineKeyHandler -Key Shift+Backspace -Function BackwardKillWord
    Set-PSReadlineKeyHandler -Key UpArrow        -Function HistorySearchBackward
    Set-PSReadlineKeyHandler -Key DownArrow      -Function HistorySearchForward
    Set-PSReadlineKeyHandler -Key Tab            -Function Complete
    Set-PSReadlineKeyHandler -Key Ctrl+d         -Function DeleteCharOrExit
    Remove-PSReadlineKeyHandler 'Ctrl+r'
  }
}
function Set-Location-Cms ()
{
  Set-Location C:\Projects\TDsuite.CMS
}
Set-Alias cdc Set-Location-Cms

function Set-Location-AngularFrontend
{
  Set-Location Code\Web\ClientApp
}
Set-Alias cdcw Set-Location-AngularFrontend
function Set-Location-BackToRoot
{
  Set-Location ..\..\..
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

Set-Alias vi nvim-qt
Set-Alias vim nvim-qt

function  Edit-Profile
{ nvim-qt $env:USERPROFILE\dotfiles\PowerShell\profile.ps1 
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
function gobs 
{
  Param([String] $jiraId = "")
  Process
  {
    if ($jiraId -eq '')
    {
      $branch=git branch --all | Select-String -Pattern '^[\s*]*(?:remotes/origin/)?(features/SPWAY-\d+)\s*$' -AllMatches | % {$_.Matches} | %{$_.Groups[1].Value.Trim()} | sort | Get-Unique | peco
    } else
    {
      $branch='features/SPWAY-' + $jiraId
    }
    git co $branch 
  }
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
if (Test-Path($ChocolateyProfile)) {
  Import-Module "$ChocolateyProfile"
}

Set-Location -Path $Env:USERPROFILE
Set-PoshPrompt ~/.oh-my-posh.omp.json