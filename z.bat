@echo off
setlocal enabledelayedexpansion

:: Set directories and file names
set "MAIN_FILE=main"

set "SOURCE_DIR=source"
set "OBJ_DIR=bin/temp"
set "OUTPUT_DIR=bin"
set "EXE_NAME=%1.exe"

if "%1"=="" set "EXE_NAME=%MAIN_FILE%.exe"

:: Create necessary directories if they don't exist
if not exist "%OBJ_DIR%" mkdir "%OBJ_DIR%"
if not exist "%OUTPUT_DIR%" mkdir "%OUTPUT_DIR%"

for %%f in (%OBJ_DIR%\*.o) do (
    del "%OBJ_DIR%\%%~nf.o"
)

:: Compile each source file to an object file
for %%f in (%SOURCE_DIR%\*.cpp) do (
    g++ -c "%%f" -o "%OBJ_DIR%\%%~nf.o"
)

:: Compile main file to an object file
g++ -c "%MAIN_FILE%.cpp" -o "%OBJ_DIR%\%MAIN_FILE%.o"

:: Collect object files
set "OBJ_FILES="
for %%f in (%OBJ_DIR%\*.o) do (
    set "OBJ_FILES=!OBJ_FILES! %%f"
)

:: Link all object files into the final executable
g++ !OBJ_FILES! -o "%OUTPUT_DIR%\%EXE_NAME%"

if "%2"=="-r" start ./"%OUTPUT_DIR%\%EXE_NAME%" 

endlocal
