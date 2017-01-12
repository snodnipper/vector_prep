#!/bin/bash

if [ $EUID != 0 ]; then
  sudo "$0" "$@"
  exit $?
fi

echo Building Mapbox SDK Docker containers
echo $(pwd)
cd mapbox-gl-native
sudo ./docker/build.sh
sudo ./docker/linux/run.sh

