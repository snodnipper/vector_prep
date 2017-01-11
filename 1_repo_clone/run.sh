#!/bin/bash

if [ $EUID != 0 ]; then
  sudo "$0" "$@"
  exit $?
fi

# Build container to clone repository
echo "Build the repo cloner Container"
sudo docker build -t mapbox-docker .

echo We are here $(pwd)
# Clone or update, depending if it is there
if [ ! -d mapbox-gl-native ]; then
   echo "Execute clone"
   sudo docker run -v $(pwd):/root mapbox-docker /usr/bin/git clone https://github.com/mapbox/mapbox-gl-native.git
else
   echo "Execute update"
   sudo docker run -v $(pwd):/root mapbox-docker /bin/bash -c "cd mapbox-gl-native;/usr/bin/git pull"
fi

