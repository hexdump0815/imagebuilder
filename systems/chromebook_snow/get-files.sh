# this file is supposed to be sourced by the get-files shell script

chromebook_snow_release_version="6.12.12-stb-cbe%2B"
chromebook_snow_uboot_version="v2017.09-cbe"
chromebook_snow_alternative_uboot_version="v2018.11-cbe"

rm -rf ${DOWNLOAD_DIR}/boot-extra-${1}
mkdir -p ${DOWNLOAD_DIR}/boot-extra-${1}
# get different u-boot versions for different exynos5250 chromebook versions
wget -v https://github.com/hexdump0815/u-boot-chainloading-for-arm-chromebooks/releases/download/${chromebook_snow_uboot_version}/uboot.kpart.cbe-snow.gz -O - | gunzip -c > ${DOWNLOAD_DIR}/boot-extra-${1}/uboot.kpart.cbe-snow
wget -v https://github.com/hexdump0815/u-boot-chainloading-for-arm-chromebooks/releases/download/${chromebook_snow_alternative_uboot_version}/uboot.kpart.cbe.gz -O - | gunzip -c > ${DOWNLOAD_DIR}/boot-extra-${1}/uboot.kpart.cbe-snow-alternative
# copy the snow u-boot to the right place, so that it will be written to the kernel partition
cp ${DOWNLOAD_DIR}/boot-extra-${1}/uboot.kpart.cbe-snow ${DOWNLOAD_DIR}/boot-chromebook_snow-armv7l.dd

# get the mainline kernel
rm -f ${DOWNLOAD_DIR}/kernel-chromebook_snow-armv7l.tar.gz
wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/releases/download/${chromebook_snow_release_version}/${chromebook_snow_release_version}.tar.gz -O ${DOWNLOAD_DIR}/kernel-chromebook_snow-armv7l.tar.gz
