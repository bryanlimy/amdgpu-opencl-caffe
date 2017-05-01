#autoinsaller + checker script

#!/bin/bash

old_path=$pwd
wizardroot='/tmp/driverwizard'
rm -rf $wizardroot

mkdir -p $wizardroot
 

wget -O driver.tar.xz --referer 'https://www2.ati.com' 'https://www2.ati.com/drivers/linux/ubuntu/amdgpu-pro-16.40-348864.tar.xz' #U-turn for rascal server redirecting


tar -xf 'driver.tar.xz' -C $wizardroot

cd $wizardroot && cd * ;

`./amdgpu-pro-install -y` 


read -p 'Driver installation completed, would you like to reboot now?(n/y) ' ans

rm -rf $wizardroot

if [ ans -e 'y'] then
	rm -rf '$old_path/driver.tar.xz'
	echo -e 'done'
fi