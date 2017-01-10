#!/bin/bash

#======================================================================
# Prepare Docker Installation
# https://docs.docker.com/engine/installation/linux/ubuntulinux/#/install-the-latest-version
#======================================================================

if [ $EUID != 0 ]; then
  sudo "$0" "$@"
  exit $?
fi

function dockerPrepare {
  UBUNTU_RELEASE=$(lsb_release -rs)
  if [ "$UBUNTU_RELEASE" != "12.04" ] &&
     [ "$UBUNTU_RELEASE" != "14.04" ] &&
     [ "$UBUNTU_RELEASE" != "15.10" ] &&
     [ "$UBUNTU_RELEASE" != "16.04" ]; then
    echo "THIS SCRIPT DOES NOT SUPPORT YOUR OS VERSION."
    echo " - latest supported version is Ubuntu 16.04"
    exit
  fi


  sudo apt-get update
  sudo apt-get install apt-transport-https ca-certificates

  sudo apt-key adv \
  --keyserver hkp://ha.pool.sks-keyservers.net:80 \
  --recv-keys 58118E89F3A912897C070ADBF76221572C52609D

  DOCKER_REPO="UNSUPPORTED"
  if [ "$UBUNTU_RELEASE" == "16.04" ]; then
    DOCKER_REPO="deb https://apt.dockerproject.org/repo ubuntu-xenial main"
    elif [ "$UBUNTU_RELEASE" == "15.10"  ]; then
    DOCKER_REPO="deb https://apt.dockerproject.org/repo ubuntu-wily main"
    elif [ "$UBUNTU_RELEASE" == "14.04"  ]; then
    DOCKER_REPO="deb https://apt.dockerproject.org/repo ubuntu-trusty main"
    elif [ "$UBUNTU_RELEASE" == "12.04"  ]; then
    DOCKER_REPO="deb https://apt.dockerproject.org/repo ubuntu-precise main"
  else
    echo "UNSUPPORTED."
    exit
  fi
  echo "$DOCKER_REPO" | sudo tee /etc/apt/sources.list.d/docker.list

  sudo apt-get update
  apt-cache policy docker-engine

  if [ "$UBUNTU_RELEASE" != "14.04" ] &&
  [ "$UBUNTU_RELEASE" != "15.10" ] &&
  [ "$UBUNTU_RELEASE" != "16.04" ]; then
    sudo apt-get update
    sudo apt-get install linux-image-extra-"$(uname -r)" linux-image-extra-virtual
    elif [ "$UBUNTU_RELEASE" == "12.04" ]; then
    sudo apt-get update
    sudo apt-get install linux-image-generic-lts-trusty
    if [ ! -f rebooted_for_precise ]; then
      touch rebooted_for_precise
      sudo reboot
    fi
  fi
}

#======================================================================
# Install latest version of Docker
# Note: for production versions a specific version should be used
#======================================================================
function dockerInstall() {
  sudo apt-get update
  sudo apt-get install docker-engine
  sudo service docker start
  sudo docker run hello-world
}

#======================================================================
# main
#======================================================================
if [ $EUID != 0 ]; then
  sudo "$0" "$@"
  exit $?
fi
dockerPrepare
dockerInstall
