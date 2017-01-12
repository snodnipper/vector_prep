#!/bin/bash

# Build container to fetch data
echo "Build the data fetcher Container"
cd 0_data_prepare
sudo docker build -t data-download .
cd ..

echo We are here $(pwd)
FILENAME="${DOWNLOAD_MBTILES##*/}"
echo Filename: "$FILENAME"

# Download if file not already there
if [ ! -f $FILENAME ]; then
   echo "Downloading $DOWNLOAD_MBTILES"
   sudo docker run --user root -v $(pwd):/root/ -t data-download /bin/bash -c "wget $DOWNLOAD_MBTILES"
else
   echo "$FILENAME already there...skipping download."
fi


# Fetch container with mbutil command
#sudo docker pull jskeates/mbutil
#sudo docker run -it -v $(pwd):/root/ jskeates/mbutil mbutil --image_format=pbf $FILENAME ./output
