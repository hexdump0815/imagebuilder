# this file is supposed to be sourced by the get-files shell script

odroid_xu4_release_version="5.4.58-stb-e54%2B"
#odroid_xu4_release_version="5.10.25-stb-e54%2B"
odroid_xu4_uboot_version="200718-01"
odroid_xu4_mali_blob_version="4b25cd43f7aa853f35b17033b713d46e785c11cd"
gl4es_focal_armv7l_version="9051dfe1f2198e2ed41c322359ee8324043d55a9"

rm -f ${DOWNLOAD_DIR}/kernel-odroid_xu4-armv7l.tar.gz
wget -v https://github.com/hexdump0815/linux-mainline-and-mali-exynos5422-kernel/releases/download/${odroid_xu4_release_version}/${odroid_xu4_release_version}.tar.gz -O ${DOWNLOAD_DIR}/kernel-odroid_xu4-armv7l.tar.gz
#wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-kernel/releases/download/${odroid_xu4_release_version}/${odroid_xu4_release_version}.tar.gz -O ${DOWNLOAD_DIR}/kernel-odroid_xu4-armv7l.tar.gz

rm -f ${DOWNLOAD_DIR}/boot-odroid_xu4-armv7l.dd
wget -v https://github.com/hexdump0815/u-boot-misc/releases/download/${odroid_xu4_uboot_version}/e54-boot.dd.gz -O - | gunzip -c >> ${DOWNLOAD_DIR}/boot-odroid_xu4-armv7l.dd

rm -f ${DOWNLOAD_DIR}/opengl-odroid_xu4-armv7l.tar.gz
wget -v https://github.com/hexdump0815/linux-mainline-and-mali-exynos5422-kernel/raw/${odroid_xu4_mali_blob_version}/misc.e54/opt-mali-exynos5422-armv7l.tar.gz -O ${DOWNLOAD_DIR}/opengl-odroid_xu4-armv7l.tar.gz
rm -f ${DOWNLOAD_DIR}/opengl-fbdev-odroid_xu4-armv7l.tar.gz
wget -v https://github.com/hexdump0815/linux-mainline-and-mali-exynos5422-kernel/raw/${odroid_xu4_mali_blob_version}/misc.e54/opt-mali-exynos5422-fbdev-armv7l.tar.gz -O ${DOWNLOAD_DIR}/opengl-fbdev-odroid_xu4-armv7l.tar.gz
rm -f ${DOWNLOAD_DIR}/opengl-wayland-odroid_xu4-armv7l.tar.gz
wget -v https://github.com/hexdump0815/linux-mainline-and-mali-exynos5422-kernel/raw/${odroid_xu4_mali_blob_version}/misc.e54/opt-mali-exynos5422-wayland-armv7l.tar.gz -O ${DOWNLOAD_DIR}/opengl-wayland-odroid_xu4-armv7l.tar.gz

rm -f ${DOWNLOAD_DIR}/gl4es-armv7l-focal.tar.gz
wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/raw/${gl4es_focal_armv7l_version}/misc/gl4es-armv7l-ubuntu.tar.gz -O ${DOWNLOAD_DIR}/gl4es-armv7l-focal.tar.gz
