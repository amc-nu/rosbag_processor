#!/bin/bash

source $PWD/devel/setup.bash
chmod +x src/script/image_resizer.py
echo "Rosbag batch processor"
if [ "$1" != "" ]; then

  if [ "$2" != "" ]; then
    out_path="$2"
  else
    out_path="$1"
  fi

  mkdir -p "$out_path"
  for entry in "$1"/*
  do
    echo "------------------------------------------------------------"
    echo "------------------------------------------------------------"
    echo "------------------------------------------------------------"
    echo "------------------------------------------------------------"
    echo "-----------Processing File Rosbag $entry"
    if [ -f "$entry" ]; then
      roslaunch image_resizer omron_image_compressor_remove_omron_lidar.launch bag_path:="$1" bag_file:="$(basename $entry)" out_path:="$out_path"
      #echo "bag_path:=$1 bag_file:=$(basename $entry) out_path:=$out_path"
    else
      echo "$entry is not a file. Skipping."
    fi
  done
else
  echo ""
  echo "No Path indicated. Finalizing. FULL Path to location of rosbags is required."
  echo "Usage:"
  echo ""
  echo "sh batch_process.sh PATH/TO/ROSBAGS [PATH/TO/RESULT]"
  echo ""
  echo "PATH/TO/RESULT is optional"
  echo ""
  echo "END"
fi
