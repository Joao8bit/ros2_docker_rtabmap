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
# Commands to run the simulation
## RVIZ
```
$ rviz2
```
## LunaLab simulation
```
$ ros2 launch leo_gz_bringup leo_gz.launch.py sim_world:=~/ros_ws/src/leo_simulator-ros2/leo_gz_worlds/worlds/lunalab2024.sdf 
```
## RTABMAP 
```
$ ros2 launch rtabmap_livox rtabmap_livox.launch.py
```
## Control the LeoRover with teleop (keyboard or joystick options available!)
```
$ ros2 launch leo_teleop key_teleop.launch.xml
$ ros2 launch leo_teleop joy_teleop.launch.xml
```
