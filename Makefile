# Copyright 2020 Alex Woroschilow (alex.woroschilow@gmail.com)
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
PWD:=$(shell pwd)

all: clean
	mkdir --parents $(PWD)/build
	mkdir --parents $(PWD)/build/AppDir

	wget --output-document=$(PWD)/build/Buka.AppImage https://github.com/oguzhaninan/Buka/releases/download/v1.0.0/Buka-1.0.0-x86_64.AppImage
	xorriso -indev $(PWD)/build/Buka.AppImage -osirrox on -extract / $(PWD)/build/AppDir

	
	wget --output-document=$(PWD)/build/build.rpm http://mirror.centos.org/centos/8/AppStream/x86_64/os/Packages/gtk2-2.24.32-4.el8.x86_64.rpm
	cd $(PWD)/build && rpm2cpio $(PWD)/build/build.rpm | cpio -idmv && cd ..

	wget --output-document=$(PWD)/build/build.rpm http://mirror.centos.org/centos/8/AppStream/x86_64/os/Packages/GConf2-3.2.6-22.el8.x86_64.rpm
	cd $(PWD)/build && rpm2cpio $(PWD)/build/build.rpm | cpio -idmv && cd ..

	wget --output-document=$(PWD)/build/build.rpm http://mirror.centos.org/centos/7/os/x86_64/Packages/pango-1.42.4-4.el7_7.x86_64.rpm
	cd $(PWD)/build && rpm2cpio $(PWD)/build/build.rpm | cpio -idmv && cd ..

	rm -f $(PWD)/build/AppDir/AppRun
	rm -f $(PWD)/build/AppDir/AppRun/*.desktop
	cp --force --recursive $(PWD)/build/usr/lib64/* $(PWD)/build/AppDir/usr/lib
	cp --force --recursive $(PWD)/build/usr/share/* $(PWD)/build/AppDir/usr/share
	cp --force --recursive $(PWD)/AppDir/* $(PWD)/build/AppDir

	chmod +x $(PWD)/build/AppDir/AppRun
	chmod +x $(PWD)/build/AppDir/usr/bin/buka

	export ARCH=x86_64 && $(PWD)/bin/appimagetool.AppImage $(PWD)/build/AppDir $(PWD)/Buka.AppImage
	chmod +x $(PWD)/Buka.AppImage

clean:
	rm -rf $(PWD)/build
