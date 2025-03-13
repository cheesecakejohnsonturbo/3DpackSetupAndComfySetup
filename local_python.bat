@echo off
setlocal enabledelayedexpansion
set "script_dir=%~dp0"
set "comfy_path=%~dp0\ComfyUI"
set "venv_path=%script_dir%\venv\Scripts\"
set "activate_script=%venv_path%activate.bat"
set "deactivate_script=%venv_path%deactivate.bat"
set "venv_python=%venv_path%python.exe"
set "venv_pip=%venv_path%pip.exe"

if not exist "%venv_path%" (
    echo Venv path missing
    pause
    exit /b 1
)
if not exist "%activate_script%" (
    echo It broke, Brams! Activate script not found.
    pause
    exit /b 1
)
if not exist "%deactivate_script%" (
    echo It broke, Brams! Deactivate script not found.
    pause
    exit /b 1
)

:py_activate
call "%activate_script%"

:loop_python_commands
echo Suggested Commands:
echo   - python -m pip install -r requirements.txt (Install requirements)
echo   - python --version (Show Python version)
echo   - python -m pip -h (Display pip help)
echo   - python -m pip install --upgrade pip
echo   - exit (Return to the main menu)
echo.
set /p "python_command=>>> "

if /i "!python_command!"=="exit" goto :end_loop_python_commands

if /i "!python_command:~0,6!"=="python" (
    "%venv_python%" !python_command:~7!
    if errorlevel 1 (
        echo Error executing python command.
    )
    pause
) else if /i "!python_command:~0,3!"=="pip" (
    "%venv_pip%" !python_command:~4!
    if errorlevel 1 (
        echo Error executing pip command.
    )
    pause
) else (
    echo Invalid Command
    pause
)

goto :loop_python_commands

:end_loop_python_commands

:py_deactivate
call "%deactivate_script%"
:exit
pause
endlocal
exit /b 0