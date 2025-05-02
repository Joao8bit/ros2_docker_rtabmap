sudo docker build -t ros_humble_venv .
sudo docker run -it --name ros_humble --net host\
  --volume /dev/input:/dev/input\
  -v $HOME/ros2_ws:/root/ros2_ws\
  --privileged -e DISPLAY=$DISPLAY\
  --pid=host ros_humble_venv
