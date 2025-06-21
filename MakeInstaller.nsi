; Granted by hand
Name "Calculator"

OutFile "CalculatorSetup64.exe"
RequestExecutionLevel user
Unicode True
InstallDir $PROGRAMFILES64\Calculator
RequestExecutionLevel admin

Page directory
Page instfiles

Section ""
  SetOutPath $INSTDIR
  File /r "installer\*" 
SectionEnd
