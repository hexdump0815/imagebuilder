# this file is supposed to be sourced by the get-files shell script

rm -f ${DOWNLOAD_DIR}/kernel-chromebook_snow-armv7l.tar.gz
wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/releases/download/${chromebook_snow_release_version}/${chromebook_snow_release_version}.tar.gz -O ${DOWNLOAD_DIR}/kernel-chromebook_snow-armv7l.tar.gz
rm -f ${DOWNLOAD_DIR}/boot-chromebook_snow-armv7l.dd
# we assemble the bootblocks from a prepared chromebook partition table and the proper u-boot kpart image
cp files/chromebook-boot/cb.dd-single-part ${DOWNLOAD_DIR}/boot-chromebook_snow-armv7l.dd
wget -v https://github.com/hexdump0815/u-boot-chainloading-for-arm-chromebooks/releases/download/${chromebook_snow_uboot_version}/uboot.kpart.cbe.gz -O - | gunzip -c >> ${DOWNLOAD_DIR}/boot-chromebook_snow-armv7l.dd
