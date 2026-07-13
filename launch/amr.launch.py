import os
from ament_index_python.packages import get_package_share_directory
from launch import LaunchDescription
from launch.actions import IncludeLaunchDescription, TimerAction
from launch.launch_description_sources import PythonLaunchDescriptionSource
from launch_ros.actions import Node
def generate_launch_description():
    vgr_sim_dir = get_package_share_directory('vgr_sim')
    slam_toolbox_dir = get_package_share_directory('slam_toolbox')

    # 1. Robot Base - Turant start hoga (0s)
    bot_launch = IncludeLaunchDescription(
        PythonLaunchDescriptionSource(os.path.join(vgr_sim_dir, 'launch', 'bot.launch.py'))
    )

    # 2. LiDAR - 5 seconds ke delay ke baad
    lidar_launch = TimerAction(
        period=8.0,
        actions=[IncludeLaunchDescription(
            PythonLaunchDescriptionSource(os.path.join(vgr_sim_dir, 'launch', 'lidar.launch.py'))
        )]
    )
    # Mux Switch config file ka path
    mux_params_file = os.path.join(
        get_package_share_directory('vgr_sim'),
        'config',
        'mux_switch.yaml'
    )

    # Twist Mux Node
    twist_mux_node = Node(
        package='twist_mux',
        executable='twist_mux',
        name='twist_mux',
        parameters=[mux_params_file],
        remappings=[('cmd_vel_out', 'diff_cont/cmd_vel_unstamped')] 
    )
    # 3. Joystick - 7 seconds ke delay ke baad (5s + 2s)
    joy_launch = TimerAction(
        period=10.0,
        actions=[IncludeLaunchDescription(
            PythonLaunchDescriptionSource(os.path.join(vgr_sim_dir, 'launch', 'joy.launch.py'))
        )]
    )

    # 4. SLAM Toolbox - 10 seconds ke delay ke baad (Saare sensors ready hone ke baad)
    slam_launch = TimerAction(
        period=13.0,
        actions=[IncludeLaunchDescription(
            PythonLaunchDescriptionSource(os.path.join(slam_toolbox_dir, 'launch', 'online_async_launch.py')),
            launch_arguments={
                'params_file': os.path.join(vgr_sim_dir, 'config', 'map_params.yaml'),
                'use_sim_time': 'false'
            }.items()
        )]
    )

    return LaunchDescription([
        bot_launch,
        lidar_launch,
        joy_launch,
        #slam_launch,
        twist_mux_node
    ])