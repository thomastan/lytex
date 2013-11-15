Name "LyTeX Setup"
Caption "LyTeX"
Icon "Setup.ico"
OutFile "..\LyTeX\Setup.exe"

# Windows Vista settings
RequestExecutionLevel user

SetCompressor /SOLID lzma

!include "LogicLib.nsh"

!include "FileFunc.nsh"
!insertmacro RefreshShellIcons
!insertmacro GetParameters

!include InstallOptions.nsh

Var /Global RealLang

XPStyle on

LoadLanguageFile "${NSISDIR}\Contrib\Language files\English.nlf"
LoadLanguageFile "${NSISDIR}\Contrib\Language files\SimpChinese.nlf"
;LoadLanguageFile "${NSISDIR}\Contrib\Language files\TradChinese.nlf"

LangString CustomPage ${LANG_ENGLISH} " - Choose Operation"
LangString CustomPage ${LANG_SIMPCHINESE} " - 选择所需的操作"

;Page "license"
Page custom customPage "" $(CustomPage)
Page "components"
;Page "directory"
Page "instfiles"

LangString ChooseJob ${LANG_ENGLISH} "Please select what you want to do:"
LangString ChooseJob ${LANG_SIMPCHINESE} "请选择你所要做的设置："

LangString SetupTeX ${LANG_ENGLISH} "Change installable or portable type"
LangString SetupTeX ${LANG_SIMPCHINESE} "改变安装版或绿色版类型"

LangString UpdateLyX ${LANG_ENGLISH} "Update to latest LyX from internet"
LangString UpdateLyX ${LANG_SIMPCHINESE} "在线升级 LyX 到最新版本"

LangString UpdateTeX ${LANG_ENGLISH} "Manage or update TeX programs and packages"
LangString UpdateTeX ${LANG_SIMPCHINESE} "升级或管理 TeX 程序和宏包"

Function customPage

   # skip this page when installing
   ${GetParameters} $0
   ${If} $0 == "install"
      Abort
   ${EndIf}

   !insertmacro INSTALLOPTIONS_WRITE "Setup.ini" "Field 1" "Text" $(ChooseJob)
   !insertmacro INSTALLOPTIONS_WRITE "Setup.ini" "Field 2" "Text" $(SetupTeX)
   !insertmacro INSTALLOPTIONS_WRITE "Setup.ini" "Field 3" "Text" $(UpdateLyX)
   !insertmacro INSTALLOPTIONS_WRITE "Setup.ini" "Field 4" "Text" $(UpdateTeX)
      
   !insertmacro INSTALLOPTIONS_DISPLAY "Setup.ini"
   # Update LyX
   !insertmacro INSTALLOPTIONS_READ $R2 "Setup.ini" "Field 3" "State"
   ;MessageBox MB_OK "$R2"
   StrCmp $R2 "1" 0 tex
   Exec "$EXEDIR\Common\update\update.bat"
   Quit
   tex:
   # Update TeX
   !insertmacro INSTALLOPTIONS_READ $R3 "Setup.ini" "Field 4" "State"
   ;MessageBox MB_OK "$R3"
   StrCmp $R3 "1" 0 default
   ${If} $%buildtex% == "texlive"
   Exec '"$EXEDIR\TeXLive\texshell.bat" texmgr'
   ${Else} ## miktex
   Exec '"$EXEDIR\MiKTeX\texshell.bat" texmgr'
   ${EndIf}
   Quit
   # Setup TeX
   default:
FunctionEnd

LangString SubCaption1 ${LANG_ENGLISH} " - Choose Operations"
LangString SubCaption1 ${LANG_SIMPCHINESE} " - 选择安装类型"
SubCaption 1 $(SubCaption1)

LangString InstallableType ${LANG_ENGLISH} "Installable Type"
LangString InstallableType ${LANG_SIMPCHINESE} "安装版"
InstType $(InstallableType)

LangString PortableType ${LANG_ENGLISH} "Portable Type"
LangString PortableType ${LANG_SIMPCHINESE} "绿色版"
InstType $(PortableType)

InstType /NOCUSTOM

LangString ComponentText1 ${LANG_ENGLISH} "$\r$\nYou can install LyTeX to system, or make it portable"
LangString ComponentText1 ${LANG_SIMPCHINESE} "$\r$\nLyTeX 既可以安装到用户系统, 也可以保持原有的绿色版."

LangString ComponentText2 ${LANG_ENGLISH} "Select installable or portable"
LangString ComponentText2 ${LANG_SIMPCHINESE} "选择＂安装版＂或＂绿色版＂"

LangString ComponentText3 ${LANG_ENGLISH} "$\r$\n$\r$\nInstallable: for installing or repairing LyTeX.$\r$\n$\r$\nPortable: for portablizing or removing LyTeX."
LangString ComponentText3 ${LANG_SIMPCHINESE} "$\r$\n$\r$\n安装版:用于安装或修复LyTeX.$\r$\n$\r$\n绿色版:用于绿化或删除LyTeX."

ComponentText "$(ComponentText1)" "$(ComponentText2)" "$(ComponentText3)"


;LangString MiscButtonText4 ${LANG_ENGLISH} "OK"
;LangString MiscButtonText4 ${LANG_SIMPCHINESE} "确定"
;MiscButtonText "" "" "" $(MiscButtonText4)

LangString InstallButtonText ${LANG_ENGLISH} "OK"
LangString InstallButtonText ${LANG_SIMPCHINESE} "确定"
InstallButtonText $(InstallButtonText)

BrandingText "zoho@ctex.org"
SpaceTexts none

LangString SubCaption3 ${LANG_ENGLISH} " - Make Operations"
LangString SubCaption3 ${LANG_SIMPCHINESE} " - 正在进行设置"
SubCaption 3 $(SubCaption3)

ShowInstDetails show

AutoCloseWindow true


LangString SectionA ${LANG_ENGLISH} "Add shortcuts to desktop"
LangString SectionA ${LANG_SIMPCHINESE} "添加快捷方式到用户桌面"
Section $(SectionA) SEC-A
# in other language SectionA will be empty
# but section with empty name will be hidden!

SectionIn 1

;SectionSetText ${SEC-A} $(SectionA)

CreateShortCut "$DESKTOP\LyX.lnk" "$EXEDIR\LyX!.exe"
CreateShortCut "$DESKTOP\TeXworks.lnk" "$EXEDIR\TeXworks!.exe"
${If} $LANGUAGE == "2052"
${orIf} $RealLang == "1028"
    CreateShortCut "$DESKTOP\LyTeX.lnk" "$EXEDIR\Manual\chinese\lytex.pdf"
${EndIf}
SectionEnd

LangString PortableSuite ${LANG_ENGLISH} " Portable Suite"
LangString PortableSuite ${LANG_SIMPCHINESE} " 绿色套装"
LangString SectionB ${LANG_ENGLISH} "Add shortcuts to start menu"
LangString SectionB ${LANG_SIMPCHINESE} "添加快捷方式到开始菜单"
Section $(SectionB)
SectionIn 1

CreateDirectory "$SMPROGRAMS\LyTeX$(PortableSuite)"
CreateShortCut "$SMPROGRAMS\LyTeX$(PortableSuite)\LyX.lnk" "$EXEDIR\LyX!.exe"
CreateShortCut "$SMPROGRAMS\LyTeX$(PortableSuite)\TeXworks.lnk" "$EXEDIR\TeXworks!.exe"
CreateShortCut "$SMPROGRAMS\LyTeX$(PortableSuite)\Setup.lnk" "$EXEDIR\Setup.exe"
CreateShortCut "$SMPROGRAMS\LyTeX$(PortableSuite)\About.lnk" "$EXEDIR\About.htm"
${If} $LANGUAGE == "2052" ; 2052 for Simplified Chinese
${orIf} $RealLang == "1028" ; 1028 for Traditional Chinese
    CreateShortCut "$SMPROGRAMS\LyTeX$(PortableSuite)\LyTeX.lnk" "$EXEDIR\Manual\chinese\lytex.pdf"
${EndIf}
SectionEnd

LangString SectionC ${LANG_ENGLISH} "Open .lyx file using LyX"
LangString SectionC ${LANG_SIMPCHINESE} "默认用 LyX 打开.lyx 文件"
Section $(SectionC)
SectionIn 1

WriteRegStr HKCU "Software\Classes\.lyx" "" "LyX.LyTeX"
WriteRegStr HKCU "Software\Classes\LyX.LyTeX" "" "LyX Document"
WriteRegStr HKCU "Software\Classes\LyX.LyTeX\shell\open\command" "" '$EXEDIR\LyX!.exe "%1"'
WriteRegStr HKCU "Software\Classes\LyX.LyTeX\DefaultIcon" "" "$EXEDIR\LyX!.exe,0"

${RefreshShellIcons}

SectionEnd

LangString SectionD ${LANG_ENGLISH} "Open .tex file using TeXworks"
LangString SectionD ${LANG_SIMPCHINESE} "默认用 TeXworks 打开 .tex 文件"
Section $(SectionD)
SectionIn 1

WriteRegStr HKCU "Software\Classes\.tex" "" "TeX.LyTeX"
WriteRegStr HKCU "Software\Classes\TeX.LyTeX" "" "TeX Document"
WriteRegStr HKCU "Software\Classes\TeX.LyTeX\shell\open\command" "" '$EXEDIR\TeXworks!.exe "%1"'
WriteRegStr HKCU "Software\Classes\TeX.LyTeX\DefaultIcon" "" "$EXEDIR\TeXworks!.exe,0"

${RefreshShellIcons}

SectionEnd

#LangString SectionE ${LANG_ENGLISH} "Open .pdf file using TeXworks"
#LangString SectionE ${LANG_SIMPCHINESE} "默认用 TeXworks 打开 .pdf 文件"
#Section /o $(SectionE)
#SectionEnd

LangString SectionH ${LANG_ENGLISH} "Remove all shortcuts and opentypes"
LangString SectionH ${LANG_SIMPCHINESE} "删除所有快捷方式和打开方式"
Section -$(SectionH)
SectionIn 2

Delete "$DESKTOP\LyX.lnk"
Delete "$DESKTOP\TeXworks.lnk"
Delete "$DESKTOP\LyTeX.lnk"

RMDir /r "$SMPROGRAMS\LyTeX$(PortableSuite)"
DeleteRegValue HKCU "Software\Classes\.lyx" ""
DeleteRegKey HKCU "Software\Classes\LyX.LyTeX"
DeleteRegValue HKCU "Software\Classes\.tex" ""
DeleteRegKey HKCU "Software\Classes\TeX.LyTeX"
${RefreshShellIcons}

SectionEnd


Function .onInit

    # If language is not Chinese, should change it to Enlish.
    ${If} $LANGUAGE != "2052"
        strcpy $RealLang $LANGUAGE
        strcpy $LANGUAGE "1033"
    ${EndIf}

    !insertmacro INSTALLOPTIONS_EXTRACT "Setup.ini"

    # Detect LyX version
    # ??? take no effect when LyX20.exe exists
    /*
    StrCpy $LYXDIR "LyX16"
    IfFileExists "$EXEDIR\LyX20\bin\lyx!.exe" 0 donever
       StrCpy $LYXDIR "LyX20"
       Goto donever
    IfFileExists "$EXEDIR\LyX21" 0 donever
       StrCpy $LYXDIR "LyX21"
       Goto donever
    donever:
    MessageBox MB_OK "$LYXDIR"
    */
FunctionEnd
