@echo off
powershell -executionpolicy remotesigned -nop -ep ByPass "%~dp0ConvertPowerShellToExe.ps1"