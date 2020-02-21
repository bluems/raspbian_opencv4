#! /bin/bash

#스왑늘리는 기능 추가해야 함
echo "---> increasing swap mem size"
sudo sed -i 's/CONF_SWAPSIZE=100/CONF_SWAPSIZE=1024/g' /etc/dphys-swapfile
sudo /etc/init.d/dphys-swapfile stop
sudo /etc/init.d/dphys-swapfile start

#기본 환경
sudo apt install -y build-essential cmake pkg-config libjpeg-dev libtiff5-dev libpng-dev libavcodec-dev libavformat-dev libswscale-dev libxvidcore-dev libx264-dev libxine2-dev libv4l-dev v4l-utils libgstreamer1.0-dev libgstreamer-plugins-base1.0-dev libgtk2.0-dev

for i in "$@"; do
	if [ $i == "-gtk3" ]; then
		sudo apt install libgtk-3-dev
	elif [ $i == "-qt4" ]; then
		sudo apt install libqt4-dev
	elif [ $i == "-qt5" ]; then
		sudo apt install libqt5-dev
	elif [ $i == "-gl" ]; then
		sudo apt install mesa-utils libgl1-mesa-dri libgtkgl2.0-dev libgtkglext1-dev
	elif [ $i == "-py2" ]; then
		sudo apt install python2.7-dev python-numpy
	elif [ $i == "-py3" ]; then
		sudo apt install python3-dev python3-numpy
	fi
done

# opencv 최적화
sudo apt install -y libatlas-base-dev gfortran libeigen3-dev

echo "---> resetting swap mem size"
sudo sed -i 's/CONF_SWAPSIZE=1024/CONF_SWAPSIZE=100/g' /etc/dphys-swapfile
sudo /etc/init.d/dphys-swapfile stop
sudo /etc/init.d/dphys-swapfile start

#for i in "$@"; do
#	if [ $i == "-auto" ] || [ $i == "-install" ]; then
#		./rasp_opencv.sh $*
#	fi
#done
