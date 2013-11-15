@echo off

cd ..

set Path=%cd%\somebin;%Path%
set tlpkg=ftp://ftp.ctex.org/mirrors/CTAN/systems/texlive/tlnet/tlpkg
set downdir=download
 
if not exist %downdir%\texlive.tlpdb (
    wget -nv -N -P download %tlpkg%/texlive.tlpdb.xz
    xz -f -d %downdir%\texlive.tlpdb.xz
)

setlocal enabledelayedexpansion

del somedef\tlreloc0.lst somedef\tlreloc1.lst 2>nul

echo.
echo finding relocated=0 and relocated=1 ...
echo.

for /f "tokens=1,2*" %%i in (%downdir%\texlive.tlpdb) do (
    if %%i == name (
        set pkg=%%j
        set reloc=0
    )
    if %%i == relocated (
        if %%j == 1 (
            set reloc=1
        echo depend !pkg!>>somelst\tlreloc1.lst
        )
    )
    if %%i == containersize (
        if !reloc! == 0 (
            for  /f "tokens=1,2* delims=." %%a in ("!pkg!") do (
                if "%%b" == "" echo depend !pkg!>>somedef\tlreloc0.lst
                if "%%b" == "win32" echo depend !pkg!>>somedef\tlreloc0.lst
                if "%%b" == "infra" (
                    if "%%c" == "" echo depend !pkg!>>somedef\tlreloc0.lst
                    if "%%c" == "win32" echo depend !pkg!>>somedef\tlreloc0.lst
                )
            )
        )    
    ) 
)

endlocal

cd somebat
