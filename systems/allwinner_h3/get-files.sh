# this file is supposed to be sourced by the get-files shell script

allwinner_h3_release_version="5.10.3-stb-av7%2B"
allwinner_h3_uboot_version="200718-01"

rm -f ${DOWNLOAD_DIR}/kernel-allwinner_h3-armv7l.tar.gz
wget -v https://github.com/hexdump0815/linux-mainline-and-mali-allwinner-h3-h6-kernel/releases/download/${allwinner_h3_release_version}/${allwinner_h3_release_version}.tar.gz -O ${DOWNLOAD_DIR}/kernel-allwinner_h3-armv7l.tar.gz

#rm -f ${DOWNLOAD_DIR}/kernel-mali-allwinner_h3-armv7l.tar.gz
#wget -v https://github.com/hexdump0815/linux-mainline-and-mali-allwinner-h3-h6-kernel/releases/download/${allwinner_h3_release_version}/${allwinner_h3_release_version}-mali-sunxi.tar.gz -O ${DOWNLOAD_DIR}/kernel-mali-allwinner_h3-armv7l.tar.gz

rm -f ${DOWNLOAD_DIR}/boot-allwinner_h3-armv7l.dd
wget -v https://github.com/hexdump0815/u-boot-misc/releases/download/${allwinner_h3_uboot_version}/r39-boot.dd.gz -O - | gunzip -c >> ${DOWNLOAD_DIR}/boot-allwinner_h3-armv7l.dd
