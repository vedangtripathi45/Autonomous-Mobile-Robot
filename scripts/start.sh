#!/bin/bash
echo "🤖 Starting Botrush AMR Base..."
source /opt/ros/foxy/setup.bash
source /ros2_ws/install/setup.bash
ros2 launch vgr_sim amr.launch.py
