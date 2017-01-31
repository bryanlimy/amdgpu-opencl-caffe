# amdgpu-opencl-caffe
### Enablement for [Caffe (OpenCL)](https://github.com/BVLC/caffe/tree/opencl) on AMD GPUs

### System Requirement
- Ubuntu 16.04 or above
- AMD Radeon GPU (tested on):
	- Polaris
	- Fiji

### 1. Install AMDGPU-PRO Driver for Linux
- [Download AMDGPU-PRO Driver](http://support.amd.com/en-us/kb-articles/Pages/AMDGPU-PRO-Driver-for-Linux-Release-Notes.aspx)
- [Follow instruction to install AMDGPU-PRO Driver for Ubuntu](http://support.amd.com/en-us/kb-articles/Pages/AMDGPU-PRO-Install.aspx)

### 2. Download [Caffe](https://github.com/BVLC/caffe)
- Download Caffe (on this example, download repository to home folder)
	`> git clone https://github.com/BVLC/caffe`
- Switch to OpenCL branch
	`> git checkout opencl`


### 3. Install [ViennaCL](http://viennacl.sourceforge.net/) library
- [Download ViennaCL for Linux](http://viennacl.sourceforge.net/viennacl-download.html)
- Extract downloaded folder
	'> tar -xvf ViennalCL-<version>.tar.gz'
- Copy the CL folder to `/user/include`
	`> sudo cp fCL /usr/include`
