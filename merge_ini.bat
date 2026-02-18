:: Used to merage all data within .ini 

@echo off
set "output=database.txt"

break > "%output%"

for %%F in (*.ini) do (
    type "%%F" >> "%output%"
    echo.>>"%output%"
)
