#!/bin/bash
echo "📍 Starting AMCL Localization..."
source /opt/ros/foxy/setup.bash
source /ros2_ws/install/setup.bash
ros2 launch nav2_bringup localization_launch.py map:=/ros2_ws/src/vgr_sim/Maps/home_map_final.yaml use_sim_time:=false
