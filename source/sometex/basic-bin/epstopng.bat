@echo off
rem Batch file to call (e)ps to png conversion program
rem --------------------------------------------------
rem
rem Make sure that the relevant directories are in the PATH. e.g.
rem     "C:\Program Files\Postscript\gs8.00\bin"

rem Ghostscript Conversion (Use GS version >= 8.00)
rem -----------------------------------------------

if exist %~dp0mgs.exe (
set gsbin=mgs
) else if exist %~dp0rungs.exe (
set gsbin=rungs
) else (
echo Could not find ghostscript!
pause
exit
)

set Path=%~dp0;%Path%

set curdir=%~dp0
set curdrive=%~d0
%curdrive%
cd %curdir%

cd ..\..\..

set MIKTEX_GS_LIB=%cd%\texmf\ghostscript\base;%cd%\texmf\fonts
::echo %gs_lib%

echo Converting %~nx1 to %~n1.png
%gsbin% -dSAFER -dNOPAUSE -dQUIET -dBATCH -dEPSCrop -sDEVICE=pngalpha -sOutputFile="%~dpn1.png" "%~dpnx1"
