@echo off

cd c:\dsdt
@echo on
iasl -ve dsdt-modified.dsl
pause
exit