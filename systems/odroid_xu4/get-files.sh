# this file is supposed to be sourced by the get-files shell script

odroid_xu4_release_version="5.4.58-stb-e54%2B"
#odroid_xu4_release_version="5.10.25-stb-e54%2B"
odroid_xu4_uboot_version="200718-01"

rm -f ${DOWNLOAD_DIR}/kernel-odroid_xu4-armv7l.tar.gz
wget -v https://github.com/hexdump0815/linux-mainline-and-mali-exynos5422-kernel/releases/download/${odroid_xu4_release_version}/${odroid_xu4_release_version}.tar.gz -O ${DOWNLOAD_DIR}/kernel-odroid_xu4-armv7l.tar.gz
#wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-kernel/releases/download/${odroid_xu4_release_version}/${odroid_xu4_release_version}.tar.gz -O ${DOWNLOAD_DIR}/kernel-odroid_xu4-armv7l.tar.gz

rm -f ${DOWNLOAD_DIR}/boot-odroid_xu4-armv7l.dd
wget -v https://github.com/hexdump0815/u-boot-misc/releases/download/${odroid_xu4_uboot_version}/e54-boot.dd.gz -O - | gunzip -c >> ${DOWNLOAD_DIR}/boot-odroid_xu4-armv7l.dd
