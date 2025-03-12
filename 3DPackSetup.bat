@echo off
SETLOCAL
::Predefined values
set "comfy_path=%~dp0\ComfyUI\"
set "venv_path=%comfy_path%venv\Scripts\"
set "activate_script=%venv_path%activate.bat"
set "deactivate_script=%venv_path%deactivate.bat"
set "venv_python=%venv_path%python.exe"
set "venv_pip=%venv_path%pip.exe"
set /p confirm="Proceed to full Comfy-3D-Pack installation sequence? (N=exit) (Y/N)"
if /i "%confirm%"=="Y" (goto :clone_3d_pack) else (goto :cancelled)
:clone_3d_pack
::go to path
cd ComfyUI
cd custom_nodes
::First Step
echo "Cloning and installing Comfy-3D-Pack"
git clone https://github.com/MrForExample/ComfyUI-3D-Pack
cd ComfyUI-3D-Pack
call %activate_script%
%venv_pip% install -r requirements.txt
%venv_pip% install kiui torch_scatter
::Second Step
:clone_nvdiffrast
echo "cloning and installing NVDIFFRAST"
git clone https://github.com/NVlabs/nvdiffrast
cd nvdiffrast && %venv_pip% install . 
::Last Step
:clone_pytorch_3d
echo Cloning and Installing Pytorch3D
git clone https://github.com/facebookresearch/pytorch3d.git 
%venv_pip% install --upgrade setuptools wheel
cd pytorch3d && %venv_pip% install -e . 
pause
::Normal Exit
:exit
call %deactivate_script%
ENDLOCAL
pause
exit /d 0
::Cancellation message
:cancelled
echo "Operation canceled." 
goto :exit