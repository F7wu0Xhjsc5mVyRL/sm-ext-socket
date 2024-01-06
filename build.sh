#!/bin/bash

rm -rf build

mkdir build
cd build
python3 ../configure.py --sm-path /opt/sourcemod/ --boost-path /opt/boost/ --enable-optimize 1
ambuild

exit
