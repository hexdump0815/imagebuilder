# this file is supposed to be sourced by the get-files shell script

aarch64_mbr_uefi_release_version="6.12.12-stb-av8%2B"
aarch64_mbr_uefi_gxl_uboot_version="250629-01"
aarch64_mbr_uefi_gxm_uboot_version="250629-01"

rm -f ${DOWNLOAD_DIR}/kernel-aarch64_mbr_uefi-${2}.tar.gz
wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/releases/download/${aarch64_mbr_uefi_release_version}/${aarch64_mbr_uefi_release_version}.tar.gz -O ${DOWNLOAD_DIR}/kernel-aarch64_mbr_uefi-${2}.tar.gz

# get different u-boot versions for different amlogic versions to have them around
rm -rf ${DOWNLOAD_DIR}/boot-extra-${1}
mkdir -p ${DOWNLOAD_DIR}/boot-extra-${1}
wget -v https://github.com/hexdump0815/u-boot-misc/releases/download/${aarch64_mbr_uefi_gxl_uboot_version}/gxl-tv-box-u-boot.bin.gz -O - | gunzip -c > ${DOWNLOAD_DIR}/boot-extra-${1}/gxl-tv-box-u-boot.bin
wget -v https://github.com/hexdump0815/u-boot-misc/releases/download/${aarch64_mbr_uefi_gxl_uboot_version}/boot-amlogic_gxl_a95x-r2-atf-aarch64.dd.gz -O - | gunzip -c > ${DOWNLOAD_DIR}/boot-extra-${1}/boot-amlogic_gxl_a95x-r2-atf-aarch64.dd
wget -v https://github.com/hexdump0815/u-boot-misc/releases/download/${aarch64_mbr_uefi_gxl_uboot_version}/boot-amlogic_gxl_libre-bl2-atf-aarch64.dd.gz -O - | gunzip -c > ${DOWNLOAD_DIR}/boot-extra-${1}/boot-amlogic_gxl_libre-bl2-atf-aarch64.dd
wget -v https://github.com/hexdump0815/u-boot-misc/releases/download/${aarch64_mbr_uefi_gxm_uboot_version}/gxm-tv-box-u-boot.bin.gz -O - | gunzip -c > ${DOWNLOAD_DIR}/boot-extra-${1}/gxm-tv-box-u-boot.bin
wget -v https://github.com/hexdump0815/u-boot-misc/releases/download/${aarch64_mbr_uefi_gxm_uboot_version}/boot-amlogic_gxm_nexbox-a1-aarch64.dd.gz -O - | gunzip -c > ${DOWNLOAD_DIR}/boot-extra-${1}/boot-amlogic_gxm_nexbox-a1-aarch64.dd

# use gxl bootblock as default
cp -v ${DOWNLOAD_DIR}/boot-extra-${1}/boot-amlogic_gxl_a95x-r2-atf-aarch64.dd ${DOWNLOAD_DIR}/boot-aarch64_mbr_uefi-${2}.dd
