@echo off
SETLOCAL
call %activate_script%
::Predefined values
set "script_dir=%~dp0"
set "comfy_path=%script_dir%ComfyUI\"
set "venv_path=%script_dir%venv\Scripts\"
set "activate_script=%venv_path%activate.bat"
set "deactivate_script=%venv_path%deactivate.bat"
set "venv_python=%venv_path%python.exe"
set "venv_pip=%venv_path%pip.exe"
::prompt Y/N
set /p confirm="Proceed to Comfy-3D-Pack installation? (N=exit) (Y/N)"
if /i "%confirm%"=="Y" (goto :menu_index) else (goto :cancelled)
::Main features catalogue
:menu_index
::cls
echo Main Menu
echo 1. Clone comfy 3D Pack GIT
echo 2. NVDIFFRAST Setup
echo 3. PyTorch3D Setup
echo 4. Hunyuan3D-1-wrapper Setup
echo 5. Local Python
echo 6. Uninstall torch (if you have to reinstall it)
echo 7. Readme.md
echo 8. Quit
choice /c 12345678 /m "Choose an option: "
if errorlevel 8 goto :exit
if errorlevel 7 goto :readme
if errorlevel 6 goto :uninstall_torch
if errorlevel 5 call "%script_dir%local_python.bat"
if errorlevel 4 goto :menu_hunyuan3d
if errorlevel 3 goto :menu_pytorch_3d
if errorlevel 2 goto :menu_nvdiffrast
if errorlevel 1 goto :go_clone_comfy_3d_pack
goto :menu_index
:menu_hunyuan3d
::cls
echo Hunyuan3D-1-wrapper Menu
echo 1. Clone
echo 2. Setup
echo 3. Return
choice /c 123 /m "Choose an option: "
if errorlevel 3 goto :menu_index
if errorlevel 2 goto :go_setup_hunyuan3d
if errorlevel 1 goto :go_clone_hunyuan3d
goto :menu_hunyuan3d
:menu_nvdiffrast
::cls
echo NvDiffRast Menu
echo 1. Clone (Legacy step 1)
echo 2. Setup method A (Legacy step 2)
echo 3. Setup method B (Better and single step)
echo 4. Return
choice /c 1234 /m "Choose an option: "
if errorlevel 4 goto :menu_index
if errorlevel 3 goto :go_setup_nvdiffrast_b
if errorlevel 2 goto :go_setup_nvdiffrast_a
if errorlevel 1 goto :go_clone_nvdiffrast
goto :menu_nvdiffrast
:menu_pytorch_3d
::cls
echo Pytorch3D Menu
echo 1. Clone
echo 2. Setup
echo 3. Return
choice /c 123 /m "Choose an option: "
if errorlevel 3 goto :menu_index
if errorlevel 2 goto :go_setup_pytorch_3d
if errorlevel 1 goto :go_clone_pytorch_3d
goto :menu_pytorch_3d
:go_clone_comfy_3d_pack
:: Action: Clone ComfyUI-3D-Pack and return to Main Menu
cd "%script_dir%ComfyUI\custom_nodes"
echo "Cloning and installing Comfy-3D-Pack"
git clone https://github.com/MrForExample/ComfyUI-3D-Pack
cd ComfyUI-3D-Pack
%venv_python% -m pip install -r requirements.txt
%venv_python% -m pip install kiui torch_scatter
goto :menu_index
:go_clone_nvdiffrast
:: Action: Clone NVDiffRast and return to NVDiffRast Menu
cd "%script_dir%ComfyUI\custom_nodes\ComfyUI-3D-Pack"
echo "cloning and installing NVDIFFRAST"
git clone https://github.com/NVlabs/nvdiffrast
goto :menu_nvdiffrast
:go_setup_nvdiffrast_a
:: Action: Setup NVDiffRast and return to NVDiffRast Menu
cd "%script_dir%ComfyUI\custom_nodes\ComfyUI-3D-Pack\nvdiffrast"
%venv_python% -m pip install .
goto :menu_nvdiffrast
:go_setup_nvdiffrast_b
::https://www.reddit.com/r/comfyui/comments/1bf7tv1/i_created_crm_custom_nodes_for_comfyui/ :: Arogato gozaimasu buddy
%venv_python% -m pip install git+https://github.com/NVlabs/nvdiffrast/
goto :menu_nvdiffrast
:go_clone_pytorch_3d
:: Action: Clone PyTorch3D and return to PyTorch3D Menu
cd "%script_dir%ComfyUI\custom_nodes\ComfyUI-3D-Pack\nvdiffrast"
echo Cloning and Installing Pytorch3D
git clone https://github.com/facebookresearch/pytorch3d.git
goto :menu_pytorch_3d
:go_setup_pytorch_3d
:: Action: Setup PyTorch3D and return to PyTorch3D Menu
cd "%comfy_dir%\custom_nodes\comfyui-3d-pack\nvdiffrast\pytorch3d"
::prompt Y/N
set /p confirm="Upgrade setuptools wheel? (N=skip to next step) (Y/N)"
if /i "%confirm%"=="Y" (goto :upgrade_setuptools_y) else (goto :upgrade_setuptools_n)
:upgrade_setuptools_y
%venv_python% -m pip install --upgrade setuptools wheel
:upgrade_setuptools_n
%venv_python% -m pip install -e .
goto :menu_pytorch_3d
:go_clone_hunyuan3d
:: Action: Clone Hunyuan3D-1-wrapper and return to Hunyuan3D-1-wrapper Menu
cd "%script_dir%ComfyUI\custom_nodes"
echo "Cloning Hunyuan3D-1-wrapper"
git clone https://github.com/jtydhr88/ComfyUI-Hunyuan3D-1-wrapper
goto :menu_hunyuan3d
:go_setup_hunyuan3d
:: Action: Setup Hunyuan3D-1-wrapper and return to Hunyuan3D-1-wrapper Menu
cd "%script_dir%ComfyUI\custom_nodes\ComfyUI-Hunyuan3D-1-wrapper"
echo "Installing Hunyuan3D-1-wrapper requirements"
%venv_python% -m pip install -r requirements.txt
goto :menu_hunyuan3d
:uninstall_torch
%venv_python% -m pip uninstall torch
pause
goto :menu_index
:readme
type "readme.md"
echo.
echo "Press a key to return to the main menu"
pause >nul
cls
goto :menu_index
:exit
call %deactivate_script%
ENDLOCAL
pause
exit /0
:cancelled
echo "Operation canceled."
call %deactivate_script%
endlocal
pause
exit /1