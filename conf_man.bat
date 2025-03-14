@echo off
setlocal

set "config_file=%~dp0paths.ini"
set "prefs_file=%~dp0preferences.ini"

:::::::::::::::::::::::::::::::
:::::Main Menu Conf Man:::::
:::::::::::::::::::::::::::::::
:conf_man_menu
cls
ECHO "Configuration Management Menu"
ECHO "==============================="
ECHO "1. Initialize paths.ini configuration"
ECHO "2. Echo paths.ini values"
ECHO "3. Lock paths.ini (Read Only)"
ECHO "4. Unlock paths.ini (No Read Only)"
ECHO "5. Edit paths.ini (Opens Notepad)"
ECHO "6. Test Paths Validity"
ECHO "7. Go to preferences.ini menu"
ECHO "8. Exit"
choice /c 12345678 /m "Choose an option: "
if errorlevel 8 goto :exit_conf_man
if errorlevel 7 goto :preferences_menu
if errorlevel 6 goto :test_paths_validity
if errorlevel 5 goto :edit_paths_ini
if errorlevel 4 goto :unlock_paths_ini
if errorlevel 3 goto :lock_paths_ini
if errorlevel 2 goto :echo_paths_ini
if errorlevel 1 goto :initialize_paths_ini
goto :conf_man_menu

:::::::::::::::::::::::::::::::::::::
:::::Initialize paths.ini:::::
:::::::::::::::::::::::::::::::::::::
:initialize_paths_ini
if not exist "%config_file%" (
    ECHO "Creating paths.ini with default settings..."
    ECHO "[Paths]" >> "%config_file%"
    ECHO "script_dir=." >> "%config_file%"
    ECHO "comfy_path=ComfyUI" >> "%config_file%"
    ECHO "venv_path=venv\Scripts\" >> "%config_file%"
    ECHO "activate_script=%%venv_path%%activate.bat" >> "%config_file%"
    ECHO "deactivate_script=%%venv_path%%deactivate.bat" >> "%config_file%"
    ECHO "venv_python=%%venv_path%%python.exe" >> "%config_file%"
    ECHO "venv_pip=%%venv_path%%pip.exe" >> "%config_file%"
    ECHO "python_executable=%%USERPROFILE%%\AppData\Local\Programs\Python\Python312\python.exe" >> "%config_file%"
    ECHO.
    ECHO "Setting paths.ini to read-only..."
    attrib +r "%config_file%"
    if errorlevel 1 (
        ECHO "Error setting paths.ini to read-only."
    ) else (
        ECHO "paths.ini created and set to read-only."
    )
) else (
    ECHO "paths.ini already exists."
)
pause
goto :conf_man_menu

:::::::::::::::::::::::::::::::::
:::::Echo paths.ini values:::::
:::::::::::::::::::::::::::::::::
:echo_paths_ini
ECHO "--- paths.ini Contents ---"
type "%config_file%"
ECHO "--------------------------"
pause
goto :conf_man_menu

:::::::::::::::::::::::::::::
:::::Lock paths.ini:::::
:::::::::::::::::::::::::::::
:lock_paths_ini
attrib +r "%config_file%"
if errorlevel 1 (
    ECHO "Error setting paths.ini to Read-Only."
) else (
    ECHO "paths.ini set to Read-Only."
)
pause
goto :conf_man_menu

:::::::::::::::::::::::::::::::
:::::Unlock paths.ini:::::
:::::::::::::::::::::::::::::::
:unlock_paths_ini
attrib -r "%config_file%"
if errorlevel 1 (
    ECHO "Error removing Read-Only attribute from paths.ini."
) else (
    ECHO "Read-Only attribute removed from paths.ini."
)
pause
goto :conf_man_menu

:::::::::::::::::::::::::::::
:::::Edit paths.ini:::::
:::::::::::::::::::::::::::::
:edit_paths_ini
ECHO "Opening paths.ini in Notepad..."
start "" notepad "%config_file%"
goto :conf_man_menu

::::::::::::::::::::::::::::::::::::
:::::Test Paths Validity:::::
::::::::::::::::::::::::::::::::::::
:test_paths_validity
ECHO "--- Testing Paths in paths.ini ---"
for /f "delims=" %%i in ('type "%config_file%" ^| findstr "="') do (
    for /f "tokens=1* delims==" %%a in ("%%i") do (
        set "key=%%a"
        set "value=%%b"
        if not exist "%%b" (
            ECHO "Warning: Path for '%key%' ('%%b') does not exist."
        )
    )
)
ECHO "------------------------------------"
pause
goto :conf_man_menu

:::::::::::::::::::::::::::::::::::::::
:::::Preferences Menu Conf Man:::::
:::::::::::::::::::::::::::::::::::::::
:preferences_menu
cls
ECHO "Preferences Menu"
ECHO "=================="
ECHO "1. Initialize preferences.ini"
ECHO "2. Modify Player Name"
ECHO "3. Exit to Main Config Menu"
choice /c 123 /m "Choose an option: "
if errorlevel 3 goto :conf_man_menu
if errorlevel 2 goto :modify_player_name
if errorlevel 1 goto :initialize_preferences_ini
goto :preferences_menu

::::::::::::::::::::::::::::::::::::::::::
:::::Initialize preferences.ini:::::
::::::::::::::::::::::::::::::::::::::::::
:initialize_preferences_ini
if not exist "%prefs_file%" (
    ECHO "Creating preferences.ini with default settings..."
    ECHO "[Preferences]" >> "%prefs_file%"
    ECHO "player_name=Lambda User" >> "%prefs_file%"
    ECHO "preferences.ini created."
) else (
    ECHO "preferences.ini already exists."
)
pause
goto :preferences_menu

:::::::::::::::::::::::::::::::::::::::
:::::Modify Player Name:::::
:::::::::::::::::::::::::::::::::::::::
:modify_player_name
set /p "new_player_name=Enter new Player Name: "
if "%new_player_name%"=="" (
    ECHO "Player Name cannot be empty."
    pause
    goto :modify_player_name
)
ECHO "[Preferences]" > "%prefs_file%"
ECHO "player_name=%new_player_name%" >> "%prefs_file%"
ECHO "Player Name updated."
pause
goto :preferences_menu

:::::::::::::::::::::::::::::::
:::::Exit Conf Man:::::
:::::::::::::::::::::::::::::::
:exit_conf_man
endlocal
exit /b 0