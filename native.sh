#!/bin/bash

export ROS_DISTRO=jazzy

# Dependencies installation
sudo apt update && apt install --no-install-recommends -y \
    ninja-build gettext cmake unzip curl build-essential xterm python3-venv \
    ros-$ROS_DISTRO-rmw-cyclonedds-cpp ros-$ROS_DISTRO-rviz2 iputils-ping \
    ros-$ROS_DISTRO-rtabmap-ros ros-$ROS_DISTRO-navigation2 ros-$ROS_DISTRO-nav2-bringup ros-$ROS_DISTRO-leo-description ros-$ROS_DISTRO-ros-gz

# Preparing ROS2 directly at boot of the docker
echo "source /opt/ros/$ROS_DISTRO/setup.bash" >> ~/.bashrc

# Getting all the source code into the ROS workspace
# Define the target directory
TARGET_DIR="$HOME/ros_ws"

# Check if the directory exists
if [ -d "$TARGET_DIR" ]; then
    echo "Directory $TARGET_DIR already exists."
    exit 1
else
    echo "Creating directory $TARGET_DIR..."
    mkdir -p "$TARGET_DIR"
    echo "Directory created."
fi
git clone -b jazzy https://github.com/snt-spacer/leo_simulator-ros2.git ~/ros_ws/src/leo_simulator-ros2
git clone https://github.com/snt-spacer/leo_common-ros2.git ~/ros_ws/src/leo_common-ros2
git clone https://github.com/snt-spacer/rtabmap_livox.git ~/ros_ws/src/rtabmap_livox

echo "export GZ_SIM_RESOURCE_PATH=$HOME/ros_ws/src/leo_simulator-ros2/leo_gz_worlds/models/" >> ~/.bashrc

# Moving to ws dir to install dependencies
cd ~/ros_ws/
# remove the rosdep sources list if it exists already
sudo rm /etc/ros/rosdep/sources.list.d/20-default.list
sudo rosdep init
sudo rosdep update
sudo rosdep install --from-paths src/ -y --ignore-src --rosdistro jazzy

# Everything is complete, don't forget to build the workspace!
colcon build --symlink-install
