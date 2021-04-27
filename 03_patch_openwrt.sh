#!/bin/bash
ROOTDIR=$(pwd)
#cp -R openwrt-fresh openwrt
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

# r8168 driver
cp -R $ROOTDIR/immortal-fresh/package/kernel/r8168 package/kernel/

# r8152 driver from realtek
#cp -R $ROOTDIR/immortal-fresh/package/kernel/r8152 package/kernel/

# r8152 driver from friendlywrt for kernel 5.4
# add extra patch to update r8152 driver to v.1.11.11
# note : driver 2.13 and 2.14 seem unstable from this thread
# https://forum.armbian.com/topic/15165-nanopi-r2s-lan0-goes-offline-with-high-traffic/
# the patch idea is taken from https://github.com/friendlyarm/kernel-rockchip/blob/nanopi-r2-v5.4.y-opp1/drivers/net/usb/r8152.c
# I just add a backport ov v1.11.11 instead
cp ../kernel_patches-5.4/001-r8152-v1-11-11.patch target/linux/rockchip/patches-5.4/

# copy extra patch from immortalwrt
cp $ROOTDIR/immortal-fresh/package/libs/mbedtls/patches/100-Implements-AES-and-GCM-with-ARMv8-Crypto-Extensions.patch \
   package/libs/mbedtls/patches/

# remove patches that make kernel panic
#rm target/linux/rockchip/patches-5.4/007*  
rm target/linux/rockchip/patches-5.4/008*       # kernel oops, remove !!!!      # do not forget to run 03.sh !!!!!!!
#rm target/linux/rockchip/patches-5.4/201*                                      # then make target/linux/clean   
#rm target/linux/rockchip/patches-5.4/803*  
#rm target/linux/rockchip/patches-5.4/804*  
rm target/linux/rockchip/patches-5.4/805*       # kernel oops, remove !!!
#rm target/linux/rockchip/patches-5.4/806*
#rm target/linux/rockchip/patches-5.4/807*
#rm target/linux/rockchip/patches-5.4/808*
rm target/linux/rockchip/patches-5.4/9*
#rm target/linux/rockchip/patches-5.4/992*  #only for r4s, to test

# enable watchdog
sed -i 's/# CONFIG_WATCHDOG is not set/CONFIG_WATCHDOG=y/' target/linux/rockchip/armv8/config-5.4
sed -i '/CONFIG_WATCHDOG=y/a CONFIG_DW_WATCHDOG=y' target/linux/rockchip/armv8/config-5.4
cp ../kernel_patches-5.4/995-watchdog-rk3328.patch target/linux/rockchip/patches-5.4/
cp ../kernel_patches-5.4/996-watchdog-rk3399.patch target/linux/rockchip/patches-5.4/

# enable PHY usb3 for r2s
sed -i 's/# CONFIG_PHY_ROCKCHIP_INNO_USB3 is not set/CONFIG_PHY_ROCKCHIP_INNO_USB3=y/' target/linux/rockchip/armv8/config-5.4

# enable crypto
cat ../patches/0002-kernel-crypto.addon >> target/linux/rockchip/armv8/config-5.4


