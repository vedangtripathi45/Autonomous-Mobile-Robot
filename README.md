# Autonomous Mobile Robot (AMR) Navigation & Teleop

A comprehensive ROS 2 package for the simulation and physical control of a Differential Drive Autonomous Mobile Robot (AMR). This repository contains the complete software stack for hardware interfacing, teleoperation with kernel-level haptic feedback, and autonomous navigation using the Nav2 stack.

🎥 **Demo Video:** [Watch the robot in action here!](https://lnkd.in/p/gS8p74vt)

## 🚀 Key Features
* **Differential Drive Kinematics:** Custom `ros2_control` hardware interface utilizing Arduino/microcontrollers for precise wheel odometry and motor commands.
* **Kernel-Level Haptic Teleoperation:** Bypasses standard ROS 2 joy nodes to directly interface with Linux `evdev`, providing real-time force-feedback (rumble) to the gamepad based on velocity limits.
* **Autonomous Navigation (Nav2):** Integrated with the ROS 2 Navigation2 stack for AMCL-based localization, costmap generation, and path planning.
* **LiDAR Integration:** Configured for SLAM and obstacle avoidance using Slamtec RPLidar via the `sllidar_ros2` package.
* **Custom Environment Mapping:** Includes pre-configured `.yaml` and `.pgm` map files with automated loading scripts.

## 🛠️ System Architecture & Tech Stack
| Component | Technology / Package |
| :--- | :--- |
| **Framework** | ROS 2 (Foxy) |
| **Languages** | Python 3, C++14 |
| **Simulation & Modeling** | URDF, RViz2, CAD (SolidWorks/Fusion360 exported chassis) |
| **Control System** | `ros2_control`, `diff_drive_controller`, `joint_state_broadcaster` |
| **Teleoperation** | `joy`, `teleop_twist_joy`, `evdev` (Linux Kernel Haptics) |
| **Navigation & Mapping** | `nav2_bringup`, `nav2_amcl`, `map_server` |

## ⚙️ Prerequisites & Installation

### 1. Dependencies
Ensure you have ROS 2 installed along with the required control and navigation packages:
```bash
sudo apt update
sudo apt install ros-<distro>-ros2-control ros-<distro>-ros2-controllers ros-<distro>-navigation2 ros-<distro>-nav2-bringup
sudo apt install libgraphicsmagick++-q16-12 python3-evdev joystick
