#!/bin/bash

# Build container to fetch data
echo "Build the data fetcher Container"
cd 0_data_prepare
sudo docker build -t data-download .
cd ..

echo We are here $(pwd)
FILENAME="${DOWNLOAD_URL##*/}"
echo Filename: "$FILENAME"

# Download if file not already there
if [ ! -f $FILENAME ]; then
   echo "Downloading $DOWNLOAD_URL"
   wget $DOWNLOAD_URL
else
   echo "$FILENAME already there...skipping download."
fi

