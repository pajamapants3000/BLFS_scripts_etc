#!/bin/bash -ev
# Install script for avbin
# Libraries used by pyglet for encoded a/v
# May have to enter password, will have to accept aggreement
wget https://github.com/downloads/AVbin/AVbin/install-avbin-linux-x86-64-v10
chmod +x install-avbin-linux-x86-64-v10
sudo ./install-avbin-linux-x86-64-v10
rm install-avbin-linux-x86-64-v10
