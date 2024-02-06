@echo on

mkdir c:\dsdt
cd c:\winaudiomac\WBT
xcopy c:\winaudiomac\WBT\*.* c:\dsdt
cd c:\winaudiomac
copy /y asl.exe c:\dsdt
cd c:\dsdt
@echo off
dir
dir asl.exe
if not exist c:\dsdt\asl.exe echo ERROR: Failed to copy asl.exe to c:\dsdt
pause


cd c:\dsdt
@echo on
acpidump -b -z
asl /u dsdt.dat
copy dsdt.asl dsdt-modified.asl

@echo off
dir dsdt-modified.asl
if not exist c:\dsdt\dsdt-modified.asl echo ERROR: Failed to copy refs.txt to c:\dsdt 
cd c:\winaudiomac

@echo on
copy /y refs.txt c:\dsdt
@echo off
dir refs.txt 
if not exist c:\dsdt\refs.txt echo ERROR: Failed to copy refs.txt to c:\dsdt
cd c:\dsdt
pause


@echo on
iasl -da -dl -fe refs.txt dsdt.dat
copy dsdt.dsl dsdt-modified.dsl
@echo off
if not exist c:\dsdt\dsdt-modified.dsl echo ERROR: Failed to copy dsdt-modified.dsl to c:\dsdt
pause

@echo off
echo "Follow Instructions-2.rtf first before proceeding with next step"
pause

echo "Is Instructions-2.rtf completed ?"
pause

@echo off
:choice
set /P c=Are you done with Instructions-2.rtf[Y/N]?
if /I "%c%" EQU "Y" goto :1
if /I "%c%" EQU "N" goto :choice

:1
@echo off
cd c:\dsdt
@echo on
iasl -ve dsdt-modified.dsl
pause
exit