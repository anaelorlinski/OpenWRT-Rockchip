#!/bin/bash
ROOTDIR=$(pwd)
cp -R openwrt-fresh openwrt
cd openwrt

# replace target rockchip with immortalwrt one
rm -rf target/linux/rockchip
cp -R $ROOTDIR/immortal-fresh/target/linux/rockchip target/linux/

# replace uboot with immortal one
rm -rf package/boot/uboot-rockchip
cp -R $ROOTDIR/immortal-fresh/package/boot/uboot-rockchip package/boot/

# arm trusted firmware
rm -rf package/boot/arm-trusted-firmware-rk3328
rm -rf package/boot/arm-trusted-firmware-rockchip
cp -R $ROOTDIR/immortal-fresh/package/boot/arm-trusted-firmware-rk3328 package/boot/
cp -R $ROOTDIR/immortal-fresh/package/boot/arm-trusted-firmware-rockchip package/boot/

# new video module dependancy for rockchip drm
rm -f package/kernel/linux/modules/video.mk
cp -R $ROOTDIR/immortal-fresh/package/kernel/linux/modules/video.mk package/kernel/linux/modules/

# copy extra patch from immortalwrt
cp $ROOTDIR/immortal-fresh/package/libs/mbedtls/patches/100-Implements-AES-and-GCM-with-ARMv8-Crypto-Extensions.patch \
   package/libs/mbedtls/patches/
