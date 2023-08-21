#!/bin/bash
shopt -s extglob

make defconfig
svn co https://github.com/coolsnowwolf/lede/trunk/target/linux/ipq60xx target/linux/ipq60xx

svn co https://github.com/coolsnowwolf/lede/trunk/package/qca package/qca

rm -rf package/kernel/{qca-nss-dp,qca-ssdk}

sed -i "s/CONFIG_ALL_NONSHARED=y/CONFIG_ALL_NONSHARED=n/" .config
make defconfig
sed -i "s/# CONFIG_ALL_NONSHARED is not set/CONFIG_ALL_NONSHARED=y/" .config


