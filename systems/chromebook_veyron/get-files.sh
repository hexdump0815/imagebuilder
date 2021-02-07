# this file is supposed to be sourced by the get-files shell script

chromebook_veyron_release_version="5.10.3-stb-cbr%2B"
chromebook_veyron_jerry_uboot_version="v2017.09-cbr"
chromebook_veyron_speedy_uboot_version="v2021.01-cbr"

rm -f ${DOWNLOAD_DIR}/kernel-chromebook_veyron-armv7l.tar.gz
wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/releases/download/${chromebook_veyron_release_version}/${chromebook_veyron_release_version}.tar.gz -O ${DOWNLOAD_DIR}/kernel-chromebook_veyron-armv7l.tar.gz

rm -f ${DOWNLOAD_DIR}/boot-chromebook_veyron-armv7l.dd
# we assemble the bootblocks from a prepared chromebook partition table and the proper u-boot kpart image
cp files/chromebook-boot/cb.dd-single-part ${DOWNLOAD_DIR}/boot-chromebook_veyron-armv7l.dd
wget -v https://github.com/hexdump0815/u-boot-chainloading-for-arm-chromebooks/releases/download/${chromebook_veyron_jerry_uboot_version}/uboot.kpart.cbr.gz -O - | gunzip -c >> ${DOWNLOAD_DIR}/boot-chromebook_veyron-armv7l.dd

# get different u-boot versions for different veyron versions to have them around
mkdir -p ${DOWNLOAD_DIR}/boot-extra
wget -v https://github.com/hexdump0815/u-boot-chainloading-for-arm-chromebooks/releases/download/${chromebook_veyron_jerry_uboot_version}/uboot.kpart.cbr.gz -O - | gunzip -c > ${DOWNLOAD_DIR}/boot-extra/uboot.kpart.cbr-jerry
wget -v https://github.com/hexdump0815/u-boot-chainloading-for-arm-chromebooks/releases/download/${chromebook_veyron_speedy_uboot_version}/uboot.kpart.cbr-speedy.gz -O - | gunzip -c > ${DOWNLOAD_DIR}/boot-extra/uboot.kpart.cbr-speedy
