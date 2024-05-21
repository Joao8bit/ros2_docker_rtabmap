# How to build, start, run and exec this docker

## Build
Firstly, we want to run build.sh
```
$ sh build_n_run.sh
```
## Start
The docker will finish building in the workspace, but we want to exit first.
```
$ exit
```
After that, we will start the docker, then open it (execute)
```
$ docker start ros_humble
$ docker exec -ti ros_humble bash
```
