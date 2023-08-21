#!/bin/bash
shopt -s extglob

SHELL_FOLDER=$(dirname $(readlink -f "$0"))

make defconfig
svn co https://github.com/coolsnowwolf/lede/trunk/package/qca package/qca
rm -rf  package/kernel/{qca-nss-dp,qca-ssdk}

sed -i 's/DEFAULT_PACKAGES +=/DEFAULT_PACKAGES += kmod-qca-nss-dp kmod-qca-nss-drv-64 kmod-qca-nss-drv-pppoe-64 kmod-qca-nss-ecm-64 kmod-qca-nss-drv-bridge-mgr-64 kmod-qca-nss-drv-vlan-mgr-64 nss-firmware-ipq8074/' target/linux/ipq807x/Makefile
sed -i "s/CONFIG_ALL_NONSHARED=y/CONFIG_ALL_NONSHARED=n/" .config
make defconfig
sed -i "s/# CONFIG_ALL_NONSHARED is not set/CONFIG_ALL_NONSHARED=y/" .config

sh -c "curl -sfL https://github.com/robimarko/openwrt/commit/23fa931934151f72c1655ffa62ff1a979575f07e.patch | patch -d './' -p1 --forward"

sed -i '/rm -rf $(KDIR)\/tmp/d' include/image.mk

rm -rf feeds/kiddin9/{rtl8821cu,rtl88x2bu} package/kernel/mt76 devices/common/patches/mt7922.patch
