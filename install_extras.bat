@echo off
setlocal
:variables_init
set "script_dir=%~dp0"
set "comfy_path=%~dp0\ComfyUI\"
set "venv_path=%script_dir%venv\Scripts\"
set "custom_nodes=%comfy_path%custom_nodes\"
set "activate_script=%venv_path%activate.bat"
set "deactivate_script=%venv_path%deactivate.bat"
set "venv_python=%venv_path%python.exe"
set "venv_pip=%venv_path%pip.exe"
::verify paths::
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
::Start Venv::
:skip_make_venv
echo "Venv Installed successfully."
:venv_start
call %activate_script%
::::::::::::::::::::::
::Main Menu::
::::::::::::::::::::::
:menu_extras
::cls (clear viewport text, disabled)
echo Setup Extra Nodes
echo 1. Comfy Manager
echo 2. FFMPEG
echo 3. XFORMERS
echo 4. Exit/Return
choice /c 1234 /m "Choose an option: "
if errorlevel 4 goto :exit
if errorlevel 3 goto :setup_xformers
if errorlevel 2 goto :setup_ffmpeg
if errorlevel 1 goto :setup_comfy_manager
goto :menu_hunyuan3d
:select_torch_method
::proceed with ffmpeg installation routine
:setup_ffmpeg
cd %custom_nodes%
echo "Installing FFMPEG"
git clone https://github.com/MoonHugo/ComfyUI-FFmpeg.git
cd ComfyUI-FFmpeg
%venv_pip% install -r requirements.txt
cd %script_dir%
goto :menu_extras
::proceed with comfy manager setup
:setup_comfy_manager
cd %custom_nodes%
echo "Installing Comfy Manager"
git clone https://github.com/ltdrdata/ComfyUI-Manager.git
cd %script_dir%
goto :menu_extras
::proceed with xformers setup
:setup_xformers
echo "Installing xformers"
%venv_pip% install -U xformers --index-url https://download.pytorch.org/whl/cu124
echo "Done."
goto :menu_extras
:venv_exit
call %deactivate_script%
:exit
pause
endlocal
exit 0
::exit /b 0 (alternatively)
:wrong_exit
pause
endlocal
exit /b 1
