
# Install OpenCV 4 on Raspberry Pi 4
## Step #0: Setting Up
**Note:** Some processes take a long time;  
to prevent unwated system shutdowns for power saving, change the settings
> Power Manager settings: Disable sleep and auto poweroff

### Update raspi-config, enable camera, expand partition, confirm GPU ram is 128MB

<ol type="a">
  <li>CentOS 7/8:  
  
  Relax.  
  Reboot.
    
  <li>Raspbian:  
  
  In the terminal, type:
  ```sh
  sudo raspi-config
  ```
  > "09 Update"  
  > "05 Interfacing Options" -> "P1 Camera" (this enables camera and increases GPU ram to 128 from 64MB)  
  > "07 Advanced Options" -> "A1 Expand Filesystem" (resize the installation partition)  
  > "07 Advanced Options" -> "A3 Memory Split" (confirm GPU ram size is 128)  
  
  Reboot.
</ol>


## Step #1: Preparation (Download)
### Step #1-1: Script for installing dependencies needed for OpenCV installation
**Note:** You do not, and should not need to download both scripts for Step #1-1  
Choose your operating system for the RPi4  
<ol type="a">
  <li>CentOS 7/8:  
    
[1_RPi4_CentOS_install_dependencies.sh](1_RPi4_CentOS_install_dependencies.sh)  </li>
  <li>Raspbian:  

[1_RPi4_Raspbian_install_dependencies.sh](1_RPi4_Raspbian_install_dependencies.sh)</li>
</ol>

### Step #1-2: Script for downloading OpenCV
[2_RPi4_download_opencv.sh](2_RPi4_download_opencv.sh)

### Step #1-3: Script for building OpenCV
[3_RPi4_build_opencv.sh](3_RPi4_build_opencv.sh)

## Step #2: Setup

### Step #2-1: Specify OpenCV Version
In the terminal, type:
```sh
cv_v="master"
```
This indicates that we will be working off the master branch of OpenCV git

### Step #2-2: Save current working directory
In the terminal, type:
```sh
cwd=$(pwd)/opencv
```

### Step #2-3: Create the working directory
```sh
sudo mkdir -p $cwd
cd $cwd
```

### Step #2-4: [OPTIONAL] Clean the build directory
Just in case you mess up during the build process and want to restart build:
```sh
cd ..
sudo rm -rf build
sudo mkdir build
cd build
```

## Step #3: Installation
Navigate to /Downloads directory
```sh
cd Downlaods
```

### Step #3-1: Run script for installing dependencies
<ol type="a">
  <li>CentOS 7/8:  
    
    ```sh
    bash 1_RPi4_CentOS_install_dependencies.sh
    ```
    
  <li>Raspbian:  
    
    ```sh
    bash 1_RPi4_Raspbian_install_dependencies.sh
    ```  

</ol>

### Step #3-2: Run script for downloading OpenCV
```sh
bash 2_RPi4_download_opencv.sh
```

### Step #3-3: Run script for building OpenCV
```sh
bash 3_RPi4_build_opencv.sh
```

### Step #3-4: Install from build
```sh
sudo make install
sudo ldconfig
```



