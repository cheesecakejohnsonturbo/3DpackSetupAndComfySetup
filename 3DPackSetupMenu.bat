@echo off
SETLOCAL
::Predefined values
set "script_dir=%~dp0"
set "comfy_path=%script_dir%ComfyUI\"
set "venv_path=%comfy_path%venv\Scripts\"
set "activate_script=%venv_path%activate.bat"
set "deactivate_script=%venv_path%deactivate.bat"
set "venv_python=%venv_path%python.exe"
set "venv_pip=%venv_path%pip.exe"
set /p confirm="Proceed to Comfy-3D-Pack installation? (N=exit) (Y/N)"
if /i "%confirm%"=="Y" (goto :menu_index) else (goto :cancelled)
::Main features catalogue
:menu_index
::cls
echo Main Menu
echo 1. Clone comfy 3D Pack GIT
echo 2. NVDIFFRAST Setup
echo 3. PyTorch3D Setup
echo 4. Quit
choice /c 1234 /m "Choose an option: "
if errorlevel 4 goto :exit
if errorlevel 3 goto :menu_pytorch_3d
if errorlevel 2 goto :menu_nvdiffrast
if errorlevel 1 goto :go_clone_comfy_3d_pack
:menu_nvdiffrast
::cls
echo NvDiffRast Menu
echo 1. Clone
echo 2. Setup
echo 3. Return
choice /c 123 /m "Choose an option: "
if errorlevel 3 goto :menu_index
if errorlevel 2 goto :go_setup_nvdiffrast
if errorlevel 1 goto :go_clone_nvdiffrast
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
:go_clone_comfy_3d_pack
:: Action: Clone ComfyUI-3D-Pack and return to Main Menu
cd "%script_dir%ComfyUI\custom_nodes"
echo "Cloning and installing Comfy-3D-Pack"
git clone https://github.com/MrForExample/ComfyUI-3D-Pack
cd ComfyUI-3D-Pack
call %activate_script%
%venv_python% -m pip install -r requirements.txt
%venv_python% -m pip install kiui torch_scatter
goto :menu_index
:go_clone_nvdiffrast
:: Action: Clone NVDiffRast and return to NVDiffRast Menu
cd "%script_dir%ComfyUI\custom_nodes\ComfyUI-3D-Pack"
echo "cloning and installing NVDIFFRAST"
git clone https://github.com/NVlabs/nvdiffrast
goto :menu_nvdiffrast
:go_setup_nvdiffrast
:: Action: Setup NVDiffRast and return to NVDiffRast Menu
cd "%script_dir%ComfyUI\custom_nodes\ComfyUI-3D-Pack\nvdiffrast"
pip install .
goto :menu_nvdiffrast
:go_clone_pytorch_3d
:: Action: Clone PyTorch3D and return to PyTorch3D Menu
cd "%script_dir%ComfyUI\custom_nodes\ComfyUI-3D-Pack\nvdiffrast"
echo Cloning and Installing Pytorch3D
git clone https://github.com/facebookresearch/pytorch3d.git
goto :menu_pytorch_3d
:go_setup_pytorch_3d
:: Action: Setup PyTorch3D and return to PyTorch3D Menu
cd "%script_dir%ComfyUI\custom_nodes\ComfyUI-3D-Pack\nvdiffrast\pytorch3d"
%venv_pip% install --upgrade setuptools wheel
pip install -e .
goto :menu_pytorch_3d
:exit
call %deactivate_script%
ENDLOCAL
pause
exit /0
:cancelled
echo "Operation canceled."
endlocal
pause
exit /1