docker build -t ros_humble_venv .
docker run -it --name ros_humble --net=host\
  --privileged -e DISPLAY=$DISPLAY\
  --pid=host ros_humble_venv
