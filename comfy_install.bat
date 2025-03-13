@echo off
setlocal
:variables_init
set "script_dir=%~dp0"
set "comfy_path=%~dp0ComfyUI"
set "venv_path=%script_dir%venv\Scripts\"
set "activate_script=%venv_path%activate.bat"
set "deactivate_script=%venv_path%deactivate.bat"
set "venv_python=%venv_path%python.exe"
set "venv_pip=%venv_path%pip.exe"
::goto :skip_main_setup
if not exist "%venv_path%" (goto :do_make_venv)
goto :skip_make_venv
:do_make_venv
echo "Creating Venv..."
"%USERPROFILE%\AppData\Local\Programs\Python\Python312\python.exe" -m venv venv
:skip_make_venv
echo "Venv Installed successfully."
:venv_start
call %activate_script%
:clone_git
if not exist "%comfy_path%" (goto :clone_comfy)
goto :skip_clone_comfy
:clone_comfy
echo "Cloning ComfyUI..."
git clone https://github.com/comfyanonymous/ComfyUI
%venv_python% -m pip install -r "%comfy_path%requirements.txt"
echo "ComfyUI Cloned Successfully."
:skip_clone_comfy
:upgrade_pip
%venv_python% -m pip install --upgrade pip
:select_torch_method
cd %comfy_path%
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
%venv_pip% install -r %~dp0requirements_comfy3d.txt --extra-index-url https://download.pytorch.org/whl/cu124
:after_torch
::continuation of :torch_method_a&b
:setup_requirements
%venv_pip% install -r requirements.txt
::custom_nodes_setup
::cls
echo "Setup Extras Nodes?"
echo "1. Basic packages"
echo "2. 3D packages"
echo "3. Skip (proceed to exit)"
choice /c 123 /m "Choose an option: "
if errorlevel 3 goto :exit
if errorlevel 2 goto :run_3d_setup
if errorlevel 1 goto :run_extras_setup
goto :setup_requirements
:run_extras_setup
call "%~dp0install_extras.bat"
pause
goto :setup_requirements
:run_3d_setup
call "%~dp03DPackSetupMenu.bat"
pause
goto :setup_requirements
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