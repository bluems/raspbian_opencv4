#! /bin/bash
pkg-config --modversion opencv
if [ "$?" -eq 0 ]; then
	sudo apt purge -y libopencv* python-opencv python3-opencv
	sudo apt autoremove -y
	sudo find /usr/local/ -name "*opencv*" -exec rm -i {} \;
else
	echo "[BlueMS] No OpenCV"
fi

for i in "$@"; do
	if [ $i == "-auto" ]; then
		./rasp_opencv_dependency.sh $*
	fi
done
