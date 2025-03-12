@echo off
setlocal enabledelayedexpansion
set "comfy_path=%~dp0\ComfyUI\"
set "venv_path=%comfy_path%venv\Scripts\"
set "activate_script=%venv_path%activate.bat"
set "deactivate_script=%venv_path%deactivate.bat"
set "venv_python=%venv_path%python.exe"
set "venv_pip=%venv_path%pip.exe"
::call %activate_script%
%venv_python% %comfy_path%main.py --verbose %*
pause
::call %deactivate_script%
:exit
endlocal
exit /b 0