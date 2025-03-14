@echo off
setlocal
:variables_init
set "script_dir=%~dp0"
set "comfy_path=%~dp0ComfyUI\"
set "venv_path=%script_dir%venv\Scripts\"
set "activate_script=%venv_path%activate.bat"
set "deactivate_script=%venv_path%deactivate.bat"
set "venv_python=%venv_path%python.exe"
set "venv_pip=%venv_path%pip.exe"
::::::::::::::::::::::
::::::VENV::::::
::::::::::::::::::::::
if not exist "%venv_path%" (goto :do_make_venv) 
goto :skip_make_venv
::if not exist "%venv_path%" goto :do_make_venv else goto :skip_make_venv (same result, different spelling)
:do_make_venv
echo "Creating Venv..."
"%USERPROFILE%\AppData\Local\Programs\Python\Python312\python.exe" -m venv venv
Echo VENV installed successfully.
:skip_make_venv
::::::::::::::::::::::::
:::Start VENV:::
::::::::::::::::::::::::
:venv_start
call %activate_script%
:::::::::::::::::::::::::
:::Main_Menu:::
:::::::::::::::::::::::::
:main_setup_menu
::cls
echo =====================================================
echo ==Main Setup Menu ===================================
echo ==1. Setup ComfyUI - 0.2.7 "(for comfy3d)" ==========
echo ==2. Setup ComfyUI - Latest version =================
echo ==3. Proceed to Comfy setup and initialisation ======
echo ==4. Pytorch Select ===========================
echo ==5. Extra Setup Tools ==============================
echo ==6. View Readme.md =========================
echo ==7. Proceed to exit ================================
choice /c 12345 /m "Choose an option: "
if errorlevel 7 goto :exit
if errorlevel 6 goto :readme_md
if errorlevel 5 goto :menu_setup_extras
if errorlevel 4 goto :select_torch_method
if errorlevel 3 goto :initialize_comfy
if errorlevel 2 goto :setup_comfy_latest
if errorlevel 1 goto :setup_comfy_027
goto :main_setup_menu
::::::::::::::::::::::::::::::::::::::::::::::
::file viewer (readme.md)::::::
::::::::::::::::::::::::::::::::::::::::::::::
:readme_md
cd %script_dir%
type "readme.md"
echo.
echo "Press a key to return to the main menu"
pause >nul
cls
goto :main_setup_menu
::::::::::::::::::::::::::::::::::::::
::custom_nodes_setup::
::::::::::::::::::::::::::::::::::::::
::cls
:menu_setup_extras
echo "Setup Extras Nodes?"
echo 1. Basic packages
echo 2. 3D packages
echo 3. Upgrade PIP
echo 4. Skip (proceed to exit)
choice /c 1234 /m "Choose an option: "
if errorlevel 4 goto :exit
if errorlevel 3 goto :upgrade_pip
if errorlevel 2 goto :run_3d_setup
if errorlevel 1 goto :run_extras_setup
goto :menu_setup_extras
::::::::::::::::::::::::::::::::::
:::GitComfyUILatest:::
::::::::::::::::::::::::::::::::::
:setup_comfy_latest
if not exist "%comfy_path%" (goto :proceed_clone_comfy_latest) 
goto :skip_clone_comfy
:proceed_clone_comfy_latest
echo ==Cloning ComfyUI==
git clone https://github.com/comfyanonymous/ComfyUI ComfyUI
echo ==Task completed==
goto :main_setup_menu
:::::::::::::::::::::::::::::::
:::::GitComfy027:::::
:::::::::::::::::::::::::::::::
:setup_comfy_027
if not exist "%comfy_path%" (goto :proceed_clone_comfy_027) 
goto :skip_clone_comfy
:proceed_clone_comfy_027
echo ==Cloning ComfyUI==
git clone --branch v0.2.7 https://github.com/comfyanonymous/ComfyUI ComfyUI
echo ==Task completed==
goto :main_setup_menu
:::::::::::::::::::::::::::::::::
:::::GitComfyError:::::
:::::::::::::::::::::::::::::::::
:skip_clone_comfy
echo Warning - Folder already exist. Skipping. Press a key to return to main menu.
pause >nul
goto :main_setup_menu
::::::::::::::::::::::::
::::Initializing::::
::::::::::::::::::::::::
:initialize_comfy
%venv_python% -m pip install -r "%comfy_path%requirements.txt"
echo Requirements file has been processed"
goto :select_torch_method
::::::::::::::::::::::::::::::::::::::
:::::::::Torch Setup::::::::::
::::::::::::::::::::::::::::::::::::::
:select_torch_method
::cls (cls to clear view, disabled with ::)
echo Select which setup method to proceed with
echo 1. "install torch torchvision torchaudio --extra-index-url https://download.pytorch.org/whl/cu124"
echo 2. "requirements_comfy3d.txt instead"
choice /c 12 /m "Choose an option: "
if errorlevel 2 goto :torch_method_b
if errorlevel 1 goto :torch_method_a
goto :select_torch_method
cd %comfy_path%
:torch_method_a
%venv_pip% install torch torchvision torchaudio --extra-index-url https://download.pytorch.org/whl/cu124
goto :main_setup_menu
:torch_method_b
%venv_pip% install -r %~dp0requirements_comfy3d.txt --extra-index-url https://download.pytorch.org/whl/cu124
goto :main_setup_menu
:::::::::::::::::::::::::::::::::::::
::::Requirements.txt::::::
:::::::::::::::::::::::::::::::::::::
:setup_requirements
%venv_pip% install -r requirements.txt
goto :main_setup_menu
::::::::::::::::::::::::::::::::::::::
::custom_nodes_setup::
::::::::::::::::::::::::::::::::::::::
:run_extras_setup
call "%~dp0install_extras.bat"
::pause
goto :main_setup_menu
:run_3d_setup
call "%~dp03DPackSetupMenu.bat"
::pause
goto :main_setup_menu
:::::::::::::::::::::::::::::::
:::::::::::¨PIP:::::::::::::
:::::::::::::::::::::::::::::::
:upgrade_pip
%venv_python% -m pip install --upgrade pip
goto :menu_setup_extras
::::::::::::::::::::::::::::::
:::::Exit in Style::::::
::::::::::::::::::::::::::::::
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