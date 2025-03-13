# ComfyUI 3D Pack Setup Script - Readme

## Project Summary

This project involves creating a Windows Batch script (`3DPackSetupMenu.bat`) to simplify the installation and setup of ComfyUI and several popular 3D-related ComfyUI extensions.

The script provides a menu-driven interface to perform the following actions:

1.  **Clone ComfyUI-3D-Pack:** Clones the ComfyUI-3D-Pack GitHub repository into the `ComfyUI/custom_nodes` directory and installs its Python requirements.
2.  **NVDiffRast Setup:** Offers two methods to install and setup the NVDiffRast extension, a crucial component for 3D rendering within ComfyUI.
    *   **Method A (Legacy):**  Clones the NVDiffRast repository and performs a traditional `pip install .` setup.
    *   **Method B (Better, Single-Step):** Installs NVDiffRast directly from the GitHub repository using `pip install git+https://...`.
3.  **PyTorch3D Setup:** Provides two methods for installing and setting up PyTorch3D, a core library for 3D deep learning that some ComfyUI extensions rely on.
    *   **Method A (Legacy):** Clones the PyTorch3D repository and attempts a local editable install (`pip install -e .`). Includes an option to upgrade `setuptools` and `wheel` which can be necessary for successful installation.
    *   **Method B (GitHub Install):** Installs PyTorch3D directly from the GitHub repository using `pip install git+https://...`.
4.  **Hunyuan3D-1-wrapper Setup:** Installs the `ComfyUI-Hunyuan3D-1-wrapper` extension, which wraps the Tencent Hunyuan 3D AIGC model for 3D generation within ComfyUI. This includes cloning the repository and installing its Python requirements from `requirements.txt`.
5.  **Local Python:**  Executes a `local_python.bat` script (details of this script are not specified in this readme).
6.  **Quit:** Exits the setup script.
7.  **Readme.md:** Displays this readme file within the command prompt.

## Script Design and Features

*   **Batch Script (`.bat`):**  The project is implemented as a Windows Batch script, making it easy to run on Windows systems without requiring additional software.
*   **Menu-Driven Interface:** The script uses the `choice` command and `errorlevel` to create a text-based menu system, guiding users through the setup process step-by-step.
*   **Global Virtual Environment Activation:** The script activates a Python virtual environment (`venv`) at the beginning for all Python-related operations and deactivates it upon exiting. This ensures a clean and isolated Python environment for the ComfyUI setup.
*   **Modular Structure with Checkpoints:** The script is organized using `:checkpoints` and `goto :checkpoint` commands, promoting code manageability, stackability, and easier updates.
*   **Error Handling (Basic):**  The menu structure includes basic error handling by looping back to the menu if an invalid option is selected.
*   **Comments:**  The script is commented using `::comments` for clarity and maintainability.
*   **GitHub Repository Integration:**  The script directly clones and installs extensions and libraries from their respective GitHub repositories, simplifying the process of obtaining the necessary software.
*   **Dependency Management:** The script uses `pip install -r requirements.txt` to install Python package dependencies for extensions, ensuring all necessary libraries are installed.

## Usage

1.  **Download/Create:** Obtain the `3DPackSetupMenu.bat` script.
2.  **Run:** Execute the `3DPackSetupMenu.bat` file by double-clicking it or running it from the command prompt.
3.  **Follow Menus:**  Use the menu options to select and perform the desired setup steps.
4.  **Verify:** After running the script, verify that ComfyUI and the selected extensions are installed correctly and functioning as expected.

## Notes

*   This script is designed for Windows operating systems.
*   It assumes that `git` and `python` are installed and accessible in the system's PATH environment variable.
*   The script uses a Python virtual environment (`venv`) to isolate dependencies.
*   Users should have an active internet connection during the execution of the script as it downloads files from GitHub and PyPI (Python Package Index).

---
This `readme.md` provides a plain text summary of the `3DPackSetupMenu.bat` project. For more detailed information, please refer to the script itself and the online documentation for ComfyUI and the specific extensions.