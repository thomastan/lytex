@echo off
set PROMPT=# 

set downdir=%~dp0download

set Path=%~dp0somebin;%Path%

if not exist %~dp0LyTeX mkdir %~dp0LyTeX

::==================== LyX ========================
:makelyx

set lyxver=2.0.1
set lyxname=LyX-%lyxver%-1-Installer.exe

:lyxinst

rem if not exist %downdir%\%lyxname% goto altinst

echo.
echo Extracting LyX...

7z x -y -o%~dp0LyTeX\LyX %downdir%\%lyxname%

::pause

:: move command sucks when destination directory is not empty
::move /y %~dp0LyTeX\LyX\$_OUTDIR\Resources %~dp0LyTeX\LyX
if not exist %~dp0LyTeX\LyX\Resources mkdir %~dp0LyTeX\LyX\Resources
xcopy /e/i/y %~dp0LyTeX\LyX\$_OUTDIR\Resources %~dp0LyTeX\LyX\Resources
xcopy /e/i/y %~dp0LyTeX\LyX\$_OUTDIR\Python %~dp0LyTeX\LyX\Python

rmdir /s /q %~dp0LyTeX\LyX\$_OUTDIR
rmdir /s /q %~dp0LyTeX\LyX\$PLUGINSDIR
rmdir /s /q %~dp0LyTeX\LyX\$[33]
::::rmdir /s /q %~dp0LyTeX\LyX\aiksaurus\$PLUGINSDIR

::::copy %~dp0LyTeX\LyX\bin\Microsoft.VC90.CRT.manifest %~dp0LyTeX\LyX\ghostscript
copy %~dp0LyTeX\LyX\bin\msvcp100.dll %~dp0LyTeX\LyX\ghostscript
copy %~dp0LyTeX\LyX\bin\msvcr100.dll %~dp0LyTeX\LyX\ghostscript
rem there is an aspelldata.exe file in this directory
rmdir /s /q %~dp0LyTeX\LyX\ghostscript\$PLUGINSDIR

::::copy %~dp0LyTeX\LyX\bin\Microsoft.VC90.CRT.manifest %~dp0LyTeX\LyX\python
copy %~dp0LyTeX\LyX\bin\msvcp100.dll %~dp0LyTeX\LyX\Python
copy %~dp0LyTeX\LyX\bin\msvcr100.dll %~dp0LyTeX\LyX\Python
rem LyX-Installer doesn't put msvcrt in this directiory
::::copy %~dp0LyTeX\LyX\bin\Microsoft.VC90.CRT.manifest %~dp0LyTeX\LyX\imagemagick
copy %~dp0LyTeX\LyX\bin\msvcp100.dll %~dp0LyTeX\LyX\imagemagick
copy %~dp0LyTeX\LyX\bin\msvcr100.dll %~dp0LyTeX\LyX\imagemagick
rem LyX-Installer doesn't put these two files in this directiory

xcopy /e/i/y %~dp0somelyx %~dp0LyTeX\LyX

goto document

rem :altinst

rem set lyxaltname=LyX-163-4-19-AltInstaller-Small.exe

rem if not exist %downdir%\%lyxaltname% (
rem echo.
rem echo Downloading LyX alternative installer...
rem wget -nv -N -P %downdir% %lyxpath%/%lyxaltname%
rem )

rem echo.
rem echo Extracting LyX...

rem 7z x -y -o%~dp0LyTeX\LyX %downdir%\%lyxaltname%

rem rmdir /s /q %~dp0LyTeX\LyX\$[81]
rem move /y %~dp0LyTeX\LyX\$_OUTDIR\Resources %~dp0LyTeX\LyX
rem move /y %~dp0LyTeX\LyX\$_OUTDIR\Aiksaurus %~dp0LyTeX\LyX
rem move /y %~dp0LyTeX\LyX\$_OUTDIR\Aspell %~dp0LyTeX\LyX

rem if not exist %~dp0LyTeX\LyX\python mkdir %~dp0LyTeX\LyX\python
rem move /y %~dp0LyTeX\LyX\$_OUTDIR\bin\DLLs\unicodedata.pyd %~dp0LyTeX\LyX\python
rem move /y %~dp0LyTeX\LyX\$_OUTDIR\bin\Lib %~dp0LyTeX\LyX\python
rem move /y %~dp0LyTeX\LyX\$_OUTDIR\bin\python.exe %~dp0LyTeX\LyX\python
rem move /y %~dp0LyTeX\LyX\$_OUTDIR\bin\python26.dll %~dp0LyTeX\LyX\python
rem copy %~dp0LyTeX\LyX\$_OUTDIR\bin\Microsoft.VC90.CRT.manifest %~dp0LyTeX\LyX\python
rem copy %~dp0LyTeX\LyX\$_OUTDIR\bin\msvcp90.dll %~dp0LyTeX\LyX\python
rem copy %~dp0LyTeX\LyX\$_OUTDIR\bin\msvcr90.dll %~dp0LyTeX\LyX\python

rem move /y %~dp0LyTeX\LyX\$_OUTDIR\bin\* %~dp0LyTeX\LyX\bin
rem ::move /y %~dp0LyTeX\LyX\$_OUTDIR\dvipost %~dp0LyTeX\LyX
rem :: Ghostscript directory doesn't have fonts and Resource subdirectory!
rem move /y %~dp0LyTeX\LyX\$_OUTDIR\etc\Ghostscript %~dp0LyTeX\LyX
rem move /y %~dp0LyTeX\LyX\$_OUTDIR\etc\Imagemagick %~dp0LyTeX\LyX

rem xcopy /e/i/y %~dp0LyTeX\LyX\$_OUTDIR\etc\Metafile2eps %~dp0LyTeX\LyX\bin
rem rmdir /s /q %~dp0LyTeX\LyX\$_OUTDIR
rem rmdir /s /q %~dp0LyTeX\LyX\$APPDATA
rem del /q %~dp0LyTeX\LyX\Aspell\Uninstall-AspellData.exe
rem rmdir /s /q %~dp0LyTeX\LyX\bin\$PLUGINSDIR

rem move /y %~dp0LyTeX\LyX\Imagemagick\config\* %~dp0LyTeX\LyX\Imagemagick
rem move /y %~dp0LyTeX\LyX\Imagemagick\modules\coders\* %~dp0LyTeX\LyX\Imagemagick
rem move /y %~dp0LyTeX\LyX\Imagemagick\modules\filters\* %~dp0LyTeX\LyX\Imagemagick
rem rmdir /s /q %~dp0LyTeX\LyX\Imagemagick\config
rem rmdir /s /q %~dp0LyTeX\LyX\Imagemagick\modules
rem copy %~dp0LyTeX\LyX\bin\Microsoft.VC90.CRT.manifest %~dp0LyTeX\LyX\ImageMagick
rem copy %~dp0LyTeX\LyX\bin\msvcp90.dll %~dp0LyTeX\LyX\ImageMagick
rem copy %~dp0LyTeX\LyX\bin\msvcr90.dll %~dp0LyTeX\LyX\ImageMagick

rem xcopy /e/i/y %~dp0sometex\basic-lyx %~dp0LyTeX\LyX

::pause

:document

echo Copying Documents...
if not exist %~dp0LyTeX\Manual mkdir %~dp0LyTeX\Manual
xcopy /e/i/y %~dp0somedoc %~dp0LyTeX\Manual

:version

echo Writing LyX version...
if not exist %~dp0LyTeX\Common\update mkdir %~dp0LyTeX\Common\update
>%~dp0LyTeX\Common\update\lyxver.usb echo %lyxver%

echo Copying LyX update files...
copy %~dp0somebin\wget.exe %~dp0LyTeX\Common\update
copy %~dp0somebin\7z.dll %~dp0LyTeX\Common\update
copy %~dp0somebin\7z.exe %~dp0LyTeX\Common\update
copy %~dp0somebat\update.bat %~dp0LyTeX\Common\update

if not exist %~dp0LyTeX\Common\download mkdir %~dp0LyTeX\Common\download

if "%buildtex%"=="texlive" ( goto makelive ) else ( goto makemik )

::==================== MiKTeX ========================
:makemik

::set mkbin=miktex-portable-2.8.3582.exe
set mkbin=miktex-portable.exe

if not exist %~dp0LyTeX\MiKTeX md %~dp0LyTeX\MiKTeX
set texdir=%~dp0LyTeX\MiKTeX

echo.
echo Extracting MiKTeX...

if not exist %~dp0LyTeX\MiKTeX\texmf md %~dp0LyTeX\MiKTeX\texmf

7z x -y -o%~dp0LyTeX\MiKTeX\texmf %downdir%\%mkbin%

xcopy /e/i/y sometex\basic-mik %texdir%
move /y %texdir%\About.htm %~dp0LyTeX

xcopy /e/i/y sometex\basic-bin %texdir%\texmf\miktex\bin

rem texmf-local 

if not exist %texdir%\texmf-local mkdir %texdir%\texmf-local

xcopy /e/i/y sometex\basic-tex %texdir%
xcopy /e/i/y sometex\basic-cct %texdir%
xcopy /e/i/y sometex\basic-cjk %texdir%

rem editor

:: texworks config file lies in UserConfig or UserData dir 

if not exist %texdir%\texmf-local\TeXworks mkdir %texdir%\texmf-local\TeXworks
if not exist %texdir%\texmf-local\TeXworks\configuration mkdir %texdir%\texmf-local\TeXworks\configuration
xcopy /e/i/y %~dp0texworks\configuration %texdir%\texmf-local\TeXworks\0.4\configuration

if not exist %texdir%\texmf-local\TUG  mkdir %texdir%\texmf-local\TUG
xcopy /e/i/y %~dp0texworks\TUG %texdir%\texmf-local\TUG

echo.
echo Updating MiKTeX...
%texdir%\texmf\miktex\bin\mpm.exe --verbose --update
%texdir%\texmf\miktex\bin\mpm.exe --verbose --install-some=somedef\miktex.def

echo.
echo Updating finished. Press return to continue...
pause

rmdir /s /q %texdir%\texmf\doc
rmdir /s /q %texdir%\texmf\source

::pause

goto makeend

::==================== TeXLive ========================
:makelive

if not exist %~dp0LyTeX\TeXLive md %~dp0LyTeX\TeXLive
set outdir=%~dp0LyTeX\TeXLive

::goto addons

:extracttl

echo ===========================================
echo Now starting to extract TeXLive packages...
echo ===========================================

set indir=download\texlive

rem echo.
rem echo handing %indir% directory...
rem echo.
rem for /r %indir% %%a in (*.xz) do (
rem     echo tar -Jxf %%a
rem     tar -C%outdir% -Jxf %%a
rem )

if not exist %outdir%\texmf-dist mkdir %outdir%\texmf-dist

set coldir=%~dp0somedef

for /r %coldir% %%a in (tl*.def) do (
    echo handling %%a for extracting...
    for /f "tokens=1,2*" %%i in (%%a) do (
        if %%i == depend (
            echo tar -Jxf %%j.tar.xz
            if "%%k" == "0" (
                tar -C%outdir% -Jxf %indir%\%%j.tar.xz
            ) else (
                tar -C%outdir%\texmf-dist -Jxf %indir%\%%j.tar.xz
            )            
        ) 
    )
)

::pause

:movedist

rem since texlive 2009, some packages support relocation
rem xcopy /e/i/y "%outdir%\bibtex"     "%outdir%\texmf-dist\bibtex" && rmdir /s /q "%outdir%\bibtex"
rem xcopy /e/i/y "%outdir%\doc"        "%outdir%\texmf-dist\doc" && rmdir /s /q "%outdir%\doc"
rem xcopy /e/i/y "%outdir%\dvips"      "%outdir%\texmf-dist\dvips"  && rmdir /s /q "%outdir%\dvips"
rem xcopy /e/i/y "%outdir%\fonts"      "%outdir%\texmf-dist\fonts" && rmdir /s /q "%outdir%\fonts"
rem xcopy /e/i/y "%outdir%\makeindex"  "%outdir%\texmf-dist\makeindex"  && rmdir /s /q "%outdir%\makeindex"
rem xcopy /e/i/y "%outdir%\metafont"   "%outdir%\texmf-dist\metafont"  && rmdir /s /q "%outdir%\metafont"
rem xcopy /e/i/y "%outdir%\metapost"   "%outdir%\texmf-dist\metapost"  && rmdir /s /q "%outdir%\metapost"
rem xcopy /e/i/y "%outdir%\mft"        "%outdir%\texmf-dist\mft"  && rmdir /s /q "%outdir%\mft"
rem xcopy /e/i/y "%outdir%\omega"      "%outdir%\texmf-dist\omega" && rmdir /s /q "%outdir%\omega"
rem xcopy /e/i/y "%outdir%\scripts"    "%outdir%\texmf-dist\scripts"  && rmdir /s /q "%outdir%\scripts"
rem xcopy /e/i/y "%outdir%\source"     "%outdir%\texmf-dist\source"  && rmdir /s /q "%outdir%\source"
rem xcopy /e/i/y "%outdir%\tex"        "%outdir%\texmf-dist\tex"  && rmdir /s /q "%outdir%\tex"
rem xcopy /e/i/y "%outdir%\vtex"       "%outdir%\texmf-dist\vtex"  && rmdir /s /q "%outdir%\vtex"

xcopy /e/i/y "%outdir%\texmf-dist\texmf-dist"  "%outdir%\texmf-dist"  && rmdir /s /q "%outdir%\texmf-dist\texmf-dist"

xcopy /e/i/y "%outdir%\texmf-dist\tlpkg"  "%outdir%\tlpkg"  && rmdir /s /q "%outdir%\texmf-dist\tlpkg"

::pause

:cleartl

rem remove tlpkg, doc and source dir
:: rmdir /s /q %outdir%\tlpkg
rmdir /s /q %outdir%\texmf-dist\doc
rmdir /s /q %outdir%\texmf-dist\source
rmdir /s /q %outdir%\texmf\doc
rmdir /s /q %outdir%\texmf\source
rmdir /s /q %outdir%\texmf-dist\doc
rmdir /s /q %outdir%\texmf-dist\source
rmdir /s /q %outdir%\texmf-local\doc
rmdir /s /q %outdir%\texmf-local\source
:: rmdir /s /q %outdir%\ctxdir

rmdir /s /q %outdir%\readme-html.dir
rmdir /s /q %outdir%\readme-txt.dir
del /q %outdir%\install-tl.log
del /q %outdir%\doc.html
del /q %outdir%\index.html
del /q %outdir%\texmf.cnf 
del /q %outdir%\README.usergroups
del /q %outdir%\README
del /q %outdir%\install-tl
del /q %outdir%\tl-portable
del /q %outdir%\install-tl.bat
del /q %outdir%\install-tl-advanced.bat
del /q %outdir%\tl-portable.bat

:: =============================================

::pause

:addons

xcopy /e/i/y sometex\basic-live %outdir%
move /y %outdir%\About.htm %~dp0LyTeX

set tlpdb=%outdir%\tlpkg\texlive.tlpdb
set objdir=%outdir%\tlpkg\tlpobj

if exist %tlpdb% del /q %tlpdb%
::echo type %objdir%\00texlive-installation.config.tlpobj
::type %objdir%\00texlive-installation.config.tlpobj > %tlpdb%
::echo. >> %tlpdb%

for /f %%a in ('dir /b /o n %objdir%') do (
    echo type %objdir%\%%a
    type %objdir%\%%a >>%tlpdb%
    echo.>>%tlpdb%
) 

::for /r %objdir% %%a in (*.tlpobj) do (
::    echo type %%a
::    type %%a >>%tlpdb%
::    echo. >>%tlpdb%
::)

rem texlive 2009 supports RELOCATION of package
rem thus we replace texlive.tlpdb using perl here
"%outdir%\tlpkg\tlperl\bin\perl.exe" -p -i".txt" -e "s/RELOC/texmf-dist/g" "%outdir%\tlpkg\texlive.tlpdb"
del /q %outdir%\tlpkg\texlive.tlpdb.txt 

xcopy /e/i/y sometex\basic-bin %outdir%\bin\win32

rem editor

if not exist %outdir%\tlpkg\texworks mkdir %outdir%\tlpkg\texworks
xcopy /e/i/y %~dp0texworks %outdir%\tlpkg\texworks

rem texmf-local 

if not exist %outdir%\texmf-local mkdir %outdir%\texmf-local

xcopy /e/i/y sometex\basic-tex %outdir%
xcopy /e/i/y sometex\basic-cct %outdir%
xcopy /e/i/y sometex\basic-cjk %outdir%

%outdir%\bin\win32\texhash.exe

::pause

goto makeend

::==================== TheEnd ========================
:makeend

echo All are done!

pause


