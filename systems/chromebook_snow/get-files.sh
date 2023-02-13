# this file is supposed to be sourced by the get-files shell script

chromebook_snow_release_version="6.1.11-stb-cbe%2B"
chromebook_snow_uboot_version="v2017.09-cbe"
chromebook_snow_alternative_uboot_version="v2018.11-cbe"
chromebook_snow_mali_blob_version="9051dfe1f2198e2ed41c322359ee8324043d55a9"
gl4es_focal_armv7l_version="9051dfe1f2198e2ed41c322359ee8324043d55a9"

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

rm -f ${DOWNLOAD_DIR}/opengl-chromebook_snow-armv7l.tar.gz
wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/raw/${chromebook_snow_mali_blob_version}/misc/opt-mali-exynos5250-armv7l.tar.gz -O ${DOWNLOAD_DIR}/opengl-chromebook_snow-armv7l.tar.gz
rm -f ${DOWNLOAD_DIR}/opengl-fbdev-chromebook_snow-armv7l.tar.gz
wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/raw/${chromebook_snow_mali_blob_version}/misc/opt-mali-exynos5250-fbdev-r5p0-armv7l.tar.gz -O ${DOWNLOAD_DIR}/opengl-fbdev-chromebook_snow-armv7l.tar.gz

rm -f ${DOWNLOAD_DIR}/gl4es-armv7l-focal.tar.gz
wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/raw/${gl4es_focal_armv7l_version}/misc/gl4es-armv7l-ubuntu.tar.gz -O ${DOWNLOAD_DIR}/gl4es-armv7l-focal.tar.gz
