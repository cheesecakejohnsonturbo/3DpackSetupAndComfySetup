@echo off
setlocal
set "script_dir=%~dp0"
set "comfy_path=%~dp0\ComfyUI\"
set "venv_path=%script_dir%venv\Scripts\"
set "activate_script=%venv_path%activate.bat"
set "deactivate_script=%venv_path%deactivate.bat"
set "venv_python=%venv_path%python.exe"
set "venv_pip=%venv_path%pip.exe"
call %activate_script%
%venv_python% %comfy_path%main.py%*
::%venv_python% %comfy_path%main.py --verbose %*
pause
call %deactivate_script%
:exit
endlocal
exit /b 0