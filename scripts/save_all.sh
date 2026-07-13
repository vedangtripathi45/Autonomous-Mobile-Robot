#!/bin/bash

# 1. Symlink Fix (Forcefully creating the link if it doesn't exist)
# Nav2 expects libGraphicsMagick++.so.12, but Jetson has the -Q16 version.
if [ ! -f /usr/lib/libGraphicsMagick++.so.12 ]; then
    echo "Fixing GraphicsMagick symlink..."
    ln -s /usr/lib/libGraphicsMagick++-Q16.so.12 /usr/lib/libGraphicsMagick++.so.12
fi

# 2. Environment Fixes
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/lib/aarch64-linux-gnu
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/lib
ldconfig

echo "--- Starting Map Save Sequence for Botrush 4.0 ---"

# 3. Save PGM Map (Image format for Nav2)
echo "Saving PGM Map..."
ros2 service call /slam_toolbox/save_map slam_toolbox/srv/SaveMap "{name: {data: '/ros2_ws/home_map_final'}}"

# 4. Save Serialized Pose Graph (Backup for SLAM)
echo "Saving Serialized Map..."
ros2 service call /slam_toolbox/serialize_map slam_toolbox/srv/SerializePoseGraph "{filename: '/ros2_ws/home_map_serial'}"

# 5. Fix Permissions (Taaki Jetson host se access ho sake)
chmod 777 /ros2_ws/home_map_final*
chmod 777 /ros2_ws/home_map_serial*

echo "--- DONE! All files saved in /ros2_ws ---"
