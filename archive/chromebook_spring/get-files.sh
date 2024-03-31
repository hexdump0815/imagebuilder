# this file is supposed to be sourced by the get-files shell script

chromebook_spring_legacy_release_version="3.10.38-cos-r91"
chromebook_spring_uboot_version="v2018.11-cbe"
chromebook_spring_mali_blob_version="9051dfe1f2198e2ed41c322359ee8324043d55a9"

rm -f ${DOWNLOAD_DIR}/kernel-chromebook_spring-armv7l.tar.gz
wget -v https://github.com/hexdump0815/linux-chromeos-kernel/releases/download/${chromebook_spring_legacy_release_version}/${chromebook_spring_legacy_release_version}.tar.gz -O ${DOWNLOAD_DIR}/kernel-chromebook_spring-armv7l.tar.gz

# extract the cros kpart image from the kernel tar.gz to use it for the cros kernel partition
( cd ${DOWNLOAD_DIR} && tar xzf kernel-chromebook_spring-armv7l.tar.gz boot/vmlinux.kpart-${chromebook_spring_legacy_release_version} && mv boot/vmlinux.kpart-${chromebook_spring_legacy_release_version} boot-chromebook_spring-armv7l.dd && rmdir boot )

# get mainline u-boot for spring - not properly working yet, but maybe good to have around
rm -rf ${DOWNLOAD_DIR}/boot-extra-${1}
mkdir -p ${DOWNLOAD_DIR}/boot-extra-${1}
wget -v https://github.com/hexdump0815/u-boot-chainloading-for-arm-chromebooks/releases/download/${chromebook_spring_uboot_version}/uboot.kpart.cbe-spring.gz -O - | gunzip -c > ${DOWNLOAD_DIR}/boot-extra-${1}/uboot.kpart.cbe-spring

rm -f ${DOWNLOAD_DIR}/opengl-chromebook_spring-armv7l.tar.gz
wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/raw/${chromebook_spring_mali_blob_version}/misc/opt-mali-exynos5250-armv7l.tar.gz -O ${DOWNLOAD_DIR}/opengl-chromebook_spring-armv7l.tar.gz
rm -f ${DOWNLOAD_DIR}/opengl-fbdev-chromebook_spring-armv7l.tar.gz
wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/raw/${chromebook_spring_mali_blob_version}/misc/opt-mali-exynos5250-fbdev-r5p0-armv7l.tar.gz -O ${DOWNLOAD_DIR}/opengl-fbdev-chromebook_spring-armv7l.tar.gz
