# PowerShell script to invoke .bat scripts

# Function to display the menu
function Show-Menu {
    Clear-Host
    Write-Host "------------------------------------" -ForegroundColor DarkGray
    Write-Host "  " -NoNewline
    Write-Host "*******" -ForegroundColor Cyan -NoNewline
    Write-Host " Main Menu " -ForegroundColor White -BackgroundColor Black -NoNewline
    Write-Host "*******" -ForegroundColor Cyan
    Write-Host "------------------------------------" -ForegroundColor DarkGray

    Write-Host "Primary" -ForegroundColor Red -BackgroundColor Black
    Write-Host "1. comfy_install.bat" -ForegroundColor Green -BackgroundColor Black
    Write-Host "2. 3DPackSetupMenu.bat" -ForegroundColor Green -BackgroundColor Black

    Write-Host ""

    Write-Host "Secondary" -ForegroundColor Red -BackgroundColor Black
    Write-Host "3. install_extras.bat" -ForegroundColor Green -BackgroundColor Black
    Write-Host "4. local_python.bat" -ForegroundColor Green -BackgroundColor Black

    Write-Host ""

    Write-Host "Debug" -ForegroundColor Red -BackgroundColor Black
    Write-Host "5. torch_conf.bat" -ForegroundColor Green -BackgroundColor Black

    Write-Host ""

    Write-Host "Post-Installation" -ForegroundColor Red -BackgroundColor Black
    Write-Host "6. Run.bat" -ForegroundColor Green -BackgroundColor Black
    Write-Host "7. Viewport.bat" -ForegroundColor Green -BackgroundColor Black

    Write-Host ""

    Write-Host "8. Exit" -ForegroundColor Green -BackgroundColor Black

    Write-Host "------------------------------------" -ForegroundColor DarkGray
}

# Main loop
while ($true) {
    Show-Menu

    $choice = Read-Host "Enter your choice (1-8)"

    switch ($choice) {
        "1" {
            Write-Host "Running comfy_install.bat..." -ForegroundColor Green -BackgroundColor Black
            Start-Process -FilePath "comfy_install.bat" -Wait -WorkingDirectory "."
        }
        "2" {
            Write-Host "Running 3DPackSetupMenu.bat..." -ForegroundColor Green -BackgroundColor Black
            Start-Process -FilePath "3DPackSetupMenu.bat" -Wait -WorkingDirectory "."
        }
        "3" {
            Write-Host "Running install_extras.bat..." -ForegroundColor Green -BackgroundColor Black
            Start-Process -FilePath "install_extras.bat" -Wait -WorkingDirectory "."
        }
        "4" {
            Write-Host "Running local_python.bat..." -ForegroundColor Green -BackgroundColor Black
            Start-Process -FilePath "local_python.bat" -Wait -WorkingDirectory "."
        }
        "5" {
            Write-Host "Running torch_conf.bat..." -ForegroundColor Green -BackgroundColor Black
            Start-Process -FilePath "torch_conf.bat" -Wait -WorkingDirectory "."
        }
        "6" {
            Write-Host "Running Run.bat..." -ForegroundColor Green -BackgroundColor Black
            Start-Process -FilePath "Run.bat" -Wait -WorkingDirectory "."
        }
        "7" {
            Write-Host "Running Viewport.bat..." -ForegroundColor Green -BackgroundColor Black
            Start-Process -FilePath "Viewport.bat" -Wait -WorkingDirectory "."
        }
        "8" {
            Write-Host "Exiting..." -ForegroundColor Yellow -BackgroundColor Black
            break
        }
        default {
            Write-Host "Invalid choice. Please try again." -ForegroundColor Red -BackgroundColor Black
            Start-Sleep -Seconds 2
        }
    }
}