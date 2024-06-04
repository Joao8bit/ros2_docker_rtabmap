# How to build, start, run and exec this docker

## 1. Build
Firstly, we want to run build_n_run.sh (docker), or native.sh for Ubuntu-based distributions, and exit when it's done.
```
$ sh build_n_run.sh && exit
```
## 2. Start
2.1 To initialize the docker (after a boot,reboot, etc), we must give it initially display permissions.
```
$ xhost +
```
2.2 After that, we will start the docker container, then open it (execute):
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
## Control the LeoRover with teleop (keyboard or joystick options available, chose one)
```
$ ros2 launch leo_teleop key_teleop.launch.xml
$ ros2 launch leo_teleop joy_teleop.launch.xml
```

# Useful aliases for this project
```
alias source='source ~/ros_ws/install/setup.bash'
alias gazebo='ros2 launch leo_gz_bringup leo_gz.launch.py sim_world:=~/ros_ws/src/leo_simulator-ros2/leo_gz_worlds/worlds/lunalab2024.sdf'
alias rtabmap='ros2 launch rtabmap_livox rtabmap_livox.launch.py'
alias joy_teleop='ros2 launch leo_teleop joy_teleop.launch.xml'
```
# Q&A
## 1. If I exit the docker or open another terminal, how do I start it again?
- Run the 'docker exec -ti ros_humble bash' command again.
## 2. My docker has stopped, how do I start it again?
- Run the commands from section 2 of this README.
## 3. I cannot launch any GUI applications!
- Exit the docker, and try running the 'xhost +' command again, it should fix things.
## 4. How can I stop it from working in the background?
- Exit the docker and stop it using:
```
$ docker stop ros_humble
```

Any other related questions please let me know privately or in the common communications chat!
