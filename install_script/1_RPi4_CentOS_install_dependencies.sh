#!/bin/bash

# Enable EPEL 7 on armhfp
cat > /etc/yum.repos.d/epel.repo << EOF
[epel]
name=Epel rebuild for armhfp
baseurl=https://armv7.dev.centos.org/repodir/epel-pass-1/
enabled=1
gpgcheck=0

EOF


sudo dnf -y install epel-release
sudo dnf config-manager --set-enabled PowerTools

# Update System
sudo dnf check-update
sudo dnf -y update

# Compiler Tools
sudo dnf -y install gcc gcc-c++ kernel-devel make cmake3 pkgconfig
# sudo dnf -y groupinstall "Development Tools" will install everything above
sudo dnf -y install git

# image and video I/O libraries
sudo dnf -y install ffmpeg
sudo dnf -y install ffmpeg-devel
sudo dnf -y install libpng-devel jasper-devel openexr-devel libwebp-devel
sudo dnf -y install libjpeg-turbo-devel 
sudo dnf -y install libv4l-devel
sudo dnf -y install gstreamer-plugins-base-devel

# X window
sudo dnf -y install libXcomposite libXcursor libXi libXtst libXrandr alsa-lib mesa-libEGL libXdamage mesa-libGL libXScrnSaver

# OpenGL libraries
sudo dnf -y install freeglut-devel mesa-libGL mesa-libGL-devel

# optimization libraries
sudo dnf -y install openblas-devel openblas lapack-devel lapack gcc-gfortran eigen3-devel

# GUI support
sudo dnf -y install qt5-qtbase-devel

# Extra libraries
sudo dnf -y install boost boost-thread boost-devel
sudo dnf -y install libtiff-devel libdc1394-devel tbb-devel 
sudo dnf -y install python36 python36-devel python36-pip






# Install virtualenv and virtualenvwrapper
sudo pip3 install virtualenv virtualenvwrapper
sudo pip3 install --upgrade numpy


# Append the following lines.
echo "# virtualenv and virtualenvwrapper" >> ~/.bashrc
echo "export WORKON_HOME=$HOME/.virtualenvs" >> ~/.bashrc
echo "export VIRTUALENVWRAPPER_PYTHON=/usr/local/bin/python3" >> ~/.bashrc
echo "source /usr/local/bin/virtualenvwrapper.sh" >> ~/.bashrc

# Reload ~/.bashrc
source ~/.bashrc

# Create Python 3 virtual environment
mkvirtualenv OpenCV-"$cv_v" -p python3
workon OpenCV-"$cv_v"

# install the PiCamera API and other libraries
pip3 install "picamera[array]"
pip3 install cmake cython
pip3 install numpy scipy matplotlib scikit-image scikit-learn ipython dlib
pip3 install face_recognition imutils

deactivate



