docker build -t ros_jazzy_venv .
docker run -it --name ros_jazzy --net=host\
  --volume /dev/input:/dev/input\
  --privileged -e DISPLAY=$DISPLAY\
  --pid=host ros_jazzy_venv
