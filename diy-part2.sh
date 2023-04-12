#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
#
# Modify default IP
sed -i 's/192.168.1.1/192.168.3.1/g' package/base-files/files/bin/config_generate

#  Add date to the compiled firmware file name 
date=`date +%m.%d`
date1=`date +%h`
sed -i "s/DISTRIB_DESCRIPTION.*/DISTRIB_DESCRIPTION=\'Openwrt\'/g" package/base-files/files/etc/openwrt_release
sed -i "s/DISTRIB_REVISION.*/DISTRIB_REVISION=\'$date\'/g" package/base-files/files/etc/openwrt_release
sed -i "s/DISTRIB_RELEASE.*/DISTRIB_RELEASE=\'$date1\'/g" package/base-files/files/etc/openwrt_release
sed -i "s/IMG_PREFIX:=$(VERSION_DIST_SANITIZED)=\"IMG_PREFIX:=$(shell date +%m-%d)-$(VERSION_DIST_SANITIZED)'\"/g" include/image.mk
#  Add date to the compiled firmware file name 
#sed -i 's/IMG_PREFIX:=$(VERSION_DIST_SANITIZED)/IMG_PREFIX:=$(shell TZ=Europe/Stockholm date "+%Y%m%d")-$(VERSION_DIST_SANITIZED)/g' include/image.mk


# Set Default Wireless SSID (AX3600)
sed -i 's/wireless.default_radio${devidx}.ssid=OpenWrt/wireless.default_radio${devidx}.ssid=AX3600/g' package/kernel/mac80211/files/lib/wifi/mac80211.sh

# upgrade all
curl -k -L 'https://raw.githubusercontent.com/tavinus/opkg-upgrade/master/opkg-upgrade.sh' -o "/usr/sbin/opkg-upgrade" && chmod 755 "/usr/sbin/opkg-upgrade"

#  Modify the number of connections 
sed -i '/customized in this file/a net.netfilter.nf_conntrack_max=165535' package/base-files/files/etc/sysctl.conf

# modify the plugin location 
sed -i '/sed -i "s\/services\/system\/g" \/usr\/lib\/lua\/luci\/controller\/cpufreq.lua/d'  package/lean/default-settings/files/zzz-default-settings
sed -i '/exit 0/i sed -i "s/services/system/g" /usr/lib/lua/luci/controller/cpufreq.lua'  package/lean/default-settings/files/zzz-default-settings

#themes  add (svn co command meaning: specified version such as https://github) 
#git clone https://github.com/xiaoqingfengATGH/luci-theme-infinityfreedom package/luci-theme-infinityfreedom
#git clone https://github.com/Leo-Jo-My/luci-theme-opentomcat.git package/luci-theme-opentomcat
#git clone https://github.com/openwrt-develop/luci-theme-atmaterial.git package/luci-theme-atmaterial
#git clone https://github.com/sirpdboy/luci-theme-opentopd.git package/luci-theme-opentopd
# Add luci-theme-argon
#git clone --depth=1 https://github.com/jerrykuku/luci-theme-argon package/luci-theme-argon 
#git clone --depth=1 https://github.com/jerrykuku/luci-app-argon-config package/luci-app-argon-config

#Add  additional non-essential packages 
#git clone https://github.com/rufengsuixing/luci-app-adguardhome.git package/luci-app-adguardhome 
#git clone https://github.com/garypang13/luci-app-bypass package/luci-app-bypass
