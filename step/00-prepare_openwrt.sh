#!/bin/bash
clear
#Update feed
./scripts/feeds update -a && ./scripts/feeds install -a

#patch jsonc
patch -p1 < ../patches/0000-use_json_object_new_int64.patch
#Add upx-ucl support
patch -p1 < ../patches/0001-tools-add-upx-ucl-support.patch



#Add r8168-8.048.03 realtek driver
git clone https://github.com/BROBIRD/openwrt-r8168 package/new/r8168

#Max connection limite
#sed -i 's/16384/65536/g' package/kernel/linux/files/sysctl-nf-conntrack.conf

exit 0
