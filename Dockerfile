FROM ros:humble

# Environment variables
# ROS_DISTRO here equals to 'humble'

# Dependencies installation
RUN apt update && apt install --no-install-recommends -y \
    ninja-build \
    gettext \ 
    cmake \
    unzip \
    curl \
    build-essential \
    xterm \
    python3-venv \
    iputils-ping \
    vim \
    nano \
    ros-$ROS_DISTRO-rmw-cyclonedds-cpp \
    ros-$ROS_DISTRO-rviz2 \
    ros-$ROS_DISTRO-rtabmap-ros \
    ros-$ROS_DISTRO-navigation2 \
    ros-$ROS_DISTRO-nav2-bringup \
    ros-$ROS_DISTRO-leo-description

# Preparing ROS2 directly at boot of the docker 
RUN echo "source /opt/ros/$ROS_DISTRO/setup.bash" >> ~/.bashrc

# Getting all the source code into the ROS workspace
RUN mkdir -p /root/ros_ws/src
WORKDIR /root/ros_ws/src/
RUN git clone https://github.com/snt-spacer/leo_simulator-ros2.git
RUN git clone https://github.com/snt-spacer/leo_common-ros2.git
RUN git clone https://github.com/snt-spacer/rtabmap_livox.git

RUN echo "alias luna_source='source ~/ros_ws/install/setup.bash'
RUN alias luna_gazebo='ros2 launch leo_gz_bringup leo_gz.launch.py sim_world:=~/ros_ws/src/leo_simulator-ros2/leo_gz_worlds/worlds/lunalab2024.sdf'\
alias luna_rtabmap='ros2 launch rtabmap_livox rtabmap_livox.launch.py'\
alias joy_teleop='ros2 launch leo_teleop joy_teleop.launch.xml'\
alias key_teleop='ros2 launch leo_teleop key_teleop.launch.xml'" >> ~/.bash_aliases

RUN source ~/.bash_aliases

# Moving to ws dir to install dependencies
WORKDIR /root/ros_ws/
# remove the rosdep sources list if it exists already
RUN rm /etc/ros/rosdep/sources.list.d/20-default.list
RUN rosdep init
RUN rosdep update
RUN rosdep install --from-paths src -y --ignore-src

# Everything is complete, don't forget to build the workspace!
# This command is greyed because we need to source ROS2 at the same time as we run it,
# there is a solution but I don't wanna bother to be honest, just colcon build when it's done.
# RUN colcon build

# Proposed solution: (https://stackoverflow.com/questions/72727733/how-to-use-colcon-build-in-a-dockerfile)
RUN /bin/bash -c "source /opt/ros/$ROS_DISTRO/setup.bash; colcon build"
