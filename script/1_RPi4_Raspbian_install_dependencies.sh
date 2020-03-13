#!/bin/bash

sudo apt update
sudo apt dist-upgrade

# Compiler Tools
sudo apt install build-essential cmake pkg-config git
sudo apt install gcc g++

# image and video I/O libraries
sudo apt install libjpeg-dev libtiff5 libpng16-16 libpng-dev
sudo apt install libavcodec-dev libavformat-dev libswscale-dev libxvidcore-dev libx264-dev libxine2-dev
sudo apt install libv4l-dev v4l-utils
sudo apt install libgstreamer1.0-dev libgstreamer-plugins-base1.0-dev

## X window (needs clean up)   # omit for now
#sudo apt install libfontconfig1-dev libdbus-1-dev libfreetype6-dev libicu-dev libinput-dev libxkbcommon-dev libsqlite3-dev libssl-dev libpng-dev libjpeg-dev libglib2.0-dev libraspberrypi-dev libcups2-dev libasound2-dev

# OpenGL libraries
sudo apt install mesa-utils
sudo apt install libegl1-mesa-dev libgbm-dev libgles2-mesa-dev
sudo apt install libgl1-mesa-dev libglu1-mesa-dev mesa-common-dev

# optimization libraries
sudo apt install libopenblas-dev libopenblas-base libatlas-base-dev liblapack-dev liblapacke-dev gfortran libeigen3-
dev
sudo apt install freeglut3 freeglut3-dev liblapack-doc libblas-dev

# Choose one from libgtk2.0-dev / libgtk-3-dev / libqt4-dev / libqt5-dev for GUI support  
sudo apt install libqt5-dev   # I chose libqt5-dev

# Extra libraries
sudo apt install zlib1g zlib1g-dev
sudo apt install libboost-all-dev
sudo apt install libavresample-dev
sudo apt install libtbb2 libtbb-dev libdc1394-utils libdc1394-22-dev
sudo apt install python3-dev python3.7-dev python3-pip



