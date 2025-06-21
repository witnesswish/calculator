; The name of the installer
Name "HelloLiam"

; The file to write
OutFile "hello_liam_setup.exe"

; Request application privileges for Windows Vista
RequestExecutionLevel user

; Build Unicode installer
Unicode True

; The default installation directory
InstallDir $PROGRAMFILES64\HelloLiam

;Request application privileges for Windows Vista
RequestExecutionLevel admin
;--------------------------------
; Pages

Page directory
Page instfiles

;--------------------------------
; The stuff to install
Section "" ;No components page, name is not important
  ; Set output path to the installation directory.
  SetOutPath $INSTDIR
  ; Put file there
  ;File HelloLiam.exe ;add a file.
  File /r ".\*" 
SectionEnd ; end the section
