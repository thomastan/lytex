::
:: LaTeXify: latex+makeidx+bibtex+dvipdfmx
:: author: zoho@ctex.org
:: modified date: 2009-06-22
::

@echo off

setlocal enabledelayedexpansion

set curdir=%cd%

%~d1
cd %~dp1

echo.
echo ================================================
echo Running "latex -synctex=-1 %~n1"
echo ================================================
echo.

latex -synctex=-1 %~n1

::echo.
::echo %%~n1 = %~n1
::echo.

if exist %~n1.idx (

echo.
echo ================================================
echo Running "makeindex %~n1"
echo ================================================
echo.

makeindex %~n1
)

::if exist %~n1.aux (
if exist %~n1.bbl (

echo.
echo ================================================
echo Running "bibtex %~n1"
echo ================================================
echo.

bibtex %~n1"

)

rem latex -synctex=-1 %~n1

rem latex -synctex=-1 %~n1

echo.
echo ================================================
echo Running "dvipdfmx %~n1%"
echo ================================================
echo.

dvipdfmx %~n1

cd "%curdir%"
set curdrive=!curdir:~0,2!
!curdrive!

endlocal
