; NSIS 变量调试脚本 - 改进版
; 确保保存为 UTF-8 with BOM 编码

Unicode true
RequestExecutionLevel user
ShowInstDetails show

; 基本设置
Name "NSIS Variables Debugger"
OutFile "NSISVariablesDebug.exe"
Caption "NSIS Variables Debugger"

; 变量定义
Var LogFile
Var CurrentTime
Var CurrentDate

; 页面设置
Page instfiles

Section "Debug Variables"

  ; 获取当前时间日期
  Call GetDateTime
  Pop $CurrentDate
  Pop $CurrentTime

  ; 设置日志文件路径 - 使用临时目录确保可写
  StrCpy $LogFile "$TEMP\NSIS_Variables_Debug.log"

  ; 创建日志文件
  FileOpen $0 $LogFile w
  FileWrite $0 "=== NSIS Variables Debug Log ===$\r$\n"
  FileWrite $0 "Generated at: $CurrentTime on $CurrentDate$\r$\n$\r$\n"

  ; 1. 记录系统信息
  FileWrite $0 "---- System Information ----$\r$\n"
  ${If} ${RunningX64}
    FileWrite $0 "Architecture: 64-bit$\r$\n"
  ${Else}
    FileWrite $0 "Architecture: 32-bit$\r$\n"
  ${EndIf}
  FileWrite $0 "NSIS Version: ${NSIS_VERSION}$\r$\n$\r$\n"

  ; 2. 记录内置变量
  FileWrite $0 "---- Built-in Variables ----$\r$\n"
  FileWrite $0 "PROGRAMFILES: $\"$PROGRAMFILES$\"$\r$\n"
  FileWrite $0 "PROGRAMFILES64: $\"$PROGRAMFILES64$\"$\r$\n"
  FileWrite $0 "INSTDIR: $\"$INSTDIR$\"$\r$\n"
  FileWrite $0 "TEMP: $\"$TEMP$\"$\r$\n"
  FileWrite $0 "SYSDIR: $\"$SYSDIR$\"$\r$\n"
  FileWrite $0 "WINDIR: $\"$WINDIR$\"$\r$\n$\r$\n"

  ; 3. 记录环境变量
  FileWrite $0 "---- Environment Variables ----$\r$\n"
  FileWrite $0 "ProgramFiles: $\"$%ProgramFiles%$\"$\r$\n"
  FileWrite $0 "ProgramFiles(x86): $\"$%ProgramFiles(x86)%$\"$\r$\n"
  FileWrite $0 "SystemRoot: $\"$%SystemRoot%$\"$\r$\n$\r$\n"

  ; 4. 直接显示关键变量
  FileWrite $0 "---- Key Variables for Debugging ----$\r$\n"
  FileWrite $0 "Log file location: $\"$LogFile$\"$\r$\n"
  FileWrite $0 "Working directory: $\"$EXEDIR$\"$\r$\n$\r$\n"

  FileWrite $0 "=== End of Log ==="
  FileClose $0

  ; 显示结果
  DetailPrint " "
  DetailPrint "=== NSIS Variables Debug Results ==="
  DetailPrint "PROGRAMFILES: $PROGRAMFILES"
  DetailPrint "PROGRAMFILES64: $PROGRAMFILES64"
  DetailPrint "INSTDIR: $INSTDIR"
  DetailPrint "TEMP: $TEMP"
  DetailPrint "Log file saved to: $LogFile"
  DetailPrint " "

  ; 显示完成信息
  MessageBox MB_OK|MB_ICONINFORMATION \
    "Debugging completed.$\n$\n\
    Key results:$\n\
    PROGRAMFILES: $PROGRAMFILES$\n\
    PROGRAMFILES64: $PROGRAMFILES64$\n\
    INSTDIR: $INSTDIR$\n$\n\
    Full log saved to:$\n$LogFile"

SectionEnd

; 获取日期时间函数
Function GetDateTime
  ; 获取当前时间
  System::Call 'kernel32::GetLocalTime(t .r0)'
  System::Call '*$0(&i2, &i2, &i2, &i2, &i2, &i2, &i2, &i2)i (.r1, .r2, .r3, .r4, .r5, .r6, .r7, .r8)'
  System::Free $0
  
  ; 格式化日期: YYYY-MM-DD
  IntFmt $2 "%02i" $2 ; 月
  IntFmt $4 "%02i" $4 ; 日
  StrCpy $CurrentDate "$1-$2-$4"
  
  ; 格式化时间: HH:MM:SS
  IntFmt $5 "%02i" $5 ; 时
  IntFmt $6 "%02i" $6 ; 分
  IntFmt $7 "%02i" $7 ; 秒
  StrCpy $CurrentTime "$5:$6:$7"
  
  Push $CurrentTime
  Push $CurrentDate
FunctionEnd
