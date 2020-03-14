# face_recognition_linux

<details>
 <summary><h2>Install OpenCV 4</h2></summary>
 

Instructions on how to set up a system for face recognition on Linux  
I will not be providing instructions for Windows due to compatibility issues  

### Raspberry Pi 4 

####    for CentOS or Raspbian, refer [here](install_script/0_RPi4.md)  

### Jetson Nano

####    for Ubuntu, refer [here]
    coming soon.  
    
### Linux

####    for CentOS, refer [here]
    coming soon.  
    
####    for Ubuntu 18.04, refer [here]
    coming soon.  
    
</details>

<details>
 <summary><h2>Live Face Recognition</h2></summary>
 

###    Resources
[OpenCV Face Recognition](https://www.pyimagesearch.com/2018/09/24/opencv-face-recognition/)

**Note:** I tested this only on RPi4  
This features building our own facial dataset to detect and recognize our face in a live video stream on RPi4  
Before we run the commands below, make sure the virtual environment is activated!  

### Step #1: Create Necessary Directories
Navigate to the downloaded `pi_face_recognition`  
There are 5 files (3 python scripts, 1 pickle, 1 xml).  
Along the files, you should create a directory called `dataset`  
In the `dataset` directory, we will create another directory. This time, you can name it freely, just take a note of it.  
In this example, I used my initial, **WC**  
<pre>
cd pi_face_recognition
sudo mkdir -p dataset/<b>WC</b>
</pre>
_Change **WC** to the name you gave above_

### Step #2: Build Face Dataset
This is where you will build your own dataset  
Once a desired face is detected (there will be a rectangular box around it), you will press `k` to save it to `dataset/WC`  
Once done, press `q` to exit  
More the higher recognition accuracy  
Try different angles, different facial expressions, etc...  
<pre>
python3 0_build_face_dataset.py --cascade haarcascade_frontalface_default.xml --output dataset/<b>WC</b>
</pre>

_Change **WC** to the name you gave above_


### Step #3: Encode Faces
Encoding the dataset(faces) gathered above to a pickle file to be used for recognition.  
```sh
python3 1_encode_faces.py --dataset dataset --encodings encodings.pickle --detection-method hog
```

### Step #4: Recognize

```sh
python3 2_pi_face_recognition.py --cascade haarcascade_frontalface_default.xml --encodings encodings.pickle
```
Once face is detected and recognized, a rectangular box will appear around the face and output:  
`unknown` if unrecognized,  
`WC` if recognized.  

Done!  
</details>



