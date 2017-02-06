# amdgpu-opencl-caffe
### Enablement for [Caffe (OpenCL)](https://github.com/BVLC/caffe/tree/opencl) on AMD GPUs

####Authors

- Bryan Li (Bryan.Li@amd.com)
- Ramin Ranjbar (Ramin.Ranjbar@amd.com)


#### System Requirement
- Ubuntu 16.04 or equivalent
	- Note that a supported (valid) opencl enabled driver stack is needed from AMD
- AMD Radeon GPU (tested on):
	- Polaris (RX460)
	- Fiji (R9 Fury, Fury X)

#### 1. Update to latest Canonical release
- Update the apt metadata: ```sudo apt-get update```
- Upgrade the packages: ```sudo apt-get upgrade```

#### 2. Install general dependencies
- ```sudo apt-get install libprotobuf-dev libleveldb-dev libsnappy-dev libopencv-dev libhdf5-serial-dev protobuf-compiler libatlas-base-dev libblas-dev libgflags-dev libgoogle-glog-dev liblmdb-dev libboost-all-dev git```
- For Caffe's python interface, see section #7 below. 

#### 3. Install AMDGPU-PRO Driver for Linux
- [Download AMDGPU-PRO Driver](http://support.amd.com/en-us/kb-articles/Pages/AMDGPU-PRO-Driver-for-Linux-Release-Notes.aspx)
- [Follow instruction to install AMDGPU-PRO Driver for Ubuntu](http://support.amd.com/en-us/kb-articles/Pages/AMDGPU-PRO-Install.aspx)
- Reboot to the kernel that loads the installed drivers

#### 4. Download [Caffe](https://github.com/BVLC/caffe)
- Download Caffe (on this example, download repository to home folder)
	- ```> cd ~ ; git clone https://github.com/BVLC/caffe```
	- ```> cd caffe ; git checkout opencl```
	- ```> export OCLCAFFE=$PWD```

#### 5. Install [ViennaCL](http://viennacl.sourceforge.net/) library
- [Download ViennaCL for Linux](http://viennacl.sourceforge.net/viennacl-download.html)
- Extract downloaded folder
	'``> tar -xvf ViennalCL-<version>.tar.gz```
- Copy extracted folder to Caffe
	```> cp -r ViennalCL-<version> ~/caffe```

##### 6. Install [Caffe](https://github.com/BVLC/caffe)
- Create directory for cmake
	```> mkdir build```
- Navigate to `build` 
	```> cd build```
- Configure and cmake Caffe
	```> cmake -DViennaCL_INCLUDE_DIR=../ViennaCL-* -DOPENCL_INCLUDE_DIRS=../ViennaCL-*/CL/ -DOPENCL_LIBRARIES=/opt/amdgpu-pro/lib/x86_64-linux-gnu/libOpenCL.so.1 ..```
    Note: By default OpenCL libraries for AMDGPU is at `/opt/amdgpu-pro/x86_64-linux-gnu/libOpenCL.so.1`
- Compile Caffe
	```> make```
	Note: You can enable multithreaded compilation with`-j<# threads_available>` to speed up the process. 
	For an 8 core machine we can use : ```make -j8```
- Install Caffe
	```> make install```
- Test Caffe
	```> make runtest```
	Note2: For multithreaded build, add `-j<# cores_available>` to speed up process. Eg. make -j8 for 8 threaded CPU.

##### 7. Try CIFAR (CANADIAN INSTIT. FOR ADVANCED RESEARCH DATA TRAINING)
- Go to your caffe path : ```cd $OCLCAFFE```
- Invoke the commands from the caffe top module folder (i.e ~/caffe):
	- ./data/cifar/get_cifar10.sh
	- ./examples/cifar10/create_cifar10.sh 
	- ./examples/cifar10/train_quick.sh 

- Note: You can substitute train_quick with train_full as needed. This will increase the time needed to fully train the model, however. 
	
#### 8. Install Caffe for Python
- Navigate to `python` in `/caffe`
	```> cd python```
- Install all required packages with `pip`
	```> for req in $(cat requirements.txt); do sudo -H pip install $req; done```
- Add PyCaffe module to `$PYTHONPATH`
	```> export PYTHONPATH=$OCLCAFFE/python:$PYTHONPATH```
