# this file is supposed to be sourced by the get-files shell script

raspberry_pi_2_release_version="5.10.25-stb-av7%2B"
raspberry_pi_2_uboot_version="201216-01"

rm -f ${DOWNLOAD_DIR}/kernel-raspberry_pi-armv7l.tar.gz
wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/releases/download/${raspberry_pi_2_release_version}/${raspberry_pi_2_release_version}.tar.gz -O ${DOWNLOAD_DIR}/kernel-raspberry_pi_2-armv7l.tar.gz

rm -rf ${DOWNLOAD_DIR}/boot-extra-${1}
mkdir -p ${DOWNLOAD_DIR}/boot-extra-${1}
wget -v https://github.com/hexdump0815/u-boot-misc/releases/download/${raspberry_pi_3_uboot_version}/rpi_2-u-boot.bin.gz -O - | gunzip -c > ${DOWNLOAD_DIR}/boot-extra-${1}/rpi_2-u-boot.bin
