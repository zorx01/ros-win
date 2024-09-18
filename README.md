# ROS Setup Script for Windows

This script automates the setup process for ROS (Robot Operating System) on Windows, enabling GUI support through Docker and XLaunch.

## Features

- Automates ROS installation on Windows using Docker
- Enables GUI support for ROS applications via XLaunch
- Checks for Docker and XLaunch installations
- Offers to install Docker and XLaunch if not present
- Allows selection of ROS version (Noetic, Foxy, or Humble)
- Configures ROS environment in a Docker container with GUI capabilities

Here's the updated **Prerequisites** section based on your instructions:

---

## Prerequisites

- Windows 10 or later
- PowerShell 5.1 or later
- **WSL2 (Windows Subsystem for Linux)**:
   - Install WSL2 using the following command:
     
     ```powershell
     wsl --install --no-distribution
     ```
   - After installation, restart your system to apply the changes.
- **Docker Desktop for Windows**:
   - Download and install Docker from the [official website](https://www.docker.com/products/docker-desktop) after WSL2 is set up.
- **XServer for Windows**:
   - Install [XLaunch](https://sourceforge.net/projects/vcxsrv/) to enable GUI support.

---

This makes the steps clearer for setting up WSL2, Docker, and XServer before running the ROS setup script.

## Quick Start

<!-- 1. Download the script:

   ```powershell
   Invoke-WebRequest -Uri "https://raw.githubusercontent.com/zorx01/ros-windows-setup/main/setup-ros.ps1" -OutFile "setup-ros.ps1"
   ``` -->

1. Download and Run the script:

   ```powershell
    iex "& { $(iwr -useb 'https://raw.githubusercontent.com/zorx01/ros-win/main/setup-ros.ps1') }"
   ```

## Usage

After running the setup script, you can use the following commands to manage your ROS Docker container:

1. Start the ROS container (replace `humble` with your chosen version):

   ```powershell
   docker start ros_humble
   ```

2. Enter the ROS container:

   ```powershell
   docker exec -it ros_humble bash
   ```

3. Stop the ROS container:

   ```powershell
   docker stop ros_humble
   ```
   
## 🚨 **Important Notes**

- **Make sure to launch XLaunch and set the display number to 0 before starting your ROS Docker container.**
- **Run XLaunch every time before using the ROS GUI applications.**


## Troubleshooting

If you encounter any issues, please check the following:

- Ensure Docker Desktop is running
- Verify that XLaunch is properly configured
- Check your network connection

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is open source and available under the [MIT License](LICENSE).

## Credits

Created by [github.com/zorx01](https://github.com/zorx01)
