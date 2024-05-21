FROM osrf/ros:humble-desktop-full

# Environment variables
ENV ROS_DISTRO=humble 

RUN apt update && apt install --no-install-recommends -y \
    ninja-build gettext cmake unzip curl build-essential python3-venv \
    ros-$ROS_DISTRO-rmw-cyclonedds-cpp ros-$ROS_DISTRO-rviz2 iputils-ping \
    ros-$ROS_DISTRO-rtabmap-ros ros-$ROS_DISTRO-navigation2 ros-$ROS_DISTRO-nav2-bringup

RUN echo "source /opt/ros/$ROS_DISTRO/setup.bash" >> ~/.bashrc

# Getting all the source code into the ROS workspace
RUN mkdir -p /root/ros_ws/src
WORKDIR /root/ros_ws/src/
RUN git clone https://github.com/snt-spacer/leo_simulator-ros2.git
RUN git clone https://github.com/snt-spacer/leo_common-ros2.git
RUN git clone https://github.com/snt-spacer/rtabmap_livox.git

# Moving to ws dir to install dependencies
WORKDIR /root/ros_ws/
# remove the rosdep sources list if it exists already
RUN rm /etc/ros/rosdep/sources.list.d/20-default.list
RUN rosdep init
RUN rosdep update
RUN rosdep install --from-paths src -y --ignore-src

# Everything is complete, just build the workspace now
RUN colcon build
