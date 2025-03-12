@echo off
setlocal enabledelayedexpansion
:: --- Header ---
:: File: code_consolidate.bat
:: Description: A tool to consolidate all .bat files, by alphabetic order, in a .txt file in order to review it in a single reading but also to consolidate code into a single file which must be edited to prevent duplicate entries, :checkpoints and functions.
:: Version: 0.005 (Fixed the code and tested functions and it should work)
:: Author: Cheesecake Johnson
:: Date: 2025-Q1
:: Dependencies: None
:: --- Usage Example ---
:: Self-contained but can also be invoked via the menus of our main project as a function.
:: --- Initialization ---
:: Consolidation will adjoin all code together into a .txt file. You shouldn't rename it to .bat before reviewing duplicate code first and consolidating it manually
:: --- Configuration ---
set "output_dir=%~dp0bat_consolidate"  :: Output directory
set "output_file=%output_dir%\batch_code_summary.txt"
set "archive_dir=%output_dir%\archive" :: Archive subdirectory

:: --- Create Directories ---
if not exist "%output_dir%" mkdir "%output_dir%"
if not exist "%archive_dir%" mkdir "%archive_dir%"

:: --- Archive Existing Summary File (if it exists) ---
if exist "%output_file%" (
    call :archive_file "%output_file%"
)

:: --- Main Menu ---
:main_menu
cls
echo Batch Code Summary Generator
echo.
echo 1. Export with date and filename
echo 2. Consolidate code only (no date or filename)
echo 3. Exit
echo.
choice /c 123 /n /m "Choose an option: "

if errorlevel 3 exit /b 0
if errorlevel 2 goto :consolidate_only
if errorlevel 1 goto :export_with_details

:export_with_details
:: Get the current date
for /f "tokens=1-6 delims=/ " %%a in ('date /t') do (
    set "mydate=%%c-%%a-%%b"
)

:: Clear the output file (it's already archived)
if exist "%output_file%" del "%output_file%"

:: Loop through all .bat files in the current directory
for %%a in (*.bat) do (
    echo Processing file: %%a

    :: Append filename and date to the output file
    echo ---------------------------------------- >> "%output_file%"
    echo Filename: %%a >> "%output_file%"
    echo Date: %mydate% >> "%output_file%"
    echo ---------------------------------------- >> "%output_file%"

    :: Append the content of the .bat file to the output file
    type "%%a" >> "%output_file%"

    :: Add an extra separator
    echo. >> "%output_file%"
    echo. >> "%output_file%"
)
goto :finish

:consolidate_only
:: Clear the output file (it's already archived)
if exist "%output_file%" del "%output_file%"

:: Loop through all .bat files in the current directory
for %%a in (*.bat) do (
    echo Processing file: %%a

    :: Append the content of the .bat file to the output file (no header)
    type "%%a" >> "%output_file%"

    :: Add an extra separator
    echo. >> "%output_file%"
    echo. >> "%output_file%"
)
goto :finish


:finish
echo Summary created: %output_file%
endlocal
pause
exit /b 0

:: --- Subroutines ---

:archive_file
set "file_to_archive=%~1"
set "base_name=%~n1"
set "ext=%~x1"
set "backup_num=1"

:find_backup_name
set "padded_num=00000000%backup_num%"
set "padded_num=!padded_num:~-8!"
set "backup_file=%archive_dir%\%base_name%.!padded_num!%ext%"

if exist "!backup_file!" (
    set /a backup_num+=1
    goto :find_backup_name
)

echo Archiving "%file_to_archive%" to "!backup_file!"
move "%file_to_archive%" "!backup_file!" >nul 2>&1
if errorlevel 1 (
    echo Error: Could not archive %file_to_archive% to !backup_file!
    pause
    exit /b 1
)
exit /b 0