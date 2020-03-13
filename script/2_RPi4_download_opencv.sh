#!/bin/bash

# Specifying the OpenCV version
cv_v="master"

cwd=$(pwd)/opencv
mkdir -p $cwd
cd $cwd

git clone https://github.com/opencv/opencv.git
cd opencv
git checkout $cvVersion
cd ..
git clone https://github.com/opencv/opencv_contrib.git
cd opencv_contrib
git checkout $cv_v
cd ..
cd opencv



# Apply Patch
# https://github.com/AastaNV/JEP/blob/master/script/install_opencv4.1.1_Jetson.sh
sed -i 's/include <Eigen\/Core>/include <eigen3\/Eigen\/Core>/g' modules/core/include/opencv2/core/private.hpp










