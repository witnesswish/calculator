; 测试 NSIS 内置变量识别问题
; 保存为 UTF-8 with BOM 编码

Unicode true ; 确保 Unicode 支持
RequestExecutionLevel user ; 不需要管理员权限

; 名称和输出文件
Name "NSIS Variables Test"
OutFile "NSISVariablesTest.exe"
Caption "NSIS Variables Test"

; 包含必要的头文件
!include LogicLib.nsh
!include x64.nsh

; 定义变量
Var ProgramFilesPath
Var ProgramFilesX64Path
Var InstDirPath
Var TempPath
Var SystemPath

; 安装界面
Page instfiles

Section "Test Variables"

  ; 记录变量值到日志文件
  StrCpy $ProgramFilesPath "$PROGRAMFILES"
  StrCpy $ProgramFilesX64Path "$PROGRAMFILES64"
  StrCpy $InstDirPath "$INSTDIR"
  StrCpy $TempPath "$TEMP"
  StrCpy $SystemPath "$SYSDIR"

  ; 创建日志文件
  FileOpen $0 "$EXEDIR\NSIS_Variables_Log.txt" w
  FileWrite $0 "=== NSIS Variables Test Log ===$\r$\n"
  FileWrite $0 "Generated at: [$\"$%TIME%$\" on $\"$%DATE%$\"]$\r$\n$\r$\n"
  
  ; 写入系统信息
  FileWrite $0 "System Information:$\r$\n"
  FileWrite $0 "-------------------$\r$\n"
  ${If} ${RunningX64}
    FileWrite $0 "Running on: 64-bit system$\r$\n"
  ${Else}
    FileWrite $0 "Running on: 32-bit system$\r$\n"
  ${EndIf}
  FileWrite $0 "NSIS Version: ${NSIS_VERSION}$\r$\n$\r$\n"

  ; 写入变量值
  FileWrite $0 "NSIS Built-in Variables:$\r$\n"
  FileWrite $0 "------------------------$\r$\n"
  FileWrite $0 "PROGRAMFILES: $\"$PROGRAMFILES$\"$\r$\n"
  FileWrite $0 "PROGRAMFILES64: $\"$PROGRAMFILES64$\"$\r$\n"
  FileWrite $0 "INSTDIR: $\"$INSTDIR$\"$\r$\n"
  FileWrite $0 "TEMP: $\"$TEMP$\"$\r$\n"
  FileWrite $0 "SYSDIR: $\"$SYSDIR$\"$\r$\n"
  FileWrite $0 "WINDIR: $\"$WINDIR$\"$\r$\n$\r$\n"

  ; 写入环境变量
  FileWrite $0 "Environment Variables:$\r$\n"
  FileWrite $0 "----------------------$\r$\n"
  FileWrite $0 "ProgramFiles (env): $\"$%ProgramFiles%$\"$\r$\n"
  FileWrite $0 "ProgramFiles(x86) (env): $\"$%ProgramFiles(x86)%$\"$\r$\n"
  FileWrite $0 "SystemRoot: $\"$%SystemRoot%$\"$\r$\n$\r$\n"

  ; 写入注册表值
  FileWrite $0 "Registry Values:$\r$\n"
  FileWrite $0 "---------------$\r$\n"
  ReadRegStr $1 HKLM "SOFTWARE\Microsoft\Windows\CurrentVersion" "ProgramFilesDir"
  FileWrite $0 "HKLM ProgramFilesDir: $\"$1$\"$\r$\n"
  ReadRegStr $1 HKLM "SOFTWARE\Microsoft\Windows\CurrentVersion" "ProgramFilesPath"
  FileWrite $0 "HKLM ProgramFilesPath: $\"$1$\"$\r$\n$\r$\n"

  FileWrite $0 "=== End of Log ==="
  FileClose $0

  ; 显示完成信息
  DetailPrint "Variable test completed."
  DetailPrint "Log saved to: $\"$EXEDIR\NSIS_Variables_Log.txt$\""
  
  ; 如果是交互模式，显示消息框
  IfSilent +2
    MessageBox MB_OK "Variable test completed.$\nCheck $\"$EXEDIR\NSIS_Variables_Log.txt$\" for results."

SectionEnd
