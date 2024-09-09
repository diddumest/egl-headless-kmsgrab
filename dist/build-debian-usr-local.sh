#! /bin/bash

cmake -B build -S . -DCMAKE_INSTALL_PREFIX=/usr/local \
        -DCMAKE_INSTALL_LIBDIR=lib \
        -DCMAKE_INSTALL_DATADIR=/share \
        -DCMAKE_BUILD_TYPE=Release
make -C build

CFLAGS="-m32 ${CFLAGS}" CXXFLAGS="-m32 ${CXXFLAGS}" LDFLAGS="-m32 ${LDFLAGS}" cmake -B build32 -S . -DCMAKE_INSTALL_PREFIX=/usr/local \
	-DCMAKE_INSTALL_LIBDIR=lib/i686-linux-gnu \
	-DCMAKE_INSTALL_DATADIR=/share \
	-DCMAKE_LIBRARY_PATH=/usr/local/lib/i686-linux-gnu \
	-DCMAKE_BUILD_TYPE=Release \
	-DBUILD_PLUGIN=OFF
make -C build32

sudo checkinstall --default --pkgname=obs-studio-local-vkcapture --fstrans=no --backup=no --pkgversion="$(date +%Y%m%d)" --deldoc=yes sh -c 'make -C build install; make -C build32 install'

