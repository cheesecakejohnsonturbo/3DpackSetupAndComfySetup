@echo off
setlocal
:variables_init
set "script_dir=%~dp0"
set "comfy_path=%~dp0\ComfyUI\"
set "venv_path=%script_dir%venv\Scripts\"
set "activate_script=%venv_path%activate.bat"
set "deactivate_script=%venv_path%deactivate.bat"
set "venv_python=%venv_path%python.exe"
set "venv_pip=%venv_path%pip.exe"
::goto :skip_main_setup
:clone_git
if not exist "%comfy_path%" (goto :clone_comfy)
goto :skip_clone_comfy
:clone_comfy
echo "Exitting"
pause
goto :wrong_exit
:skip_clone_comfy
echo "ComfyUI Cloned Successfully."
if not exist "%venv_path%" (goto :do_make_venv)
goto :skip_make_venv
:do_make_venv
echo "exitting"
goto :wrong_exit 
:skip_make_venv
echo "Venv Installed successfully."
:venv_start
call %activate_script%
:select_torch_method
cd %comfy_path%
:setup_ffmpeg
cd custom_nodes
echo "Installing FFMPEG"
git clone https://github.com/MoonHugo/ComfyUI-FFmpeg.git
cd ComfyUI-FFmpeg
%venv_pip% install -r requirements.txt
cd ..
:setup_manager
echo "Installing Comfy Manager"
git clone https://github.com/ltdrdata/ComfyUI-Manager.git
:venv_exit
call %deactivate_script%
:exit
pause
endlocal
exit /b 0
:wrong_exit
pause
endlocal
exit /b 1
