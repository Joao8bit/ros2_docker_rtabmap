FROM osrf/ros:humble-desktop-full

RUN apt update && apt install --no-install-recommends -y \
    ninja-build gettext cmake unzip curl build-essential curl python3-venv \
    ros-$ROS_DISTRO-rmw-cyclonedds-cpp ros-$ROS_DISTRO-rviz2 iputils-ping \
    ros-$ROS_DISTRO-rtabmap-ros ros-$ROS_DISTRO-navigation2 ros-$ROS_DISTRO-nav2-bringup

RUN echo "source /opt/ros/$ROS_DISTRO/setup.bash" >> ~/.bashrc
