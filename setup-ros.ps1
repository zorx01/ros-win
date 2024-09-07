# ROS Setup Script for Windows using Docker and XLaunch
# Made by github.com/zorx01


# Function to check if Docker is installed
function Check-DockerInstalled {
    if (!(Get-Command docker -ErrorAction SilentlyContinue)) {
        Write-Host "Docker is not installed."
        $install = Read-Host "Would you like to download and install Docker Desktop for Windows? (y/n)"
        if ($install -eq 'y') {
            Write-Host "Attempting to install Docker Desktop using winget..."
            try {
                winget install Docker.DockerDesktop
                Write-Host "Docker Desktop has been installed. Please restart your computer to complete the setup." -ForegroundColor Green
                Write-Host "After restarting, please run this script again." -ForegroundColor Green
                exit
            }
            catch {
                Write-Host "Failed to install Docker Desktop using winget. Please install it manually." -ForegroundColor Red
                Start-Process "https://www.docker.com/products/docker-desktop"
                Write-Host "Please install Docker Desktop and restart this script when finished." -ForegroundColor Yellow
            }
        } else {
            Write-Host "Docker is required to continue. Exiting."
        }
        exit
    }
}

# Function to check if XLaunch is installed
function Check-XLaunchInstalled {
    if (!(Test-Path "C:\Program Files\VcXsrv\xlaunch.exe")) {
        Write-Host "XLaunch is not installed."
        $install = Read-Host "Would you like to download and install VcXsrv Windows X Server? (y/n)"
        if ($install -eq 'y') {
            Write-Host "Attempting to install VcXsrv using winget..."
            try {
                winget install marha.VcXsrv
                Write-Host "VcXsrv has been installed successfully." -ForegroundColor Green
            }
            catch {
                Write-Host "Failed to install VcXsrv using winget. Please install it manually." -ForegroundColor Red
                Start-Process "https://sourceforge.net/projects/vcxsrv/"
                Write-Host "Please install VcXsrv and restart this script when finished." -ForegroundColor Yellow
                exit
            }
        } else {
            Write-Host "XLaunch is required to continue. Exiting."
            exit
        }
    }
}

# Function to display ASCII art banner
function Show-Banner {
    $banner = @"
 ____   ___  ____    _         __        ___           _                   
|  _ \ / _ \/ ___|  (_)_ __    \ \      / (_)_ __   __| | _____      _____ 
| |_) | | | \___ \  | | '_ \    \ \ /\ / /| | '_ \ / _` |/ _ \ \ /\ / / __|
|  _ <| |_| |___) | | | | | |    \ V  V / | | | | | (_| | (_) \ V  V /\__ \
|_| \_\\___/|____/  |_|_| |_|     \_/\_/  |_|_| |_|\__,_|\___/ \_/\_/ |___/
"@
    Write-Host $banner -ForegroundColor DarkMagenta
}

# Function to setup ROS
function Setup-ROS {
    param (
        [string]$Version
    )
    
    $ImageName = "osrf/ros:$Version-desktop-full"
    
    Write-Host "Pulling the Docker image for ROS $Version..."
    docker pull $ImageName
    
    Write-Host "Running the Docker container..."
    docker run -it --name ros_$Version -e DISPLAY=host.docker.internal:0.0 $ImageName /bin/bash -c "echo 'source /opt/ros/$Version/setup.bash' >> ~/.bashrc && bash"

}

# Main script
Clear-Host
Write-Host "Welcome to the ROS Setup Script for Windows!" -ForegroundColor DarkMagenta
Show-Banner
Write-Host

Write-Host "Made by " -NoNewline
Write-Host "github.com/zorx01" -ForegroundColor Green
Write-Host
Write-Host "This script will help you set up ROS using Docker and XLaunch."
Write-Host

Check-DockerInstalled
Check-XLaunchInstalled

$versions = @(
    [PSCustomObject]@{Name="ROS Noetic"; Version="noetic"}
    [PSCustomObject]@{Name="ROS Foxy"; Version="foxy"}
    [PSCustomObject]@{Name="ROS Humble"; Version="humble"}
)

Write-Host
Write-Host "Available ROS versions:" -ForegroundColor Green
for ($i=0; $i -lt $versions.Count; $i++) {
    Write-Host "$($i+1). $($versions[$i].Name)" -ForegroundColor Green
}

Write-Host

do {
    $choice = Read-Host "Enter the number of the ROS version you want to setup (or 'q' to quit)"
    if ($choice -eq 'q') {
        Write-Host "Exiting. Goodbye!"
        exit
    }
} while ($choice -lt 1 -or $choice -gt $versions.Count)

$selected = $versions[$choice - 1]
Write-Host "You selected: $($selected.Name)"
Write-Host

$confirm = Read-Host "Do you want to proceed with the setup? (y/n)"
if ($confirm -eq 'y') {
    Setup-ROS $selected.Version
} else {
    Write-Host "Setup cancelled. Goodbye!"
}

Write-Host "Note: To make the GUI work, please launch XLaunch application and set the display number to 0." -ForegroundColor Yellow
Write-Host "Make sure to run XLaunch everytime" -ForegroundColor Yellow