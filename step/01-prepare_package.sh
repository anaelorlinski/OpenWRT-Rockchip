#!/bin/bash
clear

# remove other coremark
#rm -rf feeds/packages/utils/coremark
#rm -rf package/feeds/packages/coremark
./scripts/feeds update -a && ./scripts/feeds install -a

# Time stamp with $Build_Date=$(date +%Y.%m.%d)
echo -e '\nAO Build@'$(date "+%Y.%m.%d")'\n'  >> package/base-files/files/etc/banner
sed -i '/DISTRIB_REVISION/d' package/base-files/files/etc/openwrt_release
echo "DISTRIB_REVISION='$(date "+%Y.%m.%d")'" >> package/base-files/files/etc/openwrt_release
sed -i '/DISTRIB_DESCRIPTION/d' package/base-files/files/etc/openwrt_release
echo "DISTRIB_DESCRIPTION='AO Build@$(date "+%Y.%m.%d")'" >> package/base-files/files/etc/openwrt_release
sed -i '/luciversion/d' feeds/luci/modules/luci-base/luasrc/version.lua

rm -rf .config

exit 0
