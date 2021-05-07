# this file is supposed to be sourced by the get-files shell script

chromebook_peach_release_version="5.10.27-stb-cbp%2B"
chromebook_peach_uboot_version="v2017.09-cbp"
chromebook_peach_mali_blob_version="4b25cd43f7aa853f35b17033b713d46e785c11cd"
gl4es_focal_armv7l_version="9051dfe1f2198e2ed41c322359ee8324043d55a9"

rm -f ${DOWNLOAD_DIR}/kernel-chromebook_peach-armv7l.tar.gz
wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/releases/download/${chromebook_peach_release_version}/${chromebook_peach_release_version}.tar.gz -O ${DOWNLOAD_DIR}/kernel-chromebook_peach-armv7l.tar.gz

rm -f ${DOWNLOAD_DIR}/kernel-mali-chromebook_peach-armv7l.tar.gz
wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/releases/download/${chromebook_peach_release_version}/${chromebook_peach_release_version}-mali-exynos5250.tar.gz -O ${DOWNLOAD_DIR}/kernel-mali-chromebook_peach-armv7l.tar.gz

rm -f ${DOWNLOAD_DIR}/boot-chromebook_peach-armv7l.dd
wget -v https://github.com/hexdump0815/u-boot-chainloading-for-arm-chromebooks/releases/download/${chromebook_peach_uboot_version}/uboot.kpart.cbe-peach.gz -O - | gunzip -c > ${DOWNLOAD_DIR}/boot-chromebook_peach-armv7l.dd

rm -f ${DOWNLOAD_DIR}/opengl-chromebook_peach-armv7l.tar.gz
wget -v https://github.com/hexdump0815/linux-mainline-and-mali-exynos5422-kernel/raw/${chromebook_peach_mali_blob_version}/misc.e54/opt-mali-exynos5422-armv7l.tar.gz -O ${DOWNLOAD_DIR}/opengl-chromebook_peach-armv7l.tar.gz
rm -f ${DOWNLOAD_DIR}/opengl-fbdev-chromebook_peach-armv7l.tar.gz
wget -v https://github.com/hexdump0815/linux-mainline-and-mali-exynos5422-kernel/raw/${chromebook_peach_mali_blob_version}/misc.e54/opt-mali-exynos5422-fbdev-armv7l.tar.gz -O ${DOWNLOAD_DIR}/opengl-fbdev-chromebook_peach-armv7l.tar.gz
rm -f ${DOWNLOAD_DIR}/opengl-wayland-chromebook_peach-armv7l.tar.gz
wget -v https://github.com/hexdump0815/linux-mainline-and-mali-exynos5422-kernel/raw/${chromebook_peach_mali_blob_version}/misc.e54/opt-mali-exynos5422-wayland-armv7l.tar.gz -O ${DOWNLOAD_DIR}/opengl-wayland-chromebook_peach-armv7l.tar.gz

rm -f ${DOWNLOAD_DIR}/gl4es-armv7l-focal.tar.gz
wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/raw/${gl4es_focal_armv7l_version}/misc/gl4es-armv7l-ubuntu.tar.gz -O ${DOWNLOAD_DIR}/gl4es-armv7l-focal.tar.gz
