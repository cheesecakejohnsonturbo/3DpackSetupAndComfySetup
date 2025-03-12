@echo off
setlocal
::goto :skip_main_setup
:clone_git
echo "Cloning ComfyUI..."
git clone https://github.com/comfyanonymous/ComfyUI
echo "ComfyUI Cloned Successfully."
cd comfyui
:make_venv
echo "Creating Venv..."
"%USERPROFILE%\AppData\Local\Programs\Python\Python312\python.exe" -m venv venv
echo "Venv Installed successfully."
:variables_init
set "comfy_path=%~dp0\ComfyUI\"
set "venv_path=%comfy_path%venv\Scripts\"
set "activate_script=%venv_path%activate.bat"
set "deactivate_script=%venv_path%deactivate.bat"
set "venv_python=%venv_path%python.exe"
set "venv_pip=%venv_path%pip.exe"
:venv_start
call %activate_script%
:upgrade_pip
%venv_python% -m pip install --upgrade pip
:setup_torch
%venv_pip% install torch torchvision torchaudio --extra-index-url https://download.pytorch.org/whl/cu124
:setup_requirements
%venv_pip% install -r requirements.txt
::custom_nodes_setup
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
::::::::::::::::::::
::Functions::
::::::::::::::::::::
:skip_main_setup
goto :variables_init