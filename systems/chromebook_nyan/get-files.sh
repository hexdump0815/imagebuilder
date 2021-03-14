# this file is supposed to be sourced by the get-files shell script

chromebook_nyan_release_version="5.4.84-stb-cbt%2B"
chromebook_nyan_uboot_version="v2018.11-cbt"

rm -f ${DOWNLOAD_DIR}/kernel-chromebook_nyan-armv7l.tar.gz
wget -v https://github.com/hexdump0815/linux-mainline-tegra-k1-kernel/releases/download/${chromebook_nyan_release_version}/${chromebook_nyan_release_version}.tar.gz -O ${DOWNLOAD_DIR}/kernel-chromebook_nyan-armv7l.tar.gz

rm -f ${DOWNLOAD_DIR}/boot-chromebook_nyan-armv7l.dd
wget -v https://github.com/hexdump0815/u-boot-chainloading-for-arm-chromebooks/releases/download/${chromebook_nyan_uboot_version}/uboot.kpart.cbt.gz -O - | gunzip -c > ${DOWNLOAD_DIR}/boot-chromebook_nyan-armv7l.dd
