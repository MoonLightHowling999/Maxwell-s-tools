@echo off
setlocal EnableDelayedExpansion

title AddCharModel Generator

:: NOTE: make sure to add more options in the future, like: ability to scan from different directories, etc.
set /p "START_ID=Enter starting ID (e.g. 20044): "

:: Validate input is a number
set "CHECK=%START_ID%"
for /f "delims=0123456789" %%A in ("!CHECK!") do (
    echo [ERROR] Invalid input. Please enter a numeric ID.
    pause
    exit /b 1
)

set /p "CHAR_ID=Enter character model ID (e.g. 305): "

for /f "delims=0123456789" %%A in ("!CHAR_ID!") do (
    echo [ERROR] Invalid input. Please enter a numeric ID.
    pause
    exit /b 1
)

echo.

set "OUTPUT_FILE=output.txt"
set "COUNT=0"
set "CURRENT_ID=!START_ID!"

:: Clear or create output file
> "!OUTPUT_FILE!" echo. & break > "!OUTPUT_FILE!"

:: check all .dff files in current directory
for %%F in (*.dff) do (
    set "BASE=%%~nF"
    set "DFF_FILE=%%~nxF"
    set "TXD_FILE=%%~nF.txd"

    :: Check if matching .txd exists
    if exist "!TXD_FILE!" (
        set "LINE=AddCharModel(!CHAR_ID!, !CURRENT_ID!, "!DFF_FILE!", "!TXD_FILE!"); // New"
        echo !LINE!
        echo !LINE! >> "!OUTPUT_FILE!"

        set /a COUNT+=1
        set /a CURRENT_ID+=1
    ) else (
        echo skipped: !DFF_FILE!
    )
)

echo.
if !COUNT! == 0 (
    echo No pairs found.
) else (
    echo !COUNT! line(s) written to !OUTPUT_FILE!
)

echo.
pause
endlocal