#!/bin/bash
echo "🗺️ Starting Navigation Stack..."
source /opt/ros/foxy/setup.bash
source /ros2_ws/install/setup.bash
ros2 launch nav2_bringup navigation_launch.py use_sim_time:=false map_subscribe_transient_local:=true params_file:=/ros2_ws/src/vgr_sim/config/nav_params.yaml
