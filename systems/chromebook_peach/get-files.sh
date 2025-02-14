# this file is supposed to be sourced by the get-files shell script

chromebook_peach_release_version="6.12.12-stb-cbp%2B"
chromebook_peach_pit_uboot_version="v2018.11-cbe"
chromebook_peach_pi_uboot_version="v2018.11-cbe"

rm -f ${DOWNLOAD_DIR}/kernel-chromebook_peach-armv7l.tar.gz
wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/releases/download/${chromebook_peach_release_version}/${chromebook_peach_release_version}.tar.gz -O ${DOWNLOAD_DIR}/kernel-chromebook_peach-armv7l.tar.gz

rm -f ${DOWNLOAD_DIR}/boot-chromebook_peach-armv7l.dd
wget -v https://github.com/hexdump0815/u-boot-chainloading-for-arm-chromebooks/releases/download/${chromebook_peach_pit_uboot_version}/uboot.kpart.cbe-peach-pit.gz -O - | gunzip -c > ${DOWNLOAD_DIR}/boot-chromebook_peach-armv7l.dd

# get different u-boot versions for different exynos5250 chromebook versions to have them around
rm -rf ${DOWNLOAD_DIR}/boot-extra-${1}
mkdir -p ${DOWNLOAD_DIR}/boot-extra-${1}
cp ${DOWNLOAD_DIR}/boot-chromebook_peach-armv7l.dd ${DOWNLOAD_DIR}/boot-extra-${1}/uboot.kpart.cbe-peach-pit
wget -v https://github.com/hexdump0815/u-boot-chainloading-for-arm-chromebooks/releases/download/${chromebook_peach_pi_uboot_version}/uboot.kpart.cbe-peach-pi.gz -O - | gunzip -c > ${DOWNLOAD_DIR}/boot-extra-${1}/uboot.kpart.cbe-peach-pi
