; 最小化测试脚本 - minimal_test.nsi
Unicode true
OutFile "MinimalTest.exe"
ShowInstDetails show

Section
    DetailPrint "=== 基本变量测试 ==="
    DetailPrint "PROGRAMFILES: $PROGRAMFILES"
    DetailPrint "PROGRAMFILES64: $PROGRAMFILES64"
    DetailPrint "INSTDIR: $INSTDIR"
    DetailPrint "TEMP: $TEMP"
SectionEnd
