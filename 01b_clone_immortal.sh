#!/bin/bash

IMMORTAL_FOLDER=immortal-fresh
git clone -b openwrt-21.02 --single-branch https://github.com/immortalwrt/immortalwrt.git $IMMORTAL_FOLDER
cd $IMMORTAL_FOLDER
git log -1

