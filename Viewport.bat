@echo off
setlocal
set "comfy_path=%~dp0ComfyUI\"
set "venv_path=%~dp0venv\Scripts\"
set "activate_script=%venv_path%activate.bat"
set "deactivate_script=%venv_path%deactivate.bat"
set "venv_python=%venv_path%python.exe"
set "venv_pip=%venv_path%pip.exe"
:run_webui
echo Keep this window opened 
%venv_python% run_webui.py %*


endlocal
exit /1