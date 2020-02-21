# raspbian_opencv4

## What is this?

Opencv 4 automated installation script for Raspberry Pi.

## Usage

* rasp_opencv_remove_legacy.sh <br>
Delete old opencv.<br>
The auto option allows for automatic transition to the next step.

`./rasp_opencv_remove_legacy.sh`<br>
<br>
Only remove Legacy OpenCV.

`./rasp_opencv-remove_legacy.sh <you_want_opencv_version> -auto <dep_param>`<br>
<br>
After deletion, the transition will be made to the following script: rasp_opencv_dependency.sh<br>
<br>
* rasp_opencv_dependency.sh<br>
Install the dependency packages required for opencv4.<br>
You can use the following options:<br>
  1) -gtk3
  2) -qt4
  3) -qt5
  4) -gl
  5) -py2
  6) -py3
  7) -install
`-install` option is same `-auto`
