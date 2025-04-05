docker build -t ros_humble_venv .
docker run -it --name ros_humble --net=host\
  --volume /dev/input:/dev/input\
  --privileged -e DISPLAY=$DISPLAY\
  --pid=host ros_humble_venv
