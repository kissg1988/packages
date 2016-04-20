#!/bin/sh -eu

BUILDROOT="/home/nb/openwrt_build/openwrt_15.05.1"
OLDPWD=$(pwd)
cd "${BUILDROOT}"

trap "cd \"${OLDPWD}\"" INT

git pull
make distclean

./scripts/feeds update -a
./scripts/feeds install -a

cat > .config << EOF
CONFIG_TARGET_ar71xx=y
CONFIG_TARGET_ar71xx_nand=y
CONFIG_TARGET_ar71xx_nand_WNDR4300=y
#CONFIG_PACKAGE_nginx=m
#CONFIG_NGINX_SSL=y
#CONFIG_PACKAGE_seafile-server=m
#CONFIG_PACKAGE_seafile-seahub=m
#CONFIG_PACKAGE_seafile-ccnet=m
CONFIG_PACKAGE_vala=m
EOF

make defconfig
echo "Build has started, be patient....."
nice -n 19 make -j9 V=s > ${BUILDROOT}/build.log 2>&1
