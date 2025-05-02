mkdir -p $HOME/ros2_ws/src
git clone -b humble https://github.com/snt-spacer/leo_simulator-ros2.git $HOME/ros2_ws/src/leo_simulator-ros2
git clone -b humble https://github.com/snt-spacer/leo_common-ros2.git $HOME/ros2_ws/src/leo_common-ros2
git clone https://github.com/snt-spacer/rtabmap_livox.git ~/ros_ws/src/

sudo docker build -t ros_humble_venv .
sudo docker run -it --name ros_humble --net host\
  --volume /dev/input:/dev/input\
  -v $HOME/ros2_ws:/root/ros2_ws\
  --privileged -e DISPLAY=$DISPLAY\
  --pid=host ros_humble_venv
