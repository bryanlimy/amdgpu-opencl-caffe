# amdgpu-opencl-caffe
### Enablement for [Caffe (OpenCL)](https://github.com/BVLC/caffe/tree/opencl) on AMD GPUs


#### System Requirement
- Ubuntu 16.04 or above
- AMD Radeon GPU (tested on):
	- Polaris
	- Fiji

#### 1. Install general dependencies
- ```sudo apt-get install libprotobuf-dev libleveldb-dev libsnappy-dev libopencv-dev libhdf5-serial-dev protobuf-compiler```
- ```sudo apt-get install --no-install-recommends libboost-all-dev```

#### 1. Install AMDGPU-PRO Driver for Linux
- [Download AMDGPU-PRO Driver](http://support.amd.com/en-us/kb-articles/Pages/AMDGPU-PRO-Driver-for-Linux-Release-Notes.aspx)
- [Follow instruction to install AMDGPU-PRO Driver for Ubuntu](http://support.amd.com/en-us/kb-articles/Pages/AMDGPU-PRO-Install.aspx)


#### 2. Download [Caffe](https://github.com/BVLC/caffe)
- Download Caffe (on this example, download repository to home folder)
	```> git clone https://github.com/BVLC/caffe```
- Switch to OpenCL branch (verified commit [51f2986](https://github.com/BVLC/caffe/tree/51f2986ee0c3955bfaaa495b25e9a1d0a7036c26) works)
	```> git checkout opencl```


#### 3. Install [ViennaCL](http://viennacl.sourceforge.net/) library
- [Download ViennaCL for Linux](http://viennacl.sourceforge.net/viennacl-download.html)
- Extract downloaded folder
	'``> tar -xvf ViennalCL-<version>.tar.gz```
- Copy extracted folder to Caffe
	```> cp -r ViennalCL-<version> ~/caffe```


##### 4. Install [Caffe](https://github.com/BVLC/caffe)
- Create directory for cmake
	```> mkdir build```
- Navigate to `build` 
	```> cd build```
- Configure and cmake Caffe
	```> cmake -DViennaCL_INCLUDE_DIR=../ViennaCL-<version> -DOPENCL_LIBRARIES=/opt/amdgpu-pro/lib/x86_64-linux-gnu/libOpenCL.so.1 ..```
    p.s. by default OpenCL header for AMDGPU is at `/opt/amdgpu-pro/x86_64-linux-gnu/libOpenCL.so.1`
- Compile Caffe
	```> make```
	p.s. add `-j<# core>` to speed up process
- Install Caffe
	```> make install```
- Test Caffe
	```> make runtest```
	ps. add `-j<# core>` to speed up process


#### 5. Install Caffe for Python
- Navigate to `python` in `/caffe`
	```> cd python```
- Install all required packages with `pip`
	```> for req in $(cat requirements.txt); do sudo -H pip install $req; done```
- Add PyCaffe module to `$PYTHONPATH`
	```> export PYTHONPATH=/home/aes/caffe/python:$PYTHONPATH```
