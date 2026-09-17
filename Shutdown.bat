@echo off
:: Check for admin rights
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo Requesting administrative privileges...
    powershell -Command "Start-Process '%~f0' -Verb runAs"
    exit /b
)

:input
set /p number=Enter a number (minutes): 

:: Validate that input is numeric
echo %number%| findstr /r "^[0-9][0-9]*$" >nul
if errorlevel 1 (
    echo Invalid input! Please enter numbers only.
    goto input
)

set /a result=%number% * 60
echo This PC will shutdown in %number% minutes
timeout /t %result% /nobreak
shutdown -s -f
pause
