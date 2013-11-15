@echo off

set PROMPT=texshell$G

set TEXDIR=%~dp0
set tldrive=%~d0

%tldrive%
cd %TEXDIR%

set TEXMFCNF=
set TEXMFMAIN=
set TEXMFDIST=
set TEXMFLOCAL=
set TEXMFVAR=
set TEXMF=

set FONTCONFIG_FILE=
set FONTCONFIG_PATH=
set FC_CACHEDIR=

set TEXBINDIR=%TEXDIR%bin\win32
set platform=win32
if "%1" equ "texmgr" (
:: start tlmgr
rem can't change "rem" to "::" in the following line! 
rem cmd /C "tlmgr.bat --gui"
start "title" "%~dp0bin\win32\tlmgr-gui.vbs"
exit
)

:: start texshell
set Path=%~dp0bin\win32;%~dp0tlpkg\tlgs\bin;%Path%
cd ..
set gs_lib=%cd%\TeXLive\tlpkg\tlgs\lib;%cd%\TeXLive\tlpkg\tlgs\fonts;
set gs_dll=%cd%\TeXLive\tlpkg\tlgs\bin\gsdll32.dll
texhash
if exist "%USERPROFILE%\My Documents\texdoc" (
    %HOMEDRIVE%
    cd %HOMEPATH%\My Documents\texdoc
    for %%i in (*.aux) do del %%i
    for %%i in (*.dvi) do del %%i
    for %%i in (*.log) do del %%i
    for %%i in (*.synctex) do del %%i
    )
call cmd

:pause
