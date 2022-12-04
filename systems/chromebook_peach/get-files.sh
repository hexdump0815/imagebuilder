# this file is supposed to be sourced by the get-files shell script

chromebook_peach_release_version="5.18.1-stb-cbp%2B"
chromebook_peach_pit_uboot_version="v2018.11-cbe"
chromebook_peach_pi_uboot_version="v2018.11-cbe"
chromebook_peach_mali_blob_version="4b25cd43f7aa853f35b17033b713d46e785c11cd"
gl4es_focal_armv7l_version="9051dfe1f2198e2ed41c322359ee8324043d55a9"

rm -f ${DOWNLOAD_DIR}/kernel-chromebook_peach-armv7l.tar.gz
wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/releases/download/${chromebook_peach_release_version}/${chromebook_peach_release_version}.tar.gz -O ${DOWNLOAD_DIR}/kernel-chromebook_peach-armv7l.tar.gz

rm -f ${DOWNLOAD_DIR}/kernel-mali-chromebook_peach-armv7l.tar.gz
wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/releases/download/${chromebook_peach_release_version}/${chromebook_peach_release_version}-mali-exynos5420.tar.gz -O ${DOWNLOAD_DIR}/kernel-mali-chromebook_peach-armv7l.tar.gz

rm -f ${DOWNLOAD_DIR}/boot-chromebook_peach-armv7l.dd
wget -v https://github.com/hexdump0815/u-boot-chainloading-for-arm-chromebooks/releases/download/${chromebook_peach_pit_uboot_version}/uboot.kpart.cbe-peach-pit.gz -O - | gunzip -c > ${DOWNLOAD_DIR}/boot-chromebook_peach-armv7l.dd

# get different u-boot versions for different exynos5250 chromebook versions to have them around
rm -rf ${DOWNLOAD_DIR}/boot-extra-${1}
mkdir -p ${DOWNLOAD_DIR}/boot-extra-${1}
cp ${DOWNLOAD_DIR}/boot-chromebook_peach-armv7l.dd ${DOWNLOAD_DIR}/boot-extra-${1}/uboot.kpart.cbe-peach-pit
wget -v https://github.com/hexdump0815/u-boot-chainloading-for-arm-chromebooks/releases/download/${chromebook_peach_pi_uboot_version}/uboot.kpart.cbe-peach-pi.gz -O - | gunzip -c > ${DOWNLOAD_DIR}/boot-extra-${1}/uboot.kpart.cbe-peach-pi

rm -f ${DOWNLOAD_DIR}/opengl-chromebook_peach-armv7l.tar.gz
wget -v https://github.com/hexdump0815/linux-mainline-and-mali-exynos5422-kernel/raw/${chromebook_peach_mali_blob_version}/misc.e54/opt-mali-exynos5422-armv7l.tar.gz -O ${DOWNLOAD_DIR}/opengl-chromebook_peach-armv7l.tar.gz
rm -f ${DOWNLOAD_DIR}/opengl-fbdev-chromebook_peach-armv7l.tar.gz
wget -v https://github.com/hexdump0815/linux-mainline-and-mali-exynos5422-kernel/raw/${chromebook_peach_mali_blob_version}/misc.e54/opt-mali-exynos5422-fbdev-armv7l.tar.gz -O ${DOWNLOAD_DIR}/opengl-fbdev-chromebook_peach-armv7l.tar.gz
rm -f ${DOWNLOAD_DIR}/opengl-wayland-chromebook_peach-armv7l.tar.gz
wget -v https://github.com/hexdump0815/linux-mainline-and-mali-exynos5422-kernel/raw/${chromebook_peach_mali_blob_version}/misc.e54/opt-mali-exynos5422-wayland-armv7l.tar.gz -O ${DOWNLOAD_DIR}/opengl-wayland-chromebook_peach-armv7l.tar.gz

rm -f ${DOWNLOAD_DIR}/gl4es-armv7l-focal.tar.gz
wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/raw/${gl4es_focal_armv7l_version}/misc/gl4es-armv7l-ubuntu.tar.gz -O ${DOWNLOAD_DIR}/gl4es-armv7l-focal.tar.gz
