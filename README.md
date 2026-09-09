# Autonomous Mobile Robot (AMR) Navigation & Teleop

A comprehensive ROS 2 package for the simulation and physical control of a Differential Drive Autonomous Mobile Robot (AMR). This repository contains the complete software stack for hardware interfacing, teleoperation with kernel-level haptic feedback, and autonomous navigation using the Nav2 stack.

🎥 **Demo Video:** [Watch the robot in action here!](https://lnkd.in/p/gS8p74vt)

## 🚀 Key Features
* **Differential Drive Kinematics:** Custom `ros2_control` hardware interface utilizing Arduino/microcontrollers for precise wheel odometry and motor commands.
* **PID Control:** Implemented for precise motor velocity regulation and smooth maneuverability.
* **Kernel-Level Haptic Teleoperation:** Bypasses standard ROS 2 joy nodes to directly interface with Linux `evdev`, providing real-time force-feedback (rumble) to the gamepad based on velocity limits.
* **Autonomous Navigation (Nav2):** Integrated with the ROS 2 Navigation2 stack for AMCL-based localization, costmap generation, and path planning.
* **LiDAR Integration:** Configured for SLAM and obstacle avoidance using Slamtec RPLidar via the `sllidar_ros2` package.
* **Custom Environment Mapping:** Includes pre-configured `.yaml` and `.pgm` map files with automated loading scripts.

## 🧰 Hardware Components
* **NVIDIA Jetson Nano 4GB:** Main computer that runs all the complex algorithms.
* **Slamtec RP Lidar S3:** 2D Lidar for high-precision environment scanning and mapping.
* **Arduino Uno:** Used for converting commands and to serially send encoder and IMU data.
* **MPU6050 IMU:** Inertial measurement unit utilized to track angular velocities.
* **TT 12V 350 rpm N20 Encoder Motors:** High-torque motors providing the primary differential drive.
* **Motor Drivers:** 2x BTS7960 high-current H-bridge driver modules.
* **Power System:** 12V 2200 mAh LiPo 3S Battery regulated by a 12V to 5V Buck Converter for safe electronics distribution.
* **Chassis and Mounts:** Self-designed in SolidWorks.

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
```
### 2. Workspace Setup
Clone this repository into your ROS 2 workspace:
```bash
mkdir -p ~/ros2_ws/src
cd ~/ros2_ws/src
git clone [https://github.com/vedangtripathi45/Autonomous-Mobile-Robot.git](https://github.com/vedangtripathi45/Autonomous-Mobile-Robot.git) vgr_sim
cd ~/ros2_ws
colcon build --symlink-install
source install/setup.bash
```

## 🎮 Usage Guide

### 1. Launching the Core Robot (URDF & Controllers)
Starts the robot state publisher, loads the URDF, and spawns the `diff_cont` and `joint_broad` controllers.
```bash
ros2 launch vgr_sim bot.launch.py
```

### 2.Joystick Teleoperation
Starts the joystick node to publish command velocities.
```bash
ros2 launch vgr_sim joy.launch.py
```
Axis 1: Linear velocity
Axis 3: Angular velocity
Button 5: Enable deadman switch
Button 7: Turbo mode

### 3. AMCL Localization & Map Loading
To load a pre-saved map (e.g., arena_map) and initialize the AMCL particle filter for Nav2:
```bash
cd ~/ros2_ws/src/vgr_sim/scripts
./map_load.sh
```

