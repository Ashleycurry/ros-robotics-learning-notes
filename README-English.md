# ROS Robotics Development Learning Notes

[中文](README.md) | [English](README-English.md)

This repository organizes introductory ROS robotics development materials and runnable examples. The learning path starts with ROS concepts, environment setup, and common commands, then moves through `catkin` workspaces, packages, topic communication, service communication, the parameter server, Launch files, TF coordinate transforms, and common visualization tools.

Course materials are stored in `docs/`, while example source code is stored in `src/catkin_ws/src/`. The current source follows the ROS 1 `catkin` workspace model and mainly uses `rospy` Python nodes. It also includes custom messages, custom services, and TF examples.

## Learning Roadmap

```text
ROS Fundamentals
    ├── ROS positioning, components, and communication concepts
    ├── ROS installation and environment setup
    └── ROS terminology and common commands
            ↓
catkin Projects
    ├── Creating a workspace
    ├── Creating packages
    ├── Building and sourcing the workspace
    └── package.xml and CMakeLists.txt
            ↓
ROS Communication
    ├── Topic publishers and subscribers
    ├── Service clients and servers
    ├── Custom messages
    └── Custom services
            ↓
ROS Tools and Runtime Services
    ├── Parameter server
    ├── Launch files
    ├── TF coordinate transforms
    └── RViz and other visualization tools
```

## Course Materials

| No. | Material | Main topics |
| --- | --- | --- |
| 001 | [ROS System Introduction](docs/001_ROS系统介绍.pdf) | ROS positioning, components, hardware abstraction, node communication, and the robotics software ecosystem |
| 002 | [ROS Installation and Environment Setup](docs/002_ROS系统安装和环境搭建.pdf) | ROS installation, workspace configuration, and runtime preparation |
| 003 | [ROS Terminology and Command Reference](docs/003_ROS常用术语及命令说明.pdf) | Nodes, topics, services, parameters, messages, and common commands |
| 004 | [Creating Workspaces and Packages](docs/004_创建工作空间与功能包.pdf) | `catkin_ws`, packages, dependencies, and `catkin_make` |
| 005 | [Writing a Simple Publisher](docs/005_编辑简单的发布器.pdf) | Publishing ROS topics with `rospy.Publisher` |
| 006 | [Writing a Simple Subscriber](docs/006_编辑简单的订阅器.pdf) | Subscribing to topics and processing callbacks with `rospy.Subscriber` |
| 007 | [Defining and Using Custom Topic Messages](docs/007_话题消息的自定义与使用.pdf) | Custom `.msg` files and topic publishing/subscription |
| 008 | [Writing a Simple Client](docs/008_编写简单的客户端.pdf) | Creating a Service client and sending requests |
| 009 | [Writing a Simple Server](docs/009_编写简单的服务端.pdf) | Creating a Service server and handling request callbacks |
| 010 | [Defining and Using Custom Service Data](docs/010_服务数据的自定义与使用.pdf) | Custom `.srv` interfaces and generated service types |
| 011 | [Using and Programming Parameters](docs/011_参数的使用与编程方法.pdf) | Reading, setting, and using the ROS parameter server |
| 012 | [Using Launch Files](docs/012_Launch启动文件的使用方法.pdf) | Starting multiple nodes and parameters with Launch files |
| 013 | [Broadcasting and Listening to TF Frames](docs/013_TF坐标系广播与监听的编程实现.pdf) | TF broadcasting, listening, and follow-control logic |
| 014 | [Common Visualization Tools](docs/014_常用可视化工具的使用.pdf) | Inspecting nodes, topics, and coordinate relationships with ROS tools |

## Source Overview

The source workspace is located at [`src/catkin_ws/src`](src/catkin_ws/src) and currently contains three ROS packages:

| Package | Purpose | Main dependencies |
| --- | --- | --- |
| [`beginner_hiwonder`](src/catkin_ws/src/beginner_hiwonder) | Basic Topic, Service, Turtlesim, custom message, and custom service examples | `roscpp`, `rospy`, `std_msgs`, `message_generation` |
| [`parameter_hiwonder`](src/catkin_ws/src/parameter_hiwonder) | Parameter server read/write and service-call example | `rospy`, `std_msgs` |
| [`tf_hiwonder`](src/catkin_ws/src/tf_hiwonder) | TF broadcasting, listening, and follow-control example in Turtlesim | `rospy`, `tf`, `turtlesim` |

### beginner_hiwonder

#### Topic Publishing and Subscription

- [`velocity_publisher.py`](src/catkin_ws/src/beginner_hiwonder/scripts/velocity_publisher.py): publishes `geometry_msgs/Twist` on `/turtle1/cmd_vel` to control the turtle.
- [`pose_subscriber.py`](src/catkin_ws/src/beginner_hiwonder/scripts/pose_subscriber.py): subscribes to `/turtle1/pose` and logs the turtle pose.
- [`person_publisher.py`](src/catkin_ws/src/beginner_hiwonder/scripts/person_publisher.py): publishes the custom `Person` message on `/person_info`.
- [`person_subscriber.py`](src/catkin_ws/src/beginner_hiwonder/scripts/person_subscriber.py): subscribes to `/person_info` and logs the custom message fields.
- [`Person.msg`](src/catkin_ws/src/beginner_hiwonder/msg/Person.msg): defines name, age, and sex fields.

> Build note: `add_message_files` is currently commented out in `CMakeLists.txt`. Before a fresh full build, enable the message-generation configuration for `Person.msg`; otherwise the custom message nodes may not have generated interfaces available.

#### Service Communication

- [`turtle_spawn.py`](src/catkin_ws/src/beginner_hiwonder/scripts/turtle_spawn.py): calls the Turtlesim `/spawn` service to create another turtle.
- [`turtle_commmand_server.py`](src/catkin_ws/src/beginner_hiwonder/scripts/turtle_commmand_server.py): exposes `/turtle_command` and toggles turtle velocity publishing.
- [`person_server.py`](src/catkin_ws/src/beginner_hiwonder/scripts/person_server.py): provides `/show_person` and handles `Person` requests.
- [`person_client.py`](src/catkin_ws/src/beginner_hiwonder/scripts/person_client.py): calls `/show_person` and reads the response.
- [`Person.srv`](src/catkin_ws/src/beginner_hiwonder/srv/Person.srv): defines the name, age, and sex request fields plus a string response.

#### Launch Example

- [`turtlesim_launch_test.lanuch`](src/catkin_ws/src/beginner_hiwonder/lanuch/turtlesim_launch_test.lanuch): starts Turtlesim and the keyboard teleoperation node together.

> Note: `lanuch` and `.lanuch` are the actual directory and file names in this repository. The project can later standardize them to `launch` and `.launch`, but the links above intentionally follow the current paths.

### parameter_hiwonder

- [`parameter_config.py`](src/catkin_ws/src/parameter_hiwonder/scripts/parameter_config.py): reads and sets `/turtlesim/background_r`, `/turtlesim/background_g`, and `/turtlesim/background_b`, then calls `/clear`.

### tf_hiwonder

- [`turtle_tf_broadcaster.py`](src/catkin_ws/src/tf_hiwonder/scripts/turtle_tf_broadcaster.py): subscribes to turtle poses and broadcasts TF transforms from `world` to each turtle frame.
- [`turtle_tf_listener.py`](src/catkin_ws/src/tf_hiwonder/scripts/turtle_tf_listener.py): listens to the relationship between `turtle1` and `turtle2`, then computes velocity commands for `turtle2` to follow `turtle1`.
- [`start_tf_demo_py.launch`](src/catkin_ws/src/tf_hiwonder/launch/start_tf_demo_py.launch): starts Turtlesim, keyboard teleoperation, two TF broadcasters, and the TF listener.

## Requirements

The source follows a ROS 1 catkin workspace layout. Before running the examples, prepare:

- A Linux system.
- A correctly installed and configured ROS 1 distribution.
- `catkin`, `rospy`, `roscpp`, `std_msgs`, `turtlesim`, `tf`, and the required message packages.
- A working `catkin_make` command.

Some scripts retain the style of early ROS Python examples, including Python 2-style `print`, exception syntax, and the `thread` module. When using ROS Noetic or Python 3, the syntax, thread module, and dependency configuration may need to be ported first.

## Build the Workspace

Run the following commands from the repository root:

```bash
cd src/catkin_ws
catkin_make
source devel/setup.bash
```

The workspace environment must be sourced again in every new terminal:

```bash
source /opt/ros/<ros1-distro>/setup.bash
source ~/path/to/ros-robotics-learning-notes/src/catkin_ws/devel/setup.bash
```

Replace `<ros1-distro>` with the ROS 1 distribution installed on the machine.

## Running Examples

### Turtlesim Topic Example

Start the ROS Master and Turtlesim:

```bash
roscore
rosrun turtlesim turtlesim_node
```

In another terminal, source the workspace and run the publisher:

```bash
source src/catkin_ws/devel/setup.bash
rosrun beginner_hiwonder velocity_publisher.py
```

Run the pose subscriber:

```bash
rosrun beginner_hiwonder pose_subscriber.py
```

The Launch example can also be started using the repository's current file name:

```bash
roslaunch beginner_hiwonder turtlesim_launch_test.lanuch
```

### Custom Message Example

`beginner_hiwonder` generates a custom message interface from `Person.msg`:

```bash
rosrun beginner_hiwonder person_publisher.py
rosrun beginner_hiwonder person_subscriber.py
```

### Custom Service Example

Start the server first, then start the client:

```bash
rosrun beginner_hiwonder person_server.py
rosrun beginner_hiwonder person_client.py
```

The service name is `/show_person`, and its type is `beginner_hiwonder/Person`.

### Parameter Server Example

Start Turtlesim first, then run:

```bash
rosrun parameter_hiwonder parameter_config.py
```

### TF Example

Run the TF Launch file:

```bash
roslaunch tf_hiwonder start_tf_demo_py.launch
```

This example starts Turtlesim, keyboard teleoperation, TF broadcasters, and a TF listener to demonstrate coordinate transforms and turtle following.

## Common ROS Commands

| Command | Purpose |
| --- | --- |
| `roscore` | Starts the ROS Master, parameter server, and basic runtime |
| `rosnode list` | Lists running nodes |
| `rosnode info <node>` | Displays node details and connections |
| `rostopic list` | Lists available topics |
| `rostopic echo <topic>` | Prints topic messages |
| `rostopic info <topic>` | Displays topic type and connections |
| `rosservice list` | Lists available services |
| `rosservice call <service>` | Calls a service |
| `rosparam list` | Lists parameters |
| `rosparam get <name>` | Reads a parameter |
| `rosparam set <name> <value>` | Sets a parameter |
| `rosrun <package> <node>` | Runs a node from a package |
| `roslaunch <package> <file>` | Starts multiple nodes from a Launch file |
| `rqt_graph` | Visualizes node and topic connections |
| `rviz` | Visualizes TF, sensor data, and robot state |

## Repository Structure

```text
ros-robotics-learning-notes/
├── README.md
├── README-English.md
├── docs/
│   ├── 001_ROS系统介绍.pdf
│   ├── 002_ROS系统安装和环境搭建.pdf
│   ├── ...
│   └── 014_常用可视化工具的使用.pdf
└── src/
    └── catkin_ws/
        ├── src/
        │   ├── beginner_hiwonder/
        │   ├── parameter_hiwonder/
        │   └── tf_hiwonder/
        ├── build/
        ├── devel/
        └── param.yaml
```

`build/` and `devel/` are generated catkin build and development spaces. The source that should normally be maintained is under `src/catkin_ws/src/`.

## Suggested Study Process

1. Understand the five basic ROS concepts: nodes, topics, services, parameters, and messages.
2. Use `catkin_create_pkg`, `catkin_make`, and workspace setup commands to understand the full workspace lifecycle.
3. Run standard-message publishers and subscribers before reading the custom `Person.msg` definition.
4. Compare the continuous publishing model of Topics with the request-response model of Services.
5. Read `Person.srv`, the server, and the client to understand interface generation and service calls.
6. Change Turtlesim settings through the parameter server and observe the relationship between nodes and parameters.
7. Use Launch files to manage multiple nodes, then inspect frame relationships with TF and visualization tools.
8. For every example, record node names, topic names, service names, message types, startup order, and runtime dependencies.

## Notes and Safety

- ROS node, topic, service, and parameter names must match exactly; a naming mistake can prevent communication.
- After changing a custom message or service, run `catkin_make` again and source `devel/setup.bash` again.
- Before starting a client, confirm that the corresponding server is registered. Before starting a subscriber, confirm that a publisher or data source is running.
- When multiple nodes share resources, check node names, topic names, and namespaces to avoid collisions.
- TF examples depend on correct frame names and timestamps. When transforms are missing, inspect the TF tree and node logs first.
- The Python interpreter version, dependencies, and script permissions must match the selected ROS distribution.
- These commands are for learning and demonstration. A real robot requires additional checks for hardware drivers, interfaces, speed limits, and safe operating areas.

## Current Scope

This repository contains introductory ROS course materials and three groups of supporting Python examples, with an emphasis on ROS 1 communication and tools. It does not currently include complete robot drivers, navigation, mapping, manipulator control, Gazebo simulation projects, or ROS 2 `ament` workspaces.

## Keywords

`ROS` `ROS 1` `catkin` `rospy` `roscpp` `Topic` `Publisher` `Subscriber` `Service` `Parameter Server` `Custom Message` `Custom Service` `Launch` `TF` `Turtlesim` `RViz` `Python`
