@echo off

mkdir c:\dsdt
c: & cd \dsdt
set 64bit_OS_asl="C:\Program Files (x86)\Windows Kits\10\Tools\x64\ACPIVerify\asl.exe"
set 32bit_OS_asl="C:\Program Files (x86)\Windows Kits\10\Tools\x86\ACPIVerify\asl.exe"
xcopy c:\winaudiomac\WBT\*.* c:\dsdt
copy c:\winaudiomac\asl.exe c:\dsdt
acpidump -b -z
asl /u dsdt.dat
copy dsdt.asl dsdt-modified.asl

cd c:\winaudiomac
copy /y refs.txt c:\dsdt


c: & cd \dsdt
iasl -da -dl -fe refs.txt dsdt.dat
copy dsdt.dsl dsdt-modified.dsl


c: & cd \winaudiomac
copy /y dsdt-modified.dsl c:\dsdt


c: & cd \dsdt
iasl -ve dsdt-modified.dsl

c: & cd \dsdt
dir dsdt-modified.aml
asl /loadtable dsdt-modified.aml  


c: & cd \dsdt
bcdedit -set TESTSIGNING ON
c: & cd \windows\system32
bcdedit -set TESTSIGNING ON
exit
