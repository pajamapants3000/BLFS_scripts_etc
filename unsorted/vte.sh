#!/bin/bash -ev
wget http://ftp.gnome.org/pub/gnome/sources/vte/0.28/vte-0.28.2.tar.xz
tar -xf vte-0.28.2.tar.xz
cd vte-0.28.2
./configure --prefix=/usr \
            --libexecdir=/usr/lib/vte \
            --disable-static
make
sudo make install
cd ..
rm -rf vte-0.28.2
rm vte-0.28.2.tar.xz
