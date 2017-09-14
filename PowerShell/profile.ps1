# Load posh-git example profile
Import-Module -Name posh-git
Start-SshAgent -Quiet

# Add Cmder modules directory to the autoload path.
$CmderModulePath = Join-path $PSScriptRoot "psmodules/"
$Host.PrivateData.DebugBackgroundColor="Black"
$Host.PrivateData.ErrorBackgroundColor="Black"

$GitPromptSettings.DefaultForegroundColor="White"
$GitPromptSettings.BeforeText=" ("
$GitPromptSettings.BeforeForegroundColor="White"

$GitPromptSettings.AfterText=")"
$GitPromptSettings.AfterForegroundColor="White"

$GitPromptSettings.BranchForegroundColor="White"
$GitPromptSettings.BranchIdenticalStatusToForegroundColor="White"

$GitPromptSettings.BranchIdenticalStatusToSymbol=""
$GitPromptSettings.ShowStatusWhenZero=0


if( -not $env:PSModulePath.Contains($CmderModulePath) ){
    $env:PSModulePath = $env:PSModulePath.Insert(0, "$CmderModulePath;")
}

function Test-Administrator {
    $user = [Security.Principal.WindowsIdentity]::GetCurrent();
    (New-Object Security.Principal.WindowsPrincipal $user).IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)
}

function prompt {
    $realLASTEXITCODE = $LASTEXITCODE

    Write-Host

    # Reset color, which can be messed up by Enable-GitColors
    $Host.UI.RawUI.ForegroundColor = $GitPromptSettings.DefaultForegroundColor

    if (Test-Administrator) {  # Use different username if elevated
        Write-Host "(Elevated) " -NoNewline -ForegroundColor White
    }

    if ($s -ne $null) {  # color for PSSessions
        Write-Host " (`$s: " -NoNewline -ForegroundColor DarkGray
        Write-Host "$($s.Name)" -NoNewline -ForegroundColor Yellow
        Write-Host ") " -NoNewline -ForegroundColor DarkGray
        Write-Host " : " -NoNewline -ForegroundColor DarkGray
    }

    Write-Host $($(Get-Location) -replace ($env:USERPROFILE).Replace('\','\\'), "~") -NoNewline -ForegroundColor Green

    $global:LASTEXITCODE = $realLASTEXITCODE

    Write-VcsStatus
    Write-Host ""

    return "λ "
}

function Get-ChildItem-Color {
    if ($Args[0] -eq $true) {
        $ifwide = $true

        if ($Args.Length -gt 1) {
            $Args = $Args[1..($Args.length - 1)]
        } else {
            $Args = @()
        }
    } else {
        $ifwide = $false
    }

    if (($Args[0] -eq "-a") -or ($Args[0] -eq "--all")) {
        $Args[0] = "-Force"
    }

    $width =  $host.UI.RawUI.WindowSize.Width
    
    $items = Invoke-Expression "Get-ChildItem `"$Args`"";
    $lnStr = $items | select-object Name | sort-object { "$_".length } -descending | select-object -first 1
    $len = $lnStr.name.length
    $cols = If ($len) {($width+1)/($len+2)} Else {1};
    $cols = [math]::floor($cols);
    if(!$cols){ $cols=1;}

    $color_fore = $Host.UI.RawUI.ForegroundColor

    $compressed_list = @(".7z", ".gz", ".rar", ".tar", ".zip")
    $executable_list = @(".exe", ".bat", ".cmd", ".py", ".pl", ".ps1",
                         ".psm1", ".vbs", ".rb", ".reg", ".fsx")
    $dll_pdb_list = @(".dll", ".pdb")
    $text_files_list = @(".csv", ".lg", "markdown", ".rst", ".txt")
    $configs_list = @(".cfg", ".config", ".conf", ".ini")

    $color_table = @{}
    foreach ($Extension in $compressed_list) {
        $color_table[$Extension] = "Yellow"
    }

    foreach ($Extension in $executable_list) {
        $color_table[$Extension] = "Blue"
    }

    foreach ($Extension in $text_files_list) {
        $color_table[$Extension] = "Cyan"
    }

    foreach ($Extension in $dll_pdb_list) {
        $color_table[$Extension] = "Darkgreen"
    }

    foreach ($Extension in $configs_list) {
        $color_table[$Extension] = "DarkYellow"
    }

    $i = 0
    $pad = [math]::ceiling(($width+2) / $cols) - 3
    $nnl = $false

    $items |
    %{
        if ($_.GetType().Name -eq 'DirectoryInfo') {
            $c = 'Green'
            $length = ""
        } else {
            $c = $color_table[$_.Extension]

            if ($c -eq $none) {
                $c = $color_fore
            }

            $length = $_.length
        }

        # get the directory name
        if ($_.GetType().Name -eq "FileInfo") {
            $DirectoryName = $_.DirectoryName
        } elseif ($_.GetType().Name -eq "DirectoryInfo") {
            $DirectoryName = $_.Parent.FullName
        }
        
        if ($ifwide) {  # Wide (ls)
            if ($LastDirectoryName -ne $DirectoryName) {  # change this to `$LastDirectoryName -ne $DirectoryName` to show DirectoryName
                if($i -ne 0 -AND $host.ui.rawui.CursorPosition.X -ne 0){ # conditionally add an empty line
                    write-host ""
                }
                Write-Host -Fore $color_fore ("`n   Directory: $DirectoryName`n")
            }

            $nnl = ++$i % $cols -ne 0

            # truncate the item name
            $towrite = $_.Name
            if ($towrite.length -gt $pad) {
                $towrite = $towrite.Substring(0, $pad - 3) + "..."
            }

            Write-Host ("{0,-$pad}" -f $towrite) -Fore $c -NoNewLine:$nnl
            if($nnl){
                write-host "  " -NoNewLine
            }
        } else {
            If ($LastDirectoryName -ne $DirectoryName) {  # first item - print out the header
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

    if ($nnl) {  # conditionally add an empty line
        Write-Host ""
    }
}

function Get-ChildItem-Format-Wide {
    $New_Args = @($true)
    $New_Args += "$Args"
    Invoke-Expression "Get-ChildItem-Color $New_Args"
}



# Chocolatey profile
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
  Import-Module "$ChocolateyProfile"
}

Set-Alias ls Get-ChildItem-Color -option AllScope -Force
Set-Alias dir Get-ChildItem-Color -option AllScope -Force
if ($host.version.Major -ge 3) {

    if (!(Get-Module -ListAvailable | ? { $_.name -like 'psreadline' })) {
        Install-Module PsReadLine
    }
    
    if ($host.Name -eq 'ConsoleHost') {
        Import-Module PSReadline
 
        Set-PSReadlineKeyHandler -Key Ctrl+Delete    -Function KillWord
        Set-PSReadlineKeyHandler -Key Ctrl+Backspace -Function BackwardKillWord
        Set-PSReadlineKeyHandler -Key Shift+Backspace -Function BackwardKillWord
        Set-PSReadlineKeyHandler -Key UpArrow        -Function HistorySearchBackward
        Set-PSReadlineKeyHandler -Key DownArrow      -Function HistorySearchForward
        Set-PSReadlineKeyHandler -Key Tab            -Function Complete
        Set-PSReadlineKeyHandler -Key Ctrl+D         -Function DeleteCharOrExit
    }
}

# Move to the wanted location
if (Test-Path Env:\CMDER_START) {
    Set-Location -Path $Env:CMDER_START
} elseif ($Env:CMDER_ROOT -and $Env:CMDER_ROOT.StartsWith($pwd)) {
    Set-Location -Path $Env:USERPROFILE
}

Set-Alias ls Get-ChildItem-Color -option AllScope -Force
Set-Alias dir Get-ChildItem-Color -option AllScope -Force

function Set-Location-Speedway ([string]$Branch) { Set-Location C:\Projects\TFS\Speedway_$Branch }

function Release-Speedway ([string]$Branch) {
    Set-Location C:\Projects\TFS\Speedway_$Branch
    .\_prune_all.bat
    .\_release_and_deploy.bat
}

function Set-Location-Speedway-PreAlpha { Set-Location-Speedway "PreAlpha" }
Set-Alias cdspa Set-Location-Speedway-PreAlpha

function Set-Location-Speedway-Alpha { Set-Location-Speedway "Alpha" }
Set-Alias cdsa Set-Location-Speedway-Alpha
function Release-Speedway-Alpha { Release-Speedway "Alpha" }
Set-Alias rswa Release-Speedway-Alpha

function Set-Location-Speedway-Beta { Set-Location-Speedway "Beta" }
Set-Alias cdsb Set-Location-Speedway-Beta
function Release-Speedway-Beta { Release-Speedway "Beta" }
Set-Alias rswb Release-Speedway-Beta

function Set-Location-Speedway-Master { Set-Location-Speedway "Master" }
Set-Alias cdsm Set-Location-Speedway-Master
function Release-Speedway-Master { Release-Speedway "Master" }
Set-Alias rswm Release-Speedway-Master

function Set-Location-Development { Set-Location C:\Projects }
Set-Alias cdd Set-Location-Development

function Set-Location-Portable { Set-Location C:\Users\mgondermann\Portable }
Set-Alias cdp Set-Location-Portable

function Set-Location-Dir-Up { Set-Location .. }
Set-Alias .. Set-Location-Dir-Up

function Open-Explorer ([string]$Directory) { explorer.exe $Directory }
Set-Alias e Open-Explorer
function Open-Explorer-Here { e . }
Set-Alias e. Open-Explorer-Here

function Open-VSCode ([string]$Directory) { code $Directory }
Set-Alias c Open-VSCode
function Open-VSCode-Here { c . }
Set-Alias c. Open-VSCode-Here

function Open-Atom ([string]$Directory) { atom $Directory }
Set-Alias a Open-Atom
function Open-Atom-Here { a . }
Set-Alias a. Open-Atom-Here

function Kill-All ([string]$ProcessName) { pskill $ProcessName }

function Kill-All-MSBuild { Kill-All MSBuild.exe }
Set-Alias kb Kill-All-MSBuild

function Kill-All-Showcase { Kill-All Showcase.exe }
Set-Alias ksc Kill-All-Showcase

function Undo-Unchanged { tfpt uu /noget }
Set-Alias uu Undo-Unchanged

function Undo-Scorch { tfpt scorch /exclude:*.suo,*.user,horece.mdb,paket.exe,_Resharper.* /noprompt /deletes }
Set-Alias scorch Undo-Scorch

function Undo-TreeClean { tfpt treeclean /exclude:*.suo,*.user,horece.mdb,paket.exe,_Resharper.* /noprompt }
Set-Alias tc Undo-TreeClean

function Search-Todo { rg -tcsharp TODO }
Set-Alias todo Search-Todo

function Search-Fixme { rg -tcsharp TODO }
Set-Alias fixme Search-Fixme

function Paket-Install { .\paket.bat install }
Set-Alias pi Paket-Install

function Paket-Install-Fast { .paket\paket.exe install }
Set-Alias pif Paket-Install-Fast

Set-Alias vi gvim

function  Edit-Profile { code $env:USERPROFILE\dotfiles\PowerShell\profile.ps1 }

function Start-MSBuild { & 'C:\Program Files (x86)\MSBuild\15.0\Bin\MSBuild.exe' }
Set-Alias msbuild Start-MSBuild

# Git
function gs { git status }
function gst { git st }
function gstu { git stu }
function gci { git ci }
function gcim { git cim }
function gcima { git cima }
function gtype { git type }
function gdump { git dump }
function amend { git amend }
function reword { git reword }
function gundo { git undo }
function grh { git rh }
function ga { git a }
function gaa { git aa }
function unstage { git unstage }
function gco { git co }
function gbr { git br }
function gb { git b }
function gbrs { git brs }
function grv { git rv }
function gd { git d }
function gdf { git df }
function gdc { git dc }
function preview { git preview }
function gdt { git dt }
function gmt { git mt }
function gunresolve { git unresolve }
function ll { git ll }
function gl { git l }
function gld { git ld }
function ggl { git gl }
function glog { git glog }
function ghist { git hist }
function gwho { git who }
function gwdw { git wdw }
function mostchanged { git most-changed }
function gcleanf { git cleanf }
function gtags { git tags }
function gtagm { git tagm }
function gtagd { git tagd }
