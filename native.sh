
# Dependencies installation
 apt update && apt install --no-install-recommends -y \
    ninja-build gettext cmake unzip curl build-essential xterm python3-venv \
    ros-$ROS_DISTRO-rmw-cyclonedds-cpp ros-$ROS_DISTRO-rviz2 iputils-ping \
    ros-$ROS_DISTRO-rtabmap-ros ros-$ROS_DISTRO-navigation2 ros-$ROS_DISTRO-nav2-bringup ros-$ROS_DISTRO-leo-description

# Preparing ROS2 directly at boot of the docker
 echo "source /opt/ros/$ROS_DISTRO/setup.bash" >> ~/.bashrc

# Getting all the source code into the ROS workspace
 mkdir -p /root/ros_ws/src
 cd /root/ros_ws/src/
 git clone https://github.com/snt-spacer/leo_simulator-ros2.git
 git clone https://github.com/snt-spacer/leo_common-ros2.git
 git clone https://github.com/snt-spacer/rtabmap_livox.git

# Moving to ws dir to install dependencies
cd /root/ros_ws/
# remove the rosdep sources list if it exists already
 rm /etc/ros/rosdep/sources.list.d/20-default.list
 rosdep init
 rosdep update
 rosdep install --from-paths src -y --ignore-src

# Everything is complete, don't forget to build the workspace!
# This command is greyed because we need to source ROS2 at the same time as we run it,
# there is a solution but I don't wanna bother to be honest, just colcon build when it's done.
# RUN colcon build

# Proposed solution: (https://stackoverflow.com/questions/72727733/how-to-use-colcon-build-in-a-dockerfile)
# RUN /bin/bash -c "source /opt/ros/$ROS_DISTRO/setup.bash; colcon build"
