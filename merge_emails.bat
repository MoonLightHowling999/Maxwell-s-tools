@echo off
set "output=emails.txt"

break > "%output%"

for %%F in (*.ini) do (
    for /f "tokens=2 delims==" %%E in ('findstr /i "^email=" "%%F"') do (
        echo %%E>>"%output%"
    )
)
