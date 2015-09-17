#!/bin/bash -ev
wget http://launchpad.net/terminator/trunk/0.97/+download/terminator-0.97.tar.gz
tar -xf terminator-0.97.tar.gz
cd terminator-0.97
sudo ./setup.py install --record=${HOME}/terminator-0.97-install_files.txt
cd ..
rm -rf terminator-0.97
rm terminator-0.97.tar.gz
