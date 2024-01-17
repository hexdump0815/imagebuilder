# this file is supposed to be sourced by the get-files shell script

chromebook_nyan_release_version="6.6.9-stb-cbt%2B"
chromebook_nyan_kernel_tree="linux-mainline-and-mali-generic-stable-kernel"
chromebook_nyan_2g_uboot_version="v2021.10-cbt"
chromebook_nyan_2g_noflicker_uboot_version="v2021.10-cbt"
chromebook_nyan_4g_uboot_version="v2021.10-cbt"
chromebook_nyan_4g_noflicker_uboot_version="v2021.10-cbt"

rm -rf ${DOWNLOAD_DIR}/boot-extra-${1}
mkdir -p ${DOWNLOAD_DIR}/boot-extra-${1}
# get different u-boot versions for different nyan chromebook versions
wget -v https://github.com/hexdump0815/u-boot-chainloading-for-arm-chromebooks/releases/download/${chromebook_nyan_2g_uboot_version}/uboot.kpart.cbt-2g.gz -O - | gunzip -c > ${DOWNLOAD_DIR}/boot-extra-${1}/uboot.kpart.cbt-2g
wget -v https://github.com/hexdump0815/u-boot-chainloading-for-arm-chromebooks/releases/download/${chromebook_nyan_2g_noflicker_uboot_version}/uboot.kpart.cbt-2g-noflicker.gz -O - | gunzip -c > ${DOWNLOAD_DIR}/boot-extra-${1}/uboot.kpart.cbt-2g-noflicker
wget -v https://github.com/hexdump0815/u-boot-chainloading-for-arm-chromebooks/releases/download/${chromebook_nyan_4g_uboot_version}/uboot.kpart.cbt-4g.gz -O - | gunzip -c > ${DOWNLOAD_DIR}/boot-extra-${1}/uboot.kpart.cbt-4g
wget -v https://github.com/hexdump0815/u-boot-chainloading-for-arm-chromebooks/releases/download/${chromebook_nyan_4g_noflicker_uboot_version}/uboot.kpart.cbt-4g-noflicker.gz -O - | gunzip -c > ${DOWNLOAD_DIR}/boot-extra-${1}/uboot.kpart.cbt-4g-noflicker
# copy the 4gb nyan u-boot to the right place, so that it will be written to the kernel partition
cp ${DOWNLOAD_DIR}/boot-extra-${1}/uboot.kpart.cbt-4g ${DOWNLOAD_DIR}/boot-chromebook_nyan-armv7l.dd

# get the mainline kernel
rm -f ${DOWNLOAD_DIR}/kernel-chromebook_nyan-armv7l.tar.gz
wget -v https://github.com/hexdump0815/${chromebook_nyan_kernel_tree}/releases/download/${chromebook_nyan_release_version}/${chromebook_nyan_release_version}.tar.gz -O ${DOWNLOAD_DIR}/kernel-chromebook_nyan-armv7l.tar.gz
