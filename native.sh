# WARNING: This method is not really recommended, refer to the docker method if possible.

export ROS_DISTRO=jazzy
# Dependencies installation
sudo apt update && apt install --no-install-recommends -y \
    ninja-build gettext cmake unzip curl build-essential xterm python3-venv \
    ros-$ROS_DISTRO-rmw-cyclonedds-cpp ros-$ROS_DISTRO-rviz2 iputils-ping \
    ros-$ROS_DISTRO-rtabmap-ros ros-$ROS_DISTRO-navigation2 ros-$ROS_DISTRO-nav2-bringup ros-$ROS_DISTRO-leo-description

# Preparing ROS2 directly at boot of the docker
echo "source /opt/ros/$ROS_DISTRO/setup.bash" >> ~/.bashrc

# Getting all the source code into the ROS workspace
mkdir -p ~/ros_ws/src
git clone https://github.com/snt-spacer/leo_simulator-ros2.git ~/ros_ws/src/
git clone https://github.com/snt-spacer/leo_common-ros2.git ~/ros_ws/src/
git clone https://github.com/snt-spacer/rtabmap_livox.git ~/ros_ws/src/

# Moving to ws dir to install dependencies
cd ~/ros_ws/
# remove the rosdep sources list if it exists already
sudo rm /etc/ros/rosdep/sources.list.d/20-default.list
sudo rosdep init
sudo rosdep update
sudo rosdep install --from-paths src/ -y --ignore-src

# Everything is complete, don't forget to build the workspace!
cd /home/$USER/ros_ws && colcon build
