#!/bin/bash

#if [ -d output ]; then
#   echo Yikes!  Please remove the 'output' directory - we need that to put new vector tiles.
#fi

# arg1: download URL
# arg2: variable to set the OUTPUT file
download () {
    if [ -z "$1" ]; then
        echo "Download URL parameter is required!  This is the URL to download an MBTiles file"
        exit 1
    fi

    echo Downloading: $1
    FILENAME="${1##*/}"
    echo File: $FILENAME

    # Download if file not already there
    if [ ! -f $FILENAME ]; then
        echo "Downloading $DOWNLOAD_MBTILES"
        sudo docker run --user root -v $(pwd):/root/ -t data-download /bin/bash -c "wget $DOWNLOAD_MBTILES"
    else
        echo "$FILENAME already there...skipping download."
    fi
    eval "$2=$FILENAME"
}

downloadPrepare () {
    echo "Build the data fetcher Container"
    cd 0_data_prepare
    sudo docker build -t data-download .
    cd ..
}

unpack () {
    sudo docker run -it -v $(pwd):/root/ --entrypoint=/bin/sh jskeates/mbutil -c "cd /root/;ls -al;/usr/local/bin/mb-util --image_format=pbf /root/$FILENAME /root/output"
    pwd
    sudo chown -R ubuntu:ubuntu ./output/
    mv ./output ./output_$FILENAME
}

unpackPrepare () {
    sudo docker pull jskeates/mbutil
}

# intialise
downloadPrepare
unpackPrepare

# main
DOWNLOAD_MBTILES="https://yourlocation.com/beautiful_maps.mbtiles"
OUTPUT_FILE=
download $DOWNLOAD_MBTILES $OUTPUT_FILE
unpack $OUTPUT_FILE
