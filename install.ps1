New-Item -ItemType SymbolicLink -Path "$env:USERPROFILE\.vimrc" -Target "$PSScriptRoot\.vimrc"
New-Item -ItemType SymbolicLink -Path "$env:USERPROFILE\.gitconfig" -Target "$PSScriptRoot\.gitconfig"
New-Item -ItemType SymbolicLink -Path "$env:USERPROFILE\.vim" -Target "$PSScriptRoot\.vim"
New-Item -ItemType SymbolicLink -Path "$env:LOCALAPPDATA\nvim" -Target "$PSScriptRoot\nvim"
