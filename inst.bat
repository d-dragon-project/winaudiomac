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
if not exist c:\dsdt\asl.exe echo ERROR: Failed to copy asl.exe to c:\dsdt echo FILE EXIST
pause


cd c:\dsdt
@echo on
acpidump -b -z
asl /u dsdt.dat
copy dsdt.asl dsdt-modified.asl

@echo off
dir dsdt-modified.asl
if not exist c:\dsdt\dsdt-modified.asl echo ERROR: Failed to copy refs.txt to c:\dsdt echo FILE EXIST
cd c:\winaudiomac

@echo on
copy /y refs.txt c:\dsdt
@echo off
dir refs.txt 
if not exist c:\dsdt\refs.txt echo ERROR: Failed to copy refs.txt to c:\dsdt echo FILE EXIST
cd c:\dsdt
pause


@echo on
iasl -da -dl -fe refs.txt dsdt.dat
copy dsdt.dsl dsdt-modified.dsl
@echo off
if not exist c:\dsdt\dsdt-modified.dsl echo ERROR: Failed to copy dsdt-modified.dsl to c:\dsdt echo FILE EXIST
pause

@echo off
cd c:\winaudiomac
@echo on
copy /y dsdt-modified.dsl c:\dsdt


@echo off
cd c:\dsdt
@echo on
iasl -ve dsdt-modified.dsl
pause
exit