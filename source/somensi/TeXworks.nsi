Name "LyTeX TeXworks Runner"
Caption "LyTeX TeXworks Runner"
Icon "TeXworks.ico"
OutFile "..\LyTeX\TeXworks!.exe"

SilentInstall silent
AutoCloseWindow true
ShowInstDetails nevershow

# avoid UAC dialog in Windows Vista
# see http://tex.aanhet.net/vista/
# also http://zhidao.baidu.com/question/73693237.html
RequestExecutionLevel user

!include "LogicLib.nsh"

!include FileFunc.nsh
!insertmacro GetParameters

/*  Registry plug-in
http://nsis.sourceforge.net/Registry_plug-in
*/
;!include "Registry.nsh"
;!include "Sections.nsh"

!include "WordFunc.nsh"
!insertmacro WordReplace

Section

${If} $%buildtex% == "texlive"

    FileOpen $0 "$EXEDIR\TeXLive\tlpkg\texworks\texworks-setup.ini" a
    FileClose $0
    FileOpen $0 "$EXEDIR\TeXLive\tlpkg\texworks\texworks-setup.ini" w
    ; there is a bug in texworks when reading texworks-setup.ini
    ${WordReplace} "$EXEDIR" "\" "/" "+" $1
    FileWrite $0 "inipath = $1/TeXLive/tlpkg/texworks/$\r$\n"
    FileWrite $0 "libpath = $1/TeXLive/tlpkg/texworks/$\r$\n"
    FileWrite $0 "defaultbinpaths = $1/TeXLive/bin/win32;$\r$\n"
    FileClose $0
    IfErrors 0 +2
    MessageBox MB_OK "Error while initiating TeXworks!"

    # clear other texmf.cnf & fontconfig variables such as context-minimal's or texlive's
    System::Call 'kernel32::SetEnvironmentVariable(t, t) i("TEXMFCNF", "")'
    System::Call 'kernel32::SetEnvironmentVariable(t, t) i("TEXMFMAIN", "")'
    System::Call 'kernel32::SetEnvironmentVariable(t, t) i("TEXMFDIST", "")'
    System::Call 'kernel32::SetEnvironmentVariable(t, t) i("TEXMF", "")'
    System::Call 'kernel32::SetEnvironmentVariable(t, t) i("FONTCONFIG_FILE", "")'
    System::Call 'kernel32::SetEnvironmentVariable(t, t) i("FONTCONFIG_PATH", "")'
    System::Call 'kernel32::SetEnvironmentVariable(t, t) i("FC_CACHEDIR", "")'

    # set path variable for gswin32c.exe
    ReadEnvStr $R0 "PATH"
    StrCpy $R0 "$EXEDIR\TeXLive\tlpkg\tlgs\bin;$R0"
    System::Call 'kernel32::SetEnvironmentVariable(t, t) i("Path", R0)'

    # set ghostscript path, dvipdfmx need it
    System::Call 'kernel32::SetEnvironmentVariable(t, t) i("GS_LIB", "$EXEDIR\TeXLive\tlpkg\tlgs\lib;$EXEDIR\TeXLive\tlpkg\tlgs\fonts;")'
    ;System::Call 'kernel32::SetEnvironmentVariable(t, t) i("GS_DLL", "$EXEDIR\TeXLive\tlpkg\tlgs\bin\gsdll32.dll;")'

    ${GetParameters} $1
    Exec '"$EXEDIR\TeXLive\tlpkg\texworks\texworks.exe" $1'

${Else} ## miktex

    # clear other texmf.cnf & fontconfig variables such as context-minimal's or texlive's
    ;System::Call 'kernel32::SetEnvironmentVariable(t, t) i("TEXMFCNF", "")'
    ;System::Call 'kernel32::SetEnvironmentVariable(t, t) i("TEXMFMAIN", "")'
    ;System::Call 'kernel32::SetEnvironmentVariable(t, t) i("TEXMFDIST", "")'
    # when enabling the following, xelatex can not find the minion pro font!
    ;System::Call 'kernel32::SetEnvironmentVariable(t, t) i("TEXMF", "")'
    ;System::Call 'kernel32::SetEnvironmentVariable(t, t) i("FONTCONFIG_FILE", "")'
    ;System::Call 'kernel32::SetEnvironmentVariable(t, t) i("FONTCONFIG_PATH", "")'
    ;System::Call 'kernel32::SetEnvironmentVariable(t, t) i("FC_CACHEDIR", "")'

    # this way takes effect now
    ReadEnvStr $R0 "PATH"
    StrCpy $R0 "$EXEDIR\MiKTeX\miktex\bin;$R0"
    System::Call 'kernel32::SetEnvironmentVariable(t, t) i("Path", R0)'
    System::Free 0
    
    ${GetParameters} $1
    Exec '"$EXEDIR\MiKTeX\texmf\miktex\bin\texworks.exe" $1'
    
${EndIf}

/*
		IfFileExists "$EXEDIR\Local\*.*" +2
			CreateDirectory "$EXEDIR\Local" ; create directory for portable user profile
		System::Call 'Kernel32::SetEnvironmentVariableA(t, t) i("USERPROFILE", "$EXEDIR\Local").r0' ; set new user profile folder
		StrCmp "$0" "0" ProfileError
			Goto ProfileDone
		ProfileError:
			MessageBox MB_ICONEXCLAMATION|MB_OK "Can't set environment variable for new Userprofile!$\nLauncher will be terminated."
			#{registry::Unload}
			Abort
		ProfileDone:
*/
SectionEnd
		

/* depreted since lytex 1.6g
Section ""

    Call GetParameters
    Pop $Parameters
    ;;;;
    registry::Read "HKEY_CURRENT_USER\Software\TUG\TeXworks" "binaryPaths" .R0 .R1 .R2 .R3
    ;;MessageBox MB_OK "R0=$R0$\nR1=$R1$\nR2=$R2$\nR3=$R3"
    ${If} $R2 != ""
        ;MessageBox MB_OK "TeXworks exists"
        registry::Write "HKEY_CURRENT_USER\Software\TUG\TeXworks" "binaryPaths!" "$R2" "REG_MULTI_SZ" .R0
        registry::Write "HKEY_CURRENT_USER\Software\TUG\TeXworks" "binaryPaths" "$EXEDIR\W32TeX\bin" "REG_MULTI_SZ" .R0
        registry::Write "HKEY_CURRENT_USER\Software\TUG\TeXworks" "syntaxColoring" "LaTeX" "REG_SZ" .R0
        ;Exec ".\TeXworks\TeXworks.exe"
        ExecWait '"$EXEDIR\TeXworks\TeXworks.exe" $Parameters'
        registry::Read "HKEY_CURRENT_USER\Software\TUG\TeXworks" "binaryPaths!" .R0 .R1 .R2 .R3
        registry::Write "HKEY_CURRENT_USER\Software\TUG\TeXworks" "binaryPaths" "$R2" "REG_MULTI_SZ" .R0
        registry::DeleteValue "HKEY_CURRENT_USER\Software\TUG\TeXworks" "binaryPaths!" .r0
    ${Else}
        ;MessageBox MB_OK "TeXworks does not exist"
        ;Quit
        registry::CreateKey "HKEY_CURRENT_USER\Software" "TUG\TeXworks" .r0
        registry::Write "HKEY_CURRENT_USER\Software\TUG\TeXworks" "binaryPaths" "$EXEDIR\W32TeX\bin" "REG_MULTI_SZ" .R0
        registry::Write "HKEY_CURRENT_USER\Software\TUG\TeXworks" "syntaxColoring" "LaTeX" "REG_SZ" .R0
        ExecWait '"$EXEDIR\TeXworks\TeXworks.exe" $Parameters'
        registry::DeleteValue "HKEY_CURRENT_USER\Software\TUG\TeXworks" "binaryPaths" .r0
    ${EndIf}
*/
    /*
    ${registry::Read} "HKEY_CURRENT_USER\Software\TUG\TeXworks" "binaryPaths" .R0 .R1 .R2 .R3
    ;;MessageBox MB_OK "R0=$R0$\nR1=$R1$\nR2=$R2$\nR3=$R3"
    ${If} $R2 != ""
        ;MessageBox MB_OK "TeXworks exists"
        registry::MoveKey "HKEY_CURRENT_USER\Software\TUG\TeXworks" "HKEY_CURRENT_USER\Software\TUG\TeXworks" .R0
    ${EndIf}
    */

/*
SectionEnd
*/