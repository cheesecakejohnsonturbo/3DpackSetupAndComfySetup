# ComfyUI Setup Scripts - Script Glossary and Descriptions
Caution, I still struggle finalizing the final pytorch3D step but everthing everything else works as intended except that I'm totally not done making torch_conf.bat
## Glossary of Scripts

* **`3DPackSetupMenu.bat`:**
* **`code_consolidate.bat`:**
* **`comfy_install.bat`:**
* **`install_extras.bat`:**
* **`local_python.bat`:**
* **`Run.bat`:**
* **`torch_conf.bat`:**
* **`Viewport.bat`:**

## Descriptions of Script-Related Terms

* **`3DPackSetupMenu.bat`:** A script dedicated to setting up components related to 3D functionalities within ComfyUI. It provides a menu to clone and set up various 3D-related tools.
    * **Comfy 3D Pack:** A collection of custom nodes and tools for ComfyUI focused on 3D workflows.
    * **NVDIFFRAST:** An NVIDIA library for differentiable rasterization, used in some 3D rendering tasks. This script allows cloning and setting up NVDIFFRAST.
    * **PyTorch3D:** A library from Facebook Research that provides data structures and utilities for 3D deep learning. This script includes options to clone and set up PyTorch3D.
    * **Hunyuan3D-1-wrapper:** A custom node for ComfyUI that provides an interface to the Hunyuan3D-1 model. The script offers options to clone and set up this wrapper.
    * **Local Python:** Refers to an option within the `3DPackSetupMenu.bat` that calls the `local_python.bat` script, allowing direct interaction with the virtual environment's Python interpreter.
    * **Uninstall torch:** An option to uninstall PyTorch from the virtual environment, useful if a reinstallation is needed.

* **`code_consolidate.bat`:** A utility script designed to gather the content of all `.bat` files in the same directory and combine them into a single text file for easier review.
    * **Code Consolidation:** The main function of this script, which is to join the code from multiple `.bat` files.
    * **Archive:** The script includes functionality to create an archive of previously generated summary files before creating a new one.
    * **Export with date and filename:** An option to create a consolidated text file where each `.bat` file's content is preceded by its filename and the current date.
    * **Consolidate code only:** An option to create a consolidated text file that contains just the code from all `.bat` files, without any headers or date information.

* **`comfy_install.bat`:** This is your main installation script, providing a menu to set up ComfyUI, manage the virtual environment, and install dependencies. It offers options to install specific versions or the latest version of ComfyUI. (This script was detailed in the previous glossary as `main_setup_menu.bat`.)

* **`install_extras.bat`:** A script focused on installing additional, commonly used custom nodes or tools for ComfyUI.
    * **Comfy Manager:** A popular custom node for ComfyUI that helps manage other custom nodes, updates, and installations. This script provides an option to install Comfy Manager.
    * **FFMPEG:** A powerful tool for working with multimedia files. This script includes steps to install the ComfyUI-FFmpeg custom node.
    * **XFORMERS:** A library that provides optimized building blocks for transformers, often used in machine learning models. This script includes an option to install `xformers`.

* **`local_python.bat`:** A script that activates the virtual environment and provides the user with a command prompt where they can directly execute Python commands within the environment.
    * **Local Python Command Prompt:** The interactive Python interpreter or a command line interface where you can run Python commands using the virtual environment's Python executable.

* **`Run.bat`:** A simple script that activates the virtual environment and then runs the main ComfyUI application (`main.py`).
    * **Run WebUI:** The primary task of this script is to start the ComfyUI web interface.

* **`torch_conf.bat`:** `Work In Progress`A dedicated script for configuring PyTorch within the ComfyUI virtual environment. It offers various options for installing different versions of PyTorch (CUDA-enabled or CPU-only) and managing related requirements.
    * **Torch Configuration:** The overall purpose of this script, which is to manage the PyTorch installation.
    * **CUDA-enabled PyTorch:** A version of PyTorch that is built to utilize NVIDIA GPUs for accelerated computation through the CUDA platform.
    * **CPU-only PyTorch:** A version of PyTorch that runs computations only on the computer's central processing unit (CPU), without GPU acceleration.
    * **ComfyUI Requirements (`requirements_comfy3d.txt`):** Refers to the option to install dependencies listed in a specific requirements file, likely intended for 3D-related features in ComfyUI.
    * **Script Requirements (`%%~dp0requirements.txt`):** Refers to the option to install dependencies listed in a `requirements.txt` file located in the same directory as the `torch_conf.bat` script itself.
    * **Install Specific Package Version:** An option to install a particular version of a Python package using `pip`.
    * **Install Package from git+URL:** An option to install a Python package directly from a Git repository URL using `pip`.
    * **Install ComfyUI Specific Release Version:** An option within the Torch Configuration menu that seems intended to install a specific release of ComfyUI itself (this might need further clarification on its exact implementation).

* **`Viewport.bat`:** This script appears to be another way to run the ComfyUI web interface, similar to `Run.bat`. It also activates the virtual environment before running `main.py`.