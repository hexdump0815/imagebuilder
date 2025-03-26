# this file is supposed to be sourced by the get-files shell script

allwinner_h3_release_version="6.1.128-stb-av7%2B"
allwinner_a20_bpi_uboot_version="200718-01"
allwinner_h3_r39_uboot_version="200718-01"
allwinner_h3_tx1_uboot_version="200718-01"

rm -f ${DOWNLOAD_DIR}/kernel-allwinner_h3-armv7l.tar.gz
wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-kernel/releases/download/${allwinner_h3_release_version}/${allwinner_h3_release_version}.tar.gz -O ${DOWNLOAD_DIR}/kernel-allwinner_h3-armv7l.tar.gz

rm -f ${DOWNLOAD_DIR}/boot-allwinner_h3-armv7l.dd
wget -v https://github.com/hexdump0815/u-boot-misc/releases/download/${allwinner_a20_bpi_uboot_version}/bpi-boot.dd.gz -O - | gunzip -c > ${DOWNLOAD_DIR}/boot-allwinner_h3-armv7l.dd

# get different u-boot versions for different systems to have them around
rm -rf ${DOWNLOAD_DIR}/boot-extra-${1}
mkdir -p ${DOWNLOAD_DIR}/boot-extra-${1}
cp ${DOWNLOAD_DIR}/boot-allwinner_h3-${2}.dd ${DOWNLOAD_DIR}/boot-extra-${1}/boot-allwinner-a20-bpi.dd
wget -v https://github.com/hexdump0815/u-boot-misc/releases/download/${allwinner_h3_r39_uboot_version}/r39-boot.dd.gz -O - | gunzip -c > ${DOWNLOAD_DIR}/boot-extra-${1}/boot-allwinner-h3-r39.dd
wget -v https://github.com/hexdump0815/u-boot-misc/releases/download/${allwinner_h3_tx1_uboot_version}/tx1-boot.dd.gz -O - | gunzip -c > ${DOWNLOAD_DIR}/boot-extra-${1}/boot-allwinner-h3-tx1.dd
