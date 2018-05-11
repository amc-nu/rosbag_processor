cmake_minimum_required(VERSION 2.8.3)
project(image_resizer)

find_package(catkin REQUIRED COMPONENTS
  cv_bridge
  rospy
  std_msgs
)

catkin_package(
#  INCLUDE_DIRS include
#  LIBRARIES image_resizer
#  CATKIN_DEPENDS cv_bridge rospy std_msgs
#  DEPENDS system_lib
)

include_directories(
# include
  ${catkin_INCLUDE_DIRS}
)

catkin_install_python(PROGRAMS
  script/image_resizer.py
  launch/omron_image_compressor.launch
  DESTINATION ${CATKIN_PACKAGE_BIN_DESTINATION})
