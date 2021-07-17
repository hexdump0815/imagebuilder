# this file is supposed to be sourced by the get-files shell script

raspberry_pi_3_release_version="5.10.45-stb-av8%2B"
raspberry_pi_3_uboot_version="210429-01"
mesa_release_version="21.0.1"

rm -f ${DOWNLOAD_DIR}/kernel-raspberry_pi-${2}.tar.gz
wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/releases/download/${raspberry_pi_3_release_version}/${raspberry_pi_3_release_version}.tar.gz -O ${DOWNLOAD_DIR}/kernel-raspberry_pi_3-${2}.tar.gz

rm -rf ${DOWNLOAD_DIR}/boot-extra-${1}
mkdir -p ${DOWNLOAD_DIR}/boot-extra-${1}
wget -v https://github.com/hexdump0815/u-boot-misc/releases/download/${raspberry_pi_3_uboot_version}/rpi_3-u-boot.bin.gz -O - | gunzip -c > ${DOWNLOAD_DIR}/boot-extra-${1}/rpi_3-u-boot.bin
wget -v https://github.com/hexdump0815/u-boot-misc/releases/download/${raspberry_pi_3_uboot_version}/rpi_3_plus-u-boot.bin.gz -O - | gunzip -c > ${DOWNLOAD_DIR}/boot-extra-${1}/rpi_3_plus-u-boot.bin

# get the self built fresher mesa
wget https://github.com/hexdump0815/mesa-etc-build/releases/download/${mesa_release_version}/opt-mesa-${mesa_release_version}-${3}-${2}.tar.gz -O ${DOWNLOAD_DIR}/opt-mesa-${3}-${2}.tar.gz
