@ECHO OFF
SET LINK=cmd /c mklink
SET LINKDIR="%~dp0bin\junction.exe" -nobanner -accepteula

%LINK% "%USERPROFILE%\_vimrc" "%~dp0_vimrc"  
%LINK% "%USERPROFILE%\_vimrc" "%~dp0_vimrc"  
%LINK% "%USERPROFILE%\.gitconfig" "%~dp0.gitconfig" 
%LINK% "%USERPROFILE%\.gitconfig" "%~dp0.gitconfig" 
%LINKDIR% "%USERPROFILE%\vimfiles" "%~dp0vimfiles" 
%LINKDIR% "%APPDATA%\Code\User" "%~dp0Code\User"