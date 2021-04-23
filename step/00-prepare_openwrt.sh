#!/bin/bash
clear
#Update feed
# ao : go back to std distrib
#sed -i '4s/src-git/#src-git/g' ./feeds.conf.default
#sed -i '5s/src-git/#src-git/g' ./feeds.conf.default
#echo 'src-git addon https://github.com/quintus-lab/openwrt-package' >> ./feeds.conf.default
./scripts/feeds update -a && ./scripts/feeds install -a

#patch jsonc
patch -p1 < ../patches/0000-use_json_object_new_int64.patch
#Add upx-ucl support
patch -p1 < ../patches/0001-tools-add-upx-ucl-support.patch
#add hwrng patch
patch -p1 < ../patches/0002-rockchip-rngd.patch

# add R4S support
patch -p1 < ../patches/0003-new_rockchip_support_k54.patch
patch -p1 < ../patches/0007-optimize_for_rk3399.patch

# add AES and GCM with ARMv8 Crypto support
patch -p1 < ../patches/0008-mbedtls-Implements-AES-and-GCM-with-ARMv8-Crypto-Ext.patch
# rockchip: add support for OrangePi R1 Plus
patch -p1 < ../patches/0009-rockchip-add-support-for-OrangePi-R1-Plus.patch
# rockchip: add drm and lima gpu driver
patch -p1 < ../patches/0011-rockchip-add-drm-and-lima-gpu-driver.patch

#dnsmasq aaaa filter
#AO dont need this
#patch -p1 < ../patches/1001-dnsmasq_add_filter_aaaa_option.patch
#cp -f ../patches/910-mini-ttl.patch package/network/services/dnsmasq/patches/
#cp -f ../patches/911-dnsmasq-filter-aaaa.patch package/network/services/dnsmasq/patches/

#test 8152 patch
cp -f ../patches/993-board-nanopi-r2s-r8152-customise-leds.patch target/linux/rockchip/patches-5.4/
cp -f ../patches/994-board-nanopi-r2s-r8152-mac-from-dt.patch target/linux/rockchip/patches-5.4/

#update curl
#rm -rf ./package/network/utils/curl
#svn co https://github.com/openwrt/openwrt/branches/openwrt-19.07/package/network/utils/curl package/network/utils/curl

#Add r8168-8.048.03 realtek driver
git clone https://github.com/BROBIRD/openwrt-r8168 package/new/r8168

#Max connection limite
#sed -i 's/16384/65536/g' package/kernel/linux/files/sysctl-nf-conntrack.conf

exit 0
