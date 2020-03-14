#!/bin/bash

# Update System
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






# Install virtualenv and virtualenvwrapper
sudo pip3 install virtualenv virtualenvwrapper
sudo pip3 install --upgrade numpy


# append the following lines to the bottom of the file:
#    # virtualenv and virtualenvwrapper
#    export WORKON_HOME=$HOME/.virtualenvs
#    export VIRTUALENVWRAPPER_PYTHON=/usr/local/bin/python3
#    source /usr/local/bin/virtualenvwrapper.sh

sed -i '$a\# virtualenv and virtualenvwrapper' ~/.bashrc
sed -i '$a\export WORKON_HOME=$HOME/.virtualenvs' ~/.bashrc
sed -i '$a\export VIRTUALENVWRAPPER_PYTHON=/usr/local/bin/python3' ~/.bashrc
sed -i '$a\source /usr/local/bin/virtualenvwrapper.sh' ~/.bashrc

# Reload ~/.bashrc
source ~/.bashrc

# Create Python 3 virtual environment
mkvirtualenv OpenCV-"$cv_v" -p python3
workon OpenCV-"$cv_v"
# Note: Python 2.7 will reach end of its life on January 1st, 2020 so I do not recommend using Python 2.7.
# OpenCV-master is the name of our virtual environment, using Python3

# install the PiCamera API and other libraries
pip3 install "picamera[array]"
pip3 install cmake cython
pip3 install numpy scipy matplotlib scikit-image scikit-learn ipython dlib
pip3 install face_recognition imutils

deactivate


