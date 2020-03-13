# Install OpenCV 4 on Raspberry Pi 4 with Raspbian
Prerequisite: Raspberry Pi 4 with Raspbian (root access) and a camera module
## Step 0: Setting Up
**Note:** Some processes take a long time;  
to prevent system shutdown for power saving issues, change the settings  
> Power Manager settings: Disable sleep and auto poweroff

### Update kalipi-config, enable camera, expand partition, confirm GPU ram is 128MB
In the terminal, type:
```sh
sudo raspi-config
```
"09 Update"  
"05 Interfacing Options" -> "P1 Camera" (this enables camera and increases GPU ram to 128 from 64MB)  
"07 Advanced Options" -> "A1 Expand Filesystem" (resize the installation partition)  
"07 Advanced Options" -> "A3 Memory Split" (confirm GPU ram size is 128)  

Reboot  
  
## Step 1: Update OS
```sh
sudo apt update
sudo apt dist-upgrade
```

## Step 2: Install Dependencies

Compiler Tools
```sh
sudo apt install build-essential cmake pkg-config git
sudo apt install gcc g++
```

image and video I/O libraries
```sh
sudo apt install libjpeg-dev libtiff5 libpng16-16 libpng-dev
sudo apt install libavcodec-dev libavformat-dev libswscale-dev libxvidcore-dev libx264-dev libxine2-dev
sudo apt install libv4l-dev v4l-utils
sudo apt install libgstreamer1.0-dev libgstreamer-plugins-base1.0-dev
```

Install X windows libraries and OpenGL libraries
```sh
sudo apt install mesa-utils
sudo apt install libxmu-dev libxi-dev
sudo apt install libglu1-mesa libglu1-mesa-dev
sudo apt install libgles2-mesa libgles2-mesa-dev
sudo apt install libgl1-mesa-dev libgl1-mesa-dri
sudo apt install libgtkgl2.0-1 libgtkgl2.0-dev libgtkglext1-dev
```

optimization libraries
```sh
sudo apt install libopenblas-dev libopenblas-base libatlas-base-dev liblapack-dev liblapacke-dev gfortran libeigen3-
dev
sudo apt install freeglut3 freeglut3-dev liblapack-doc libblas-dev
```

Choose one from libgtk2.0-dev / libgtk-3-dev / libqt4-dev / libqt5-dev  
for GUI support
```sh
sudo apt install libx11-dev libqt5-dev
```

Extra Libraries  
```sh
sudo apt install zlib1g zlib1g-dev
sudo apt install libboost-all-dev
sudo apt install libavresample-dev
sudo apt install libtbb2 libtbb-dev libdc1394-utils libdc1394-22-dev
sudo apt install python3-dev python3.7-dev python3-pip
```

## Step 3: Before installation
### Specify OpenCV Version
In the terminal, type:
```sh
cvVersion="$master"
```
### Save current working directory
```sh
cwd=$(pwd)/opencv
```
### creating a working directory
```sh
mkdir -p $cwd
cd $cwd
```
#### [OPTIONAL] If you mess up while building,
Clean build directories
```sh
rm -rf opencv
rm -rf opencv_contrib
```

## Step 4: Virtual Environment Setup
URL: https://www.pyimagesearch.com/2019/09/16/install-opencv-4-on-raspberry-pi-4-and-raspbian-buster/  
Install virtualenv and virtualenvwrapper
```sh
sudo pip3 install virtualenv virtualenvwrapper
sudo pip3 install numpy (--upgrade)
```

Once both virtualenv and virtualenvwrapper have been installed, open up your ~/.bashrc  file:
```sh
nano ~/.bashrc
```

Append the following lines to the bottom of the file:
```sh
# virtualenv and virtualenvwrapper
export WORKON_HOME=$HOME/.virtualenvs
export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python3
source /usr/local/bin/virtualenvwrapper.sh
```
Save and exit via ctrl + x, y, enter  

Reload ~/.bashrc
```sh
source ~/.bashrc
```

Create Python3 Virtual Environment
```sh
mkvirtualenv OpenCV-"$cvVersion" -p python3
```
**Note:** Python 2.7 will reach end of its life on January 1st, 2020 so I do not recommend using Python 2.7.  
OpenCV-master is the name of our virtual environment, using Python3  

Install PICamera API and needed libraries
```sh
pip3 install "picamera[array]"
pip3 install cmake cython
pip3 install numpy scipy matplotlib scikit-image scikit-learn ipython dlib
pip3 install face_recognition imutils
```




## Step 5: Compile OpenCV 4 from source
### quit virtual environment and download from Github
```sh
deactivate
git clone https://github.com/opencv/opencv.git
cd opencv
git checkout $cvVersion
cd ..
git clone https://github.com/opencv/opencv_contrib.git
cd opencv_contrib
git checkout $cvVersion
cd ..
cd opencv
```
Apply Patch
URL: https://github.com/AastaNV/JEP/blob/master/script/install_opencv4.1.1_Jetson.sh
```sh
sed -i 's/include <Eigen\/Core>/include <eigen3\/Eigen\/Core>/g' modules/core/include/opencv2/core/private.hpp
```

```
mkdir build
cd build
```
Apply Patch (Could not find OpenBLAS include)
# https://github.com/opencv/opencv/issues/9953

# https://github.com/opencv/opencv/issues/12957
sudo ln -s /usr/include/lapacke.h /usr/include/aarch64-linux-gnu
# opencv/cmake/OpenCVFindOpenBLAS.cmake
# add: /usr/include/aarch64-linux-gnu to SET(Open_BLAS_INCLUDE_SEARCH_PATHS
# add: /usr/lib/aarch64-linux-gnu to SET(Open_BLAS_LIB_SEARCH_PATHS
workon OpenCV-“$cvVersion”-py3
cmake -D CMAKE_BUILD_TYPE=RELEASE \
# -D CMAKE_INSTALL_PREFIX=$cwd/installation/OpenCV-master \
# https://www.learnopencv.com/install-opencv-4-on-raspberry-pi/
# For system wide installation of OpenCV
-D CMAKE_INSTALL_PREFIX=/usr/local \
-D OPENCV_EXTRA_MODULES_PATH=../../opencv_contrib/modules \
-D WITH_GSTREAMER=ON \
-D WITH_LIBV4L=ON \
-D WITH_V4L=ON \
-D WITH_TBB=ON \
-D WITH_IPP=OFF \
-D WITH_1394=OFF \
-D BUILD_WITH_DEBUG_INFO=OFF \
-D BUILD_DOCS=OFF \
-D INSTALL_C_EXAMPLES=ON \
-D INSTALL_PYTHON_EXAMPLES=ON \
-D WITH_QT=OFF \
-D WITH_GTK=ON \
-D WITH_OPENGL=ON \
-D OPENCV_ENABLE_NONFREE=ON \
-D WITH_XINE=ON \
-D CMAKE_SHARED_LINKER_FLAGS=-latomic \
-D BUILD_NEW_PYTHON_SUPPORT=ON \
-D ENABLE_CXX11=ON \
-D ENABLE_NEON=ON \
# disable vfpv3 for RPi4 for now
-D ENABLE_VFPV3=ON \
-D OPENCV_SKIP_PYTHON_LOADER=ON \
-D OPENCV_PYTHON3_INSTALL_PATH=/home/pi/.virtualenvs/OpenCV-master-py3/lib/python3.7/site-packages \
-D BUILD_TESTS=OFF \
-D BUILD_EXAMPLES=OFF \
-D PYTHON_DEFAULT_EXECUTABLE=/usr/bin/python3 \
-D OPENCV_GENERATE_PKGCONFIG=ON \
-D BUILD_PERF_TESTS=OFF ..
make -j$(nproc)
sudo make install
sudo ldconfig
# reset swap
# Sym-link your OpenCV 4 on the Raspberry Pi
#cd /usr/local/lib/python3.7/site-packages/cv2/python-3.7
#sudo mv cv2.cpython-37m-arm-linux-gnueabihf.so cv2.so
#cd ~/.virtualenvs/cv/lib/python3.7/site-packages/
#ln -s /usr/local/lib/python3.7/site-packages/cv2/python-3.7/cv2.so cv2.so
cd /home/pi/opencv/opencv/build/lib/python3/
sudo mv cv2.cpython-37m-arm-linux-gnueabihf.so cv2.so
cd ~/.virtualenvs/OpenCV-“$cvVersion”-py3/lib/python3.7/site-packages/
ln -s /home/pi/opencv/opencv/build/lib/python3/cv2.so cv2.so
