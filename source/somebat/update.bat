@echo off

:: need to change drive first
%~d0
cd %~dp0

set lytexdir=..\..
set lyxdir=..\..\LyX
 
:: wget need the slash at the end when listing files 
set lyxpath=ftp://ftp.lyx.org/pub/lyx/bin/

setlocal enabledelayedexpansion

echo Checking current LyX version...
for /f "tokens=1,2,3 delims=. " %%u in (lyxver.usb) do (
    set curver1=%%u
	set curver2=%%v
	set curver3=%%w
	set curvers=!curver1!.!curver2!.!curver3!
	echo Current LyX version is !curvers!
    echo.	
)

::pause

echo Check for latest LyX version...
echo.

if exist index.html del index.html
if exist .listing del .listing
wget --no-remove-listing %lyxpath%

if not exist .listing echo Error while checking for LyX updates! & pause & exit
:: we take the last version as latest version at present
for /f "tokens=9 delims= " %%i in (.listing) do set newvers=%%i
::echo %newvers%

if exist index.html del index.html
if exist .listing del .listing

::pause

for /f "tokens=1,2,3 delims=. " %%u in ("%newvers%") do (		
    set newver1=%%u
	  set newver2=%%v
	  set newver3=%%w
    echo.
	  echo Latest LyX version is !newver1!.!newver2!.!newver3!
    echo.
)

if %newver1% gtr %curver1% echo main version number was updated & goto updatelyx
if %newver1% == %curver1% if %newver2% gtr %curver2% echo minor version number was updated & goto updatelyx
if %newver1% == %curver1% if %newver2% == %curver2% if %newver3% gtr %curver3% echo revision version number was updated & goto updatelyx

::Current LyX is in latest state
echo Current LyX is the latest version!
goto :theEnd

:updatelyx
::goto clearlyx

::pause

echo We need to update LyX...
echo.

::pause

set downdir=..\download
if not exist %downdir% mkdir %downdir%

set lyxname=LyX-%newvers%-1-Installer.exe
::set lyx installer : LyX-1.6.3-1-Installer.exe
::set lyx altinstaller : LyX-163-4-19-AltInstaller-Small.exe

if exist %downdir%\%lyxname% (
echo LyX installer exists in download folder
echo.
goto extractlyx
)

echo Downloading LyX installer...
echo.
wget -nv -N -O%downdir%\%lyxname%.tmp %lyxpath%%newvers%/%lyxname%
if ErrorLevel 1 echo Error while downloading LyX installer! & pause & exit 

move %downdir%\%lyxname%.tmp %downdir%\%lyxname%
if not exist %downdir%\%lyxname% echo Error while moving LyX installer & pause & exit

if exist index.html del index.html
if exist .listing del .listing

::pause

:extractlyx

echo Extracting LyX installer...
echo.
if exist %downdir%\LyX rmdir /s /q %downdir%\LyX
7z x -y -o%downdir%\LyX %downdir%\%lyxname%
if ERRORLEVEL 1 echo Error while extracting LyX installer! & pause & exit 

::pause

:clearlyx

echo.
echo Tidying new LyX directory...
echo. 

:: when Resources folder exists in LyX directory, move command does nothing!
move /y %downdir%\LyX\$_OUTDIR\Resources %downdir%\LyX
xcopy /e/i/y %downdir%\LyX\$_OUTDIR\Python %downdir%\LyX\Python

rmdir /s /q %downdir%\LyX\$_OUTDIR
rmdir /s /q %downdir%\LyX\$PLUGINSDIR
rmdir /s /q %downdir%\LyX\$[33]
::::rmdir /s /q %downdir%\LyX\aiksaurus\$PLUGINSDIR

::::copy /y %downdir%\LyX\bin\Microsoft.VC90.CRT.manifest %downdir%\LyX\ghostscript
copy /y %downdir%\LyX\bin\msvcp100.dll %downdir%\LyX\ghostscript
copy /y %downdir%\LyX\bin\msvcr100.dll %downdir%\LyX\ghostscript
rmdir /s /q %downdir%\LyX\ghostscript\$PLUGINSDIR

::::copy /y %downdir%\LyX\bin\Microsoft.VC90.CRT.manifest %downdir%\LyX\python
copy /y %downdir%\LyX\bin\msvcp100.dll %downdir%\LyX\Python
copy /y %downdir%\LyX\bin\msvcr100.dll %downdir%\LyX\Python
rem LyX-Installer doesn't put msvcrt in this directiory
::::copy /y %downdir%\LyX\bin\Microsoft.VC90.CRT.manifest %downdir%\LyX\imagemagick
copy /y %downdir%\LyX\bin\msvcp100.dll %downdir%\LyX\imagemagick
copy /y %downdir%\LyX\bin\msvcr100.dll %downdir%\LyX\imagemagick

rem LyX-Installer doesn't put these pdfopen.exe and System.dll in this directiory
copy /y %lyxdir%\bin\pdfopen.exe %downdir%\LyX\bin
copy /y %lyxdir%\bin\System.dll %downdir%\LyX\bin
::xcopy /e/i/y %~dp0sometex\basic-lyx %~dp0LyTeX\LyX
if not exist %downdir%\LyX\local mkdir %downdir%\LyX\local
xcopy /e/i/y  %lyxdir%\local %downdir%\LyX\local
mkdir %downdir%\LyX\Resources\templates\ChineseSimp
xcopy /e/i/y  %lyxdir%\Resources\templates\ChineseSimp %downdir%\LyX\Resources\templates\ChineseSimp

::pause

echo.
echo Removing old LyX files...
echo.

::::rmdir /s /q %lyxdir%\aiksaurus
rmdir /s /q %lyxdir%\bin
rmdir /s /q %lyxdir%\ghostscript
rmdir /s /q %lyxdir%\imagemagick
rmdir /s /q %lyxdir%\local
rmdir /s /q %lyxdir%\Python
rmdir /s /q %lyxdir%\Resources
del /q %lyxdir%\lyx.usb

::pause

echo Moving new LyX files to LyX directory...
echo.

::::move /y %downdir%\LyX\aiksaurus %lytexdir%\LyX
move /y %downdir%\LyX\bin %lytexdir%\LyX
move /y %downdir%\LyX\ghostscript %lytexdir%\LyX
move /y %downdir%\LyX\imagemagick %lytexdir%\LyX
move /y %downdir%\LyX\local %lytexdir%\LyX
move /y %downdir%\LyX\Python %lytexdir%\LyX
move /y %downdir%\LyX\Resources %lytexdir%\LyX

rmdir /s /q %downdir%\LyX

::pause

:: Save new version number 
>lyxver.usb echo %newvers%

echo.
echo We have updated LyX from %curvers% to %newvers%.

:theEnd

pause
endlocal