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
   wget $DOWNLOAD_MBTILES
else
   echo "$FILENAME already there...skipping download."
fi
