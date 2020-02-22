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

`./rasp_opencv-remove_legacy.sh <you_want_opencv_version> -auto <dep_args>`<br>
<br>
After deletion, the transition will be made to the following script: rasp_opencv_dependency.sh<br>
`<dep_args>` is passed to next script. See the next section for details.<br>
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

When you input `-install` or `-auto`, You must specify the version as the first argument.<br>
Example, `./rasp_opencv_dependency.sh 4.1.2 -auto -py2 -py3 -qt5 -gl`<br>
All args is passed to last script.<br>
<br>
* rasp_opencv.sh<br>
Download, Install packages, Complie.<br>
If input `clean`, this script will clean up the files used for compilation.<br>
Example, This command `./rasp_opencv.sh 4.1.2 -py2 -py3 -qt5 -gl` is only installation.<br>
Command `./rasp_opencv.sh clean` is only clean up files.<br>
The `clean` cannot be used `-py2...-gtk3` together.
