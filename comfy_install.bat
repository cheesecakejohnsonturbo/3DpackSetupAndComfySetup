@echo off
setlocal
set "script_dir=%~dp0"
::goto :skip_main_setup
:clone_git
echo "Cloning ComfyUI..."
git clone https://github.com/comfyanonymous/ComfyUI
echo "ComfyUI Cloned Successfully."
:make_venv
echo "Creating Venv..."
"%USERPROFILE%\AppData\Local\Programs\Python\Python312\python.exe" -m venv venv
echo "Venv Installed successfully."
:variables_init
set "comfy_path=%~dp0\ComfyUI\"
set "venv_path=%script_dir%venv\Scripts\"
set "activate_script=%venv_path%activate.bat"
set "deactivate_script=%venv_path%deactivate.bat"
set "venv_python=%venv_path%python.exe"
set "venv_pip=%venv_path%pip.exe"
:venv_start
call %activate_script%
:upgrade_pip
%venv_python% -m pip install --upgrade pip
:select_torch_method
cd comfyui
::cls
echo Select which setup method to proceed with
echo 1. "install torch torchvision torchaudio --extra-index-url https://download.pytorch.org/whl/cu124"
echo 2. "requirements_comfy3d.txt instead"
choice /c 12 /m "Choose an option: "
if errorlevel 2 goto :torch_method_b
if errorlevel 1 goto :torch_method_a
:torch_method_a
%venv_pip% install torch torchvision torchaudio --extra-index-url https://download.pytorch.org/whl/cu124
goto :after_torch
:torch_method_b
%venv_pip% install -r %~dp0requirements_comfy3d.txt
:after_torch
::continuation of :torch_method_a&b
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