@echo off
setlocal

:: ---------------------------------------
:: Configuration Section
:: ---------------------------------------
set "script_dir=%~dp0"
set "venv_path=%script_dir%venv\Scripts\"
set "activate_script=%venv_path%activate.bat"
set "deactivate_script=%venv_path%deactivate.bat"
set "venv_python=%venv_path%python.exe"
set "venv_pip=%venv_path%pip.exe"

:: Ensure virtual environment is activated
if not exist "%activate_script%" (
    echo Error: Virtual environment not found or not set up correctly.
    pause
    exit /b 1
)
call "%activate_script%"

:: ---------------------------------------
:: Main Menu Checkpoint
:: ---------------------------------------
:menu_torch_conf
cls
echo Torch Configuration Menu
echo ====================================
echo 1. Install CUDA-enabled PyTorch (Recommended - Latest Version)
echo 2. Install CUDA-enabled PyTorch (Specific CUDA Version)
echo 3. Install CPU-only PyTorch
echo 4. Uninstall PyTorch (torch, torchvision, torchaudio)
echo 5. Check PyTorch Installation (CUDA availability, version)
echo 6. Install ComfyUI Requirements (requirements_comfy3d.txt)
echo 7. Install Script Requirements (%%~dp0requirements.txt)
echo 8. Run Local Python Command Prompt (local_python.bat)
echo 9. Install Specific Package Version
echo 10. Install Package from git+URL
echo 11. Install ComfyUI Specific Release Version (e.g., v0.2.7)
echo 12. Return to Main Menu
echo ====================================
choice /c 123456789ABC /m "Choose an option: [1-C]? "
if errorlevel 12 goto :exit_torch_conf_menu         :: Option C (12) - Return to Main Menu
if errorlevel 11 goto :install_comfyui_release_version :: Option B (11) - Install ComfyUI Specific Release Version
if errorlevel 10 goto :install_package_git_url       :: Option A (10) - Install Package from git+URL
if errorlevel 9 goto :install_specific_package_version:: Option 9  - Install Specific Package Version
if errorlevel 8 goto :run_local_python_bat          :: Option 8  - Run local_python.bat
if errorlevel 7 goto :install_script_requirements     :: Option 7  - Install Script Requirements
if errorlevel 6 goto :install_comfyui_requirements    :: Option 6  - Install ComfyUI Requirements
if errorlevel 5 goto :check_torch_install             :: Option 5  - Check PyTorch Installation
if errorlevel 4 goto :uninstall_torch_improved        :: Option 4  - Uninstall PyTorch
if errorlevel 3 goto :install_cpu_torch               :: Option 3  - Install CPU-only PyTorch
if errorlevel 2 goto :install_cuda_torch_specific_cuda:: Option 2  - Install CUDA PyTorch (Specific CUDA)
if errorlevel 1 goto :install_cuda_torch_latest      :: Option 1  - Install CUDA PyTorch (Latest)
goto :menu_torch_conf

:: ---------------------------------------
:: :install_cuda_torch_latest Checkpoint (Improved CUDA Install - Latest)
:: ---------------------------------------
:install_cuda_torch_latest
:: Action: Install CUDA-enabled PyTorch (latest recommended version)
echo Starting CUDA-enabled PyTorch installation (latest version)...
:: [ ... CUDA PyTorch Installation Commands Here - LATEST ... ]
echo CUDA-enabled PyTorch installation process initiated (latest version). (Placeholder)
pause
goto :menu_torch_conf

:: ---------------------------------------
:: :install_cuda_torch_specific_cuda Checkpoint (CUDA Install - Specific CUDA)
:: ---------------------------------------
:install_cuda_torch_specific_cuda
:: Action: Install CUDA-enabled PyTorch (specific CUDA version)
echo Starting CUDA-enabled PyTorch installation (specific CUDA version)...
:: [ ... CUDA PyTorch Installation Commands Here - SPECIFIC CUDA ... ]
echo CUDA-enabled PyTorch installation process initiated (specific CUDA version). (Placeholder)
pause
goto :menu_torch_conf

:: ---------------------------------------
:: :install_cpu_torch Checkpoint (CPU-only Install)
:: ---------------------------------------
:install_cpu_torch
:: Action: Install CPU-only PyTorch
echo Starting CPU-only PyTorch installation...
:: [ ... CPU-only PyTorch Installation Commands Here - CPU ... ]
echo CPU-only PyTorch installation process initiated (CPU-only). (Placeholder)
pause
goto :menu_torch_conf

:: ---------------------------------------
:: :uninstall_torch_improved Checkpoint (Improved Uninstall)
:: ---------------------------------------
:uninstall_torch_improved
:: Action: Uninstall PyTorch, torchvision, torchaudio (Improved Routine)
echo Starting PyTorch, torchvision, and torchaudio uninstallation...
:: [ ... Improved Uninstall Commands Here ... ]
echo PyTorch, torchvision, and torchaudio uninstallation process initiated. (Placeholder)
pause
goto :menu_torch_conf

:: ---------------------------------------
:: :check_torch_install Checkpoint (Check Installation)
:: ---------------------------------------
:check_torch_install
:: Action: Check PyTorch Installation (CUDA, version)
echo Checking PyTorch installation...
:: [ ... PyTorch Installation Check Commands Here ... ]
echo PyTorch installation check process initiated. (Placeholder)
pause
goto :menu_torch_conf

:: ---------------------------------------
:: :install_comfyui_requirements Checkpoint (ComfyUI Requirements)
:: ---------------------------------------
:install_comfyui_requirements
:: Action: Install ComfyUI requirements (requirements_comfy3d.txt)
echo Installing ComfyUI requirements from requirements_comfy3d.txt...
:: [ ... Install ComfyUI requirements commands here ... ]
echo ComfyUI requirements installation process initiated. (Placeholder)
pause
goto :menu_torch_conf

:: ---------------------------------------
:: :install_script_requirements Checkpoint (Script Requirements)
:: ---------------------------------------
:install_script_requirements
:: Action: Install script requirements (%%~dp0requirements.txt)
echo Installing script requirements from %%~dp0requirements.txt...
:: [ ... Install script requirements commands here ... ]
echo Script requirements installation process initiated. (Placeholder)
pause
goto :menu_torch_conf

:: ---------------------------------------
:: :run_local_python_bat Checkpoint (Run local_python.bat)
:: ---------------------------------------
:run_local_python_bat
:: Action: Run local_python.bat script
echo Running local_python.bat...
:: [ ... Run local_python.bat commands here ... ]
echo local_python.bat execution initiated. (Placeholder)
pause
goto :menu_torch_conf

:: ---------------------------------------
:: :install_specific_package_version Checkpoint (Specific Package Version)
:: ---------------------------------------
:install_specific_package_version
:: Action: Install specific package version
echo Starting specific package version installation...
:: [ ... Install specific package version commands here ... ]
echo Specific package version installation process initiated. (Placeholder)
pause
goto :menu_torch_conf

:: ---------------------------------------
:: :install_package_git_url Checkpoint (Package from git+URL)
:: ---------------------------------------
:install_package_git_url
:: Action: Install package from git+URL
echo Starting package installation from git+URL...
:: [ ... Install package from git+URL commands here ... ]
echo Package installation from git+URL process initiated. (Placeholder)
pause
goto :menu_torch_conf

:: ---------------------------------------
:: :install_comfyui_release_version Checkpoint (ComfyUI Release Version)
:: ---------------------------------------
:install_comfyui_release_version
:: Action: Install ComfyUI specific release version
echo Starting ComfyUI specific release version installation...
:: [ ... Install ComfyUI release version commands here ... ]
echo ComfyUI release version installation process initiated. (Placeholder)
pause
goto :menu_torch_conf

:: ---------------------------------------
:: :exit_torch_conf_menu Checkpoint (Exit Menu)
:: ---------------------------------------
:exit_torch_conf_menu
echo Returning to Main Menu...
goto :py_deactivate

:: ---------------------------------------
:: Deactivation and Exit Routines (Standard)
:: ---------------------------------------
:py_deactivate
call "%deactivate_script%"
exit /b 0

:wrong_exit
call "%deactivate_script%"
exit /b 1

endlocal
pause
exit /b 0