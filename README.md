# ROS 机器人开发学习笔记

[中文](README.md) | [English](README-English.md)

本仓库用于整理 ROS 机器人开发入门阶段的课件和可运行示例，内容从 ROS 基础概念、环境搭建和常用命令开始，逐步覆盖 `catkin` 工作空间、功能包、话题通信、服务通信、参数服务器、Launch 启动文件、TF 坐标变换和常用可视化工具。

仓库中的课程资料位于 `docs/`，示例源码位于 `src/catkin_ws/src/`。当前源码以 ROS 1 的 `catkin` 工作空间和 `rospy` Python 节点为主，并包含自定义消息、自定义服务以及 TF 示例。

## 学习路线

```text
ROS 基础
    ├── ROS 的定位、组成和通信思想
    ├── ROS 环境安装与工作空间配置
    └── ROS 常用术语与命令
            ↓
catkin 工程
    ├── 创建工作空间
    ├── 创建功能包
    ├── 编译与环境加载
    └── package.xml 与 CMakeLists.txt
            ↓
ROS 通信
    ├── Topic 发布与订阅
    ├── Service 客户端与服务端
    ├── 自定义消息
    └── 自定义服务
            ↓
系统能力
    ├── 参数服务器
    ├── Launch 启动文件
    ├── TF 坐标变换
    └── RViz 等可视化工具
```

## 课件目录

| 编号 | 课件 | 主要内容 |
| --- | --- | --- |
| 001 | [ROS 系统介绍](docs/001_ROS系统介绍.pdf) | ROS 的定位、组成、硬件抽象、节点间通信和机器人软件生态 |
| 002 | [ROS 系统安装和环境搭建](docs/002_ROS系统安装和环境搭建.pdf) | ROS 环境安装、工作环境配置和基础运行准备 |
| 003 | [ROS 常用术语及命令说明](docs/003_ROS常用术语及命令说明.pdf) | 节点、话题、服务、参数、消息以及常用命令 |
| 004 | [创建工作空间与功能包](docs/004_创建工作空间与功能包.pdf) | `catkin_ws`、功能包、依赖声明和 `catkin_make` |
| 005 | [编辑简单的发布器](docs/005_编辑简单的发布器.pdf) | 使用 `rospy.Publisher` 发布 ROS 话题 |
| 006 | [编辑简单的订阅器](docs/006_编辑简单的订阅器.pdf) | 使用 `rospy.Subscriber` 订阅话题并处理回调 |
| 007 | [话题消息的自定义与使用](docs/007_话题消息的自定义与使用.pdf) | 自定义 `.msg` 消息以及发布和订阅 |
| 008 | [编写简单的客户端](docs/008_编写简单的客户端.pdf) | 创建 Service 客户端并发起服务请求 |
| 009 | [编写简单的服务端](docs/009_编写简单的服务端.pdf) | 创建 Service 服务端并处理请求回调 |
| 010 | [服务数据的自定义与使用](docs/010_服务数据的自定义与使用.pdf) | 自定义 `.srv` 服务数据并生成接口 |
| 011 | [参数的使用与编程方法](docs/011_参数的使用与编程方法.pdf) | 读取、设置和使用 ROS 参数服务器 |
| 012 | [Launch 启动文件的使用方法](docs/012_Launch启动文件的使用方法.pdf) | 使用 Launch 文件组织多个节点和参数 |
| 013 | [TF 坐标系广播与监听的编程实现](docs/013_TF坐标系广播与监听的编程实现.pdf) | TF 坐标变换广播、监听和跟随控制 |
| 014 | [常用可视化工具的使用](docs/014_常用可视化工具的使用.pdf) | 使用 ROS 可视化工具观察节点、话题和坐标关系 |

## 源码概览

源码位于 [`src/catkin_ws/src`](src/catkin_ws/src)，当前包含三个 ROS 功能包：

| 功能包 | 作用 | 主要依赖 |
| --- | --- | --- |
| [`beginner_hiwonder`](src/catkin_ws/src/beginner_hiwonder) | 基础 Topic、Service、Turtlesim、自定义消息和自定义服务示例 | `roscpp`、`rospy`、`std_msgs`、`message_generation` |
| [`parameter_hiwonder`](src/catkin_ws/src/parameter_hiwonder) | 参数服务器的读取、设置和服务调用示例 | `rospy`、`std_msgs` |
| [`tf_hiwonder`](src/catkin_ws/src/tf_hiwonder) | Turtlesim 场景中的 TF 广播、监听和跟随示例 | `rospy`、`tf`、`turtlesim` |

### beginner_hiwonder

#### 话题发布与订阅

- [`velocity_publisher.py`](src/catkin_ws/src/beginner_hiwonder/scripts/velocity_publisher.py)：向 `/turtle1/cmd_vel` 发布 `geometry_msgs/Twist`，控制海龟运动。
- [`pose_subscriber.py`](src/catkin_ws/src/beginner_hiwonder/scripts/pose_subscriber.py)：订阅 `/turtle1/pose`，输出海龟位姿。
- [`person_publisher.py`](src/catkin_ws/src/beginner_hiwonder/scripts/person_publisher.py)：向 `/person_info` 发布自定义 `Person` 消息。
- [`person_subscriber.py`](src/catkin_ws/src/beginner_hiwonder/scripts/person_subscriber.py)：订阅 `/person_info` 并输出自定义消息内容。
- [`Person.msg`](src/catkin_ws/src/beginner_hiwonder/msg/Person.msg)：定义姓名、年龄和性别字段。

> 构建说明：当前 `CMakeLists.txt` 中的 `add_message_files` 配置处于注释状态，首次全量构建前需要启用 `Person.msg` 的消息生成配置，否则自定义消息节点可能无法生成对应接口。

#### 服务通信

- [`turtle_spawn.py`](src/catkin_ws/src/beginner_hiwonder/scripts/turtle_spawn.py)：调用 Turtlesim 的 `/spawn` 服务创建新的海龟。
- [`turtle_commmand_server.py`](src/catkin_ws/src/beginner_hiwonder/scripts/turtle_commmand_server.py)：提供 `/turtle_command` 服务，切换海龟速度指令的发布状态。
- [`person_server.py`](src/catkin_ws/src/beginner_hiwonder/scripts/person_server.py)：提供 `/show_person` 服务并处理 `Person` 请求。
- [`person_client.py`](src/catkin_ws/src/beginner_hiwonder/scripts/person_client.py)：调用 `/show_person` 服务并读取响应。
- [`Person.srv`](src/catkin_ws/src/beginner_hiwonder/srv/Person.srv)：定义姓名、年龄、性别请求字段和字符串响应。

#### Launch 示例

- [`turtlesim_launch_test.lanuch`](src/catkin_ws/src/beginner_hiwonder/lanuch/turtlesim_launch_test.lanuch)：同时启动 Turtlesim 和键盘控制节点。

> 说明：上述 `lanuch` 目录和 `.lanuch` 扩展名是当前仓库中的实际名称。后续整理工程时可以统一为 `launch` 和 `.launch`，但 README 按现有文件路径提供链接。

### parameter_hiwonder

- [`parameter_config.py`](src/catkin_ws/src/parameter_hiwonder/scripts/parameter_config.py)：读取和设置 `/turtlesim/background_r`、`/turtlesim/background_g`、`/turtlesim/background_b`，并调用 `/clear` 服务清除背景。

### tf_hiwonder

- [`turtle_tf_broadcaster.py`](src/catkin_ws/src/tf_hiwonder/scripts/turtle_tf_broadcaster.py)：订阅海龟位姿并广播从 `world` 到海龟坐标系的 TF 变换。
- [`turtle_tf_listener.py`](src/catkin_ws/src/tf_hiwonder/scripts/turtle_tf_listener.py)：监听 `turtle1` 和 `turtle2` 的坐标关系，计算速度指令使 `turtle2` 跟随 `turtle1`。
- [`start_tf_demo_py.launch`](src/catkin_ws/src/tf_hiwonder/launch/start_tf_demo_py.launch)：启动 Turtlesim、键盘控制、两个 TF 广播器和 TF 监听器。

## 环境要求

当前源码按照 ROS 1 和 catkin 工作空间组织，运行前需要准备：

- Linux 系统。
- 已安装并正确配置的 ROS 1 发行版。
- `catkin`、`rospy`、`roscpp`、`std_msgs`、`turtlesim`、`tf` 和相关消息包。
- 能够使用 `catkin_make` 构建工作空间。

源码中保留了 ROS 早期 Python 示例的写法，例如 Python 2 风格的 `print`、异常捕获和 `thread` 模块。使用 ROS Noetic 或 Python 3 时，可能需要先迁移语法、线程模块和依赖配置。

## 构建工作空间

在仓库根目录执行：

```bash
cd src/catkin_ws
catkin_make
source devel/setup.bash
```

每次打开新的终端后，都需要重新加载工作空间环境：

```bash
source /opt/ros/<ros1-distro>/setup.bash
source ~/path/to/ros-robotics-learning-notes/src/catkin_ws/devel/setup.bash
```

将 `<ros1-distro>` 替换为实际安装的 ROS 1 发行版名称。

## 示例运行

### Turtlesim 话题示例

先启动 ROS Master 和 Turtlesim：

```bash
roscore
rosrun turtlesim turtlesim_node
```

另开终端加载工作空间后运行发布器：

```bash
source src/catkin_ws/devel/setup.bash
rosrun beginner_hiwonder velocity_publisher.py
```

运行位姿订阅器：

```bash
rosrun beginner_hiwonder pose_subscriber.py
```

也可以按照仓库中的实际文件名启动 Launch 示例：

```bash
roslaunch beginner_hiwonder turtlesim_launch_test.lanuch
```

### 自定义消息示例

`beginner_hiwonder` 通过 `Person.msg` 生成自定义消息接口：

```bash
rosrun beginner_hiwonder person_publisher.py
rosrun beginner_hiwonder person_subscriber.py
```

### 自定义服务示例

先启动服务端，再启动客户端：

```bash
rosrun beginner_hiwonder person_server.py
rosrun beginner_hiwonder person_client.py
```

服务名称为 `/show_person`，服务类型为 `beginner_hiwonder/Person`。

### 参数服务器示例

确保 Turtlesim 已经运行后，执行：

```bash
rosrun parameter_hiwonder parameter_config.py
```

### TF 示例

运行 TF Launch 文件：

```bash
roslaunch tf_hiwonder start_tf_demo_py.launch
```

该示例会启动 Turtlesim、键盘控制节点、TF 广播器和 TF 监听器，演示海龟坐标系之间的转换以及跟随控制。

## 常用 ROS 命令

| 命令 | 用途 |
| --- | --- |
| `roscore` | 启动 ROS Master、参数服务器和基础运行环境 |
| `rosnode list` | 查看当前运行的节点 |
| `rosnode info <node>` | 查看节点信息和通信连接 |
| `rostopic list` | 查看当前话题 |
| `rostopic echo <topic>` | 查看话题消息 |
| `rostopic info <topic>` | 查看话题类型和连接关系 |
| `rosservice list` | 查看当前服务 |
| `rosservice call <service>` | 调用服务 |
| `rosparam list` | 查看参数服务器中的参数 |
| `rosparam get <name>` | 读取参数 |
| `rosparam set <name> <value>` | 设置参数 |
| `rosrun <package> <node>` | 运行功能包中的节点 |
| `roslaunch <package> <file>` | 按 Launch 文件启动多个节点 |
| `rqt_graph` | 可视化节点和话题连接关系 |
| `rviz` | 查看 TF、传感器和机器人状态等可视化数据 |

## 工程结构

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

`build/` 和 `devel/` 是 catkin 生成的构建与开发空间，真正需要维护的 ROS 源码主要位于 `src/catkin_ws/src/`。

## 学习建议

1. 先理解 ROS 的节点、话题、服务、参数和消息五个基本概念。
2. 使用 `catkin_create_pkg`、`catkin_make` 和环境加载命令建立完整的工作空间认知。
3. 先运行标准消息的发布器和订阅器，再阅读 `Person.msg` 自定义消息。
4. 对比 Topic 的持续发布模式和 Service 的请求响应模式。
5. 阅读 `Person.srv`、服务端和客户端，理解接口生成与调用流程。
6. 使用参数服务器修改 Turtlesim 配置，理解节点与参数服务器之间的关系。
7. 使用 Launch 文件管理多节点启动，再通过 TF 和可视化工具观察坐标关系。
8. 每个示例都记录节点名称、话题名称、服务名称、消息类型、启动顺序和资源依赖。

## 注意事项

- ROS 节点、话题、服务和参数名称需要保持一致，名称错误会导致通信连接失败。
- 自定义消息或服务修改后，需要重新执行 `catkin_make` 并重新加载 `devel/setup.bash`。
- 启动客户端前，应确认对应的服务端已经注册；启动订阅器前，应确认发布器或数据源正在运行。
- 多个节点使用相同资源时，应检查节点名称、话题名称和命名空间，避免名称冲突。
- TF 示例依赖正确的坐标系名称和时间戳，坐标关系异常时应优先检查 TF 树和节点日志。
- Python 节点的解释器版本、依赖包和脚本执行权限需要与 ROS 发行版匹配。
- README 中的命令用于学习和演示，实际机器人运行前还需要检查硬件驱动、通信接口、速度限制和安全区域。

## 当前范围

当前仓库包含 ROS 入门课件和三组配套 Python 示例，重点是 ROS 1 基础通信与工具链。仓库暂未包含完整机器人驱动、导航、建图、机械臂控制、Gazebo 仿真工程或 ROS 2 `ament` 工作空间。

## 关键词

`ROS` `ROS 1` `catkin` `rospy` `roscpp` `Topic` `Publisher` `Subscriber` `Service` `Parameter Server` `Custom Message` `Custom Service` `Launch` `TF` `Turtlesim` `RViz` `Python`
