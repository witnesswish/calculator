; Granted by hand
Name "Calculator"

OutFile "CalculatorSetup64.exe"
RequestExecutionLevel user
Unicode True
InstallDir $PROGRAMFILES64\Calculator
RequestExecutionLevel admin

Page directory
Page instfiles

UninstPage uninstConfirm
UninstPage instfiles

Section ""
  SetOutPath $INSTDIR
  File /r "installer\*"
  WriteUninstaller "$INSTDIR\Uninstall.exe"
  CreateDirectory "$SMPROGRAMS\calculator"
  CreateShortCut "$SMPROGRAMS\calculator\calculator.lnk" "$INSTDIR\calculator.exe"
  CreateShortCut "$SMPROGRAMS\calculator\Uninstall.lnk" "$INSTDIR\Uninstall.exe"
SectionEnd
  
Section "Uninstall"
  Delete "$SMPROGRAMS\calculator\calculator.lnk"
  Delete "$SMPROGRAMS\calculator\Uninstall.lnk"
  RMDir "$SMPROGRAMS\calculator"
  RMDir /r "$INSTDIR"
  SetAutoClose true
SectionEnd
