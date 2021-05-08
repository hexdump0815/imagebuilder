# this file is supposed to be sourced by the get-files shell script

chromebook_snow_release_version="5.10.25-stb-cbe%2B"
chromebook_snow_uboot_version="v2017.09-cbe"
chromebook_spring="v2018.11-cbe"
chromebook_snow_mali_blob_version="9051dfe1f2198e2ed41c322359ee8324043d55a9"
gl4es_focal_armv7l_version="9051dfe1f2198e2ed41c322359ee8324043d55a9"

rm -f ${DOWNLOAD_DIR}/kernel-chromebook_snow-armv7l.tar.gz
wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/releases/download/${chromebook_snow_release_version}/${chromebook_snow_release_version}.tar.gz -O ${DOWNLOAD_DIR}/kernel-chromebook_snow-armv7l.tar.gz

rm -f ${DOWNLOAD_DIR}/kernel-mali-chromebook_snow-armv7l.tar.gz
wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/releases/download/${chromebook_snow_release_version}/${chromebook_snow_release_version}-mali-exynos5250.tar.gz -O ${DOWNLOAD_DIR}/kernel-mali-chromebook_snow-armv7l.tar.gz

rm -f ${DOWNLOAD_DIR}/boot-chromebook_snow-armv7l.dd
wget -v https://github.com/hexdump0815/u-boot-chainloading-for-arm-chromebooks/releases/download/${chromebook_snow_uboot_version}/uboot.kpart.cbe-snow.gz -O - | gunzip -c > ${DOWNLOAD_DIR}/boot-chromebook_snow-armv7l.dd

# get different u-boot versions for different exynos5250 chromebook versions to have them around
rm -rf ${DOWNLOAD_DIR}/boot-extra-${1}
mkdir -p ${DOWNLOAD_DIR}/boot-extra-${1}
cp ${DOWNLOAD_DIR}/boot-chromebook_snow-armv7l.dd ${DOWNLOAD_DIR}/boot-extra-${1}/uboot.kpart.cbe-snow
wget -v https://github.com/hexdump0815/u-boot-chainloading-for-arm-chromebooks/releases/download/${chromebook_spring_uboot_version}/uboot.kpart.cbe-spring.gz -O - | gunzip -c > ${DOWNLOAD_DIR}/uboot.kpart.cbe-spring

rm -f ${DOWNLOAD_DIR}/opengl-chromebook_snow-armv7l.tar.gz
wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/raw/${chromebook_snow_mali_blob_version}/misc/opt-mali-exynos5250-armv7l.tar.gz -O ${DOWNLOAD_DIR}/opengl-chromebook_snow-armv7l.tar.gz
rm -f ${DOWNLOAD_DIR}/opengl-fbdev-chromebook_snow-armv7l.tar.gz
wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/raw/${chromebook_snow_mali_blob_version}/misc/opt-mali-exynos5250-fbdev-r5p0-armv7l.tar.gz -O ${DOWNLOAD_DIR}/opengl-fbdev-chromebook_snow-armv7l.tar.gz

rm -f ${DOWNLOAD_DIR}/gl4es-armv7l-focal.tar.gz
wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/raw/${gl4es_focal_armv7l_version}/misc/gl4es-armv7l-ubuntu.tar.gz -O ${DOWNLOAD_DIR}/gl4es-armv7l-focal.tar.gz
