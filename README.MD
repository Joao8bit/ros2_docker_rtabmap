# How to build, start, run, exec this docker

## Build
Firstly, we want to run build.sh

$ sh build_n_run.sh

## Start
Secondly, we will start the container using the container name we gave it, ros_humble in this case.

$ docker start ros_humble

## Exec
Finally, to access the docker, we will exec it as follows:

$ docker exec -ti ros_humble
babla
