#! /bin/bash

if [ $1 == "clean" ]; then
	cd ${HOME}
	rm -rf ${HOME}/opencv4
	cd $(dirname $(realpath $0))
else
	mkdir ${HOME}/opencv4
	cd ${HOME}/opencv4

	wget -O opencv.zip https://github.com/opencv/opencv/archive/${1}.zip
	wget -O opencv_contrib.zip https://github.com/opencv/opencv_contrib/archive/${1}.zip

	unzip opencv.zip
	unzip opencv_contrib.zip

	cd opencv-${1}
	mkdir build
	cd build

	QT_BOOL="OFF"
	GL_BOOL="OFF"
	PY_BOOL="OFF"

	for i in "$@"; do
		if [ $i == "-qt4" ] || [ $i == "-qt5" ]; then
			QT_BOOL="ON"
		elif [ $i == "-gl" ]; then
			GL_BOOL="ON"
		elif [ $i == "-py2" ] || [ $i == "-py3" ]; then
			PY_BOOL="ON"
		fi
	done

	cmake -D CMAKE_BUILD_TYPE=RELEASE -D CMAKE_INSTALL_PREFIX=/usr/local -D WITH_TBB=OFF -D WITH_IPP=OFF \
	-D WITH_1394=OFF -D BUILD_WITH_DEBUG_INFO=OFF -D BUILD_DOCS=OFF -D INSTALL_C_EXAMPLES=ON \
	-D BUILD_EXAMPLES=OFF -D BUILD_TESTS=OFF -D BUILD_PERF_TESTS=OFF \
	-D WITH_GTK=ON -D OPENCV_EXTRA_MODULES_PATH=../../opencv_contrib-${1}/modules \
	-D WITH_V4L=ON  -D WITH_FFMPEG=ON -D WITH_XINE=ON -D BUILD_NEW_PYTHON_SUPPORT=${PY_BOOL} \
	-D OPENCV_GENERATE_PKGCONFIG=ON -D WITH_QT=${QT_BOOL} -D WITH_OPENGL=${GL_BOOL} -D INSTALL_PYTHON_EXAMPLES=${PY_BOOL} ../

	#스왑늘리는 기능 추가해야 함
	echo "---> increasing swap mem size"
	sudo sed -i 's/CONF_SWAPSIZE=100/CONF_SWAPSIZE=2048/g' /etc/dphys-swapfile
	sudo /etc/init.d/dphys-swapfile stop
	sudo /etc/init.d/dphys-swapfile start

	CORE=$(cat /proc/cpuinfo | grep processor | wc -l)
	make -j${CORE}

	sudo make install
	LD_LIB_PATH=$(cat /etc/ld.so.conf.d/* | grep /usr/local/lib$)

	if [ "$LD_LIB_PATH" != "/usr/local/lib" ]; then
		sudo sh -c 'echo '/usr/local/lib' > /etc/ld.so.conf.d/opencv.conf'
	fi

	sudo ldconfig

	echo "---> resetting swap mem size"
	sudo sed -i 's/CONF_SWAPSIZE=1024/CONF_SWAPSIZE=100/g' /etc/dphys-swapfile
	sudo /etc/init.d/dphys-swapfile stop
	sudo /etc/init.d/dphys-swapfile start
fi
