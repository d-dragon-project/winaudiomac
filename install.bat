@echo off
echo Create c:\dsdt folder
mkdir c:\dsdt
echo off
c: & cd \dsdt
echo Extract Windows Binary Tools (WBT - Dec 2016) to c:\dsdt directory. 
xcopy c:\winaudiomac\WBT\*.* c:\dsdt
c: & cd \windows\system32
set 64bit_OS_asl="C:\Program Files (x86)\Windows Kits\10\Tools\x64\ACPIVerify\asl.exe"
set 32bit_OS_asl="C:\Program Files (x86)\Windows Kits\10\Tools\x86\ACPIVerify\asl.exe"
copy /y %32bit_OS_asl% c:\dsdt > nul & copy /y %64bit_OS_asl% c:\dsdt > nul
if not exist c:\dsdt\asl.exe echo ERROR: Failed to copy asl.exe to c:\dsdt
cd c:\dsdt
@echo off
pause

echo Dump your ACPI tables to disk files (dsdt.asl and dsdt.dat) 
cd c:\dsdt
@echo on
acpidump -b -z
asl /u dsdt.dat
copy dsdt.asl dsdt-modified.asl
@echo off
dir dsdt-modified.asl
if not exist c:\dsdt\dsdt-modified.asl echo ERROR: Failed to copy refs.txt to c:\dsdt echo FILE EXIST

echo Use the Intel method and Copy refs.txt to c:\dsdt
cd c:\winaudiomac
@echo on
copy /y refs.txt c:\dsdt
@echo off
dir refs.txt 
if not exist c:\dsdt\refs.txt echo ERROR: Failed to copy refs.txt to c:\dsdt echo FILE EXIST
pause

c: & cd \dsdt
@echo on
iasl -da -dl -fe refs.txt dsdt.dat
copy dsdt.dsl dsdt-modified.dsl
@echo off
if not exist c:\dsdt\dsdt-modified.dsl echo ERROR: Failed to copy dsdt-modified.dsl to c:\dsdt echo FILE EXIST
pause

@echo on
echo "Modify dsdt-modified.dsl
@echo off
c: & cd \winaudiomac
copy /y dsdt-modified.dsl c:\dsdt


@echo off
c: & cd \dsdt
echo Create a dsdt-modified.aml file . The  '-ve' disables warning messages.
@echo on
iasl -ve dsdt-modified.dsl
@echo off
c: & cd \dsdt
dir dsdt-modified.aml
if not exist c:\dsdt\dsdt-modified.aml echo ERROR: Failed to copy dsdt-modified.dsl to c:\dsdt echo FILE EXIST
@echo on
asl /loadtable dsdt-modified.aml  

@echo off
echo Enable TESTSIGNING mode for the registry override to apply. At the Command Prompt (admin) type:
c: & cd \dsdt
echo on
bcdedit -set TESTSIGNING ON
echo off
c: & cd \windows\system32
echo on
bcdedit -set TESTSIGNING ON
