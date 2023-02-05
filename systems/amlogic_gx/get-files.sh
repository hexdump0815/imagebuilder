# this file is supposed to be sourced by the get-files shell script

amlogic_gx_release_version="6.1.0-stb-av8%2B"
amlogic_gx_generic_tree_tag=${generic_tree_tag}
amlogic_gx_gxb_uboot_version="200718-01"
amlogic_gx_gxb_serial_uboot_version="200718-01"
amlogic_gx_gxl_uboot_version="200718-01"
amlogic_gx_gxl_serial_uboot_version="200718-01"
amlogic_gx_gxm_uboot_version="200926-01"
amlogic_gx_g12a_uboot_version="200926-01"
amlogic_gx_g12a_serial_uboot_version="200926-01"
amlogic_gx_sm1_uboot_version="200926-01"
amlogic_gx_sm1_serial_uboot_version="200926-01"
mesa_release_version="22.1.1"

rm -f ${DOWNLOAD_DIR}/kernel-amlogic_gx-${2}.tar.gz
wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/releases/download/${amlogic_gx_release_version}/${amlogic_gx_release_version}.tar.gz -O ${DOWNLOAD_DIR}/kernel-amlogic_gx-${2}.tar.gz

#rm -f ${DOWNLOAD_DIR}/kernel-mali-amlogic_gx-${2}.tar.gz
#wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/releases/download/${amlogic_gx_release_version}/${amlogic_gx_release_version}-mali-s905.tar.gz -O ${DOWNLOAD_DIR}/kernel-mali-amlogic_gx-${2}.tar.gz

rm -f ${DOWNLOAD_DIR}/boot-amlogic_gx-${2}.dd
wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/raw/${amlogic_gx_generic_tree_tag}/misc.av8/u-boot/boot-odroid_c2-aarch64.dd -O ${DOWNLOAD_DIR}/boot-amlogic_gx-${2}.dd

# get different u-boot versions for different amlogic versions to have them around
rm -rf ${DOWNLOAD_DIR}/boot-extra-${1}
mkdir -p ${DOWNLOAD_DIR}/boot-extra-${1}
cp ${DOWNLOAD_DIR}/boot-amlogic_gx-${2}.dd ${DOWNLOAD_DIR}/boot-extra-${1}/boot-amlogic-gxb-odroid-c2.dd
wget -v https://github.com/hexdump0815/u-boot-misc/releases/download/${amlogic_gx_gxb_uboot_version}/boot-amlogic_gxb_atf-aarch64.dd.gz -O - | gunzip -c > ${DOWNLOAD_DIR}/boot-extra-${1}/boot-amlogic-gxb-atf-tv-box.dd
wget -v https://github.com/hexdump0815/u-boot-misc/releases/download/${amlogic_gx_gxb_uboot_version}/gxb-u-boot.bin.gz -O - | gunzip -c > ${DOWNLOAD_DIR}/boot-extra-${1}/gxb-tv-box-u-boot.bin
wget -v https://github.com/hexdump0815/u-boot-misc/releases/download/${amlogic_gx_gxb_serial_uboot_version}/boot-amlogic_gxb_atf-aarch64-serial.dd.gz -O - | gunzip -c > ${DOWNLOAD_DIR}/boot-extra-${1}/boot-amlogic-gxb-atf-tv-box-serial.dd
wget -v https://github.com/hexdump0815/u-boot-misc/releases/download/${amlogic_gx_gxb_serial_uboot_version}/gxb-u-boot.bin-serial.gz -O - | gunzip -c > ${DOWNLOAD_DIR}/boot-extra-${1}/gxb-serial-tv-box-u-boot.bin
wget -v https://github.com/hexdump0815/u-boot-misc/releases/download/${amlogic_gx_gxl_uboot_version}/boot-amlogic_gxl_atf-aarch64-a95x-r2.dd.gz -O - | gunzip -c > ${DOWNLOAD_DIR}/boot-extra-${1}/boot-amlogic-gxl-atf-tv-box.dd
wget -v https://github.com/hexdump0815/u-boot-misc/releases/download/${amlogic_gx_gxl_uboot_version}/gxl-u-boot.bin.gz -O - | gunzip -c > ${DOWNLOAD_DIR}/boot-extra-${1}/gxl-tv-box-u-boot.bin
wget -v https://github.com/hexdump0815/u-boot-misc/releases/download/${amlogic_gx_gxl_serial_uboot_version}/boot-amlogic_gxl_atf-aarch64-a95x-r2-serial.dd.gz -O - | gunzip -c > ${DOWNLOAD_DIR}/boot-extra-${1}/boot-amlogic-gxl-atf-tv-box-serial.dd
wget -v https://github.com/hexdump0815/u-boot-misc/releases/download/${amlogic_gx_gxl_serial_uboot_version}/gxl-u-boot.bin-serial.gz -O - | gunzip -c > ${DOWNLOAD_DIR}/boot-extra-${1}/gxl-serial-tv-box-u-boot.bin
wget -v https://github.com/hexdump0815/u-boot-misc/releases/download/${amlogic_gx_gxm_uboot_version}/boot-amlogic_gxm-aarch64-nexbox-a1.dd.gz -O - | gunzip -c > ${DOWNLOAD_DIR}/boot-extra-${1}/boot-amlogic-gxm-tv-box.dd
wget -v https://github.com/hexdump0815/u-boot-misc/releases/download/${amlogic_gx_gxm_uboot_version}/gxm-u-boot.bin.gz -O - | gunzip -c > ${DOWNLOAD_DIR}/boot-extra-${1}/gxm-tv-box-u-boot.bin
wget -v https://github.com/hexdump0815/u-boot-misc/releases/download/${amlogic_gx_g12a_uboot_version}/boot-amlogic_g12a_atf-aarch64-x96-max.dd.gz -O - | gunzip -c > ${DOWNLOAD_DIR}/boot-extra-${1}/boot-amlogic-g12a-atf-tv-box.dd
wget -v https://github.com/hexdump0815/u-boot-misc/releases/download/${amlogic_gx_g12a_uboot_version}/g12a-u-boot.bin.gz -O - | gunzip -c > ${DOWNLOAD_DIR}/boot-extra-${1}/g12a-tv-box-u-boot.bin
wget -v https://github.com/hexdump0815/u-boot-misc/releases/download/${amlogic_gx_g12a_serial_uboot_version}/boot-amlogic_g12a_atf-aarch64-x96-max-serial.dd.gz -O - | gunzip -c > ${DOWNLOAD_DIR}/boot-extra-${1}/boot-amlogic-g12a-atf-tv-box-serial.dd
wget -v https://github.com/hexdump0815/u-boot-misc/releases/download/${amlogic_gx_g12a_serial_uboot_version}/g12a-serial-u-boot.bin.gz -O - | gunzip -c > ${DOWNLOAD_DIR}/boot-extra-${1}/g12a-serial-tv-box-u-boot.bin
wget -v https://github.com/hexdump0815/u-boot-misc/releases/download/${amlogic_gx_sm1_uboot_version}/boot-amlogic_sm1-aarch64-x96-air.dd.gz -O - | gunzip -c > ${DOWNLOAD_DIR}/boot-extra-${1}/boot-amlogic-sm1-tv-box.dd
wget -v https://github.com/hexdump0815/u-boot-misc/releases/download/${amlogic_gx_sm1_uboot_version}/sm1-u-boot.bin.gz -O - | gunzip -c > ${DOWNLOAD_DIR}/boot-extra-${1}/sm1-tv-box-u-boot.bin
wget -v https://github.com/hexdump0815/u-boot-misc/releases/download/${amlogic_gx_sm1_serial_uboot_version}/boot-amlogic_sm1-aarch64-x96-air-serial.dd.gz -O - | gunzip -c > ${DOWNLOAD_DIR}/boot-extra-${1}/boot-amlogic-sm1-tv-box-serial.dd
wget -v https://github.com/hexdump0815/u-boot-misc/releases/download/${amlogic_gx_sm1_serial_uboot_version}/sm1-serial-u-boot.bin.gz -O - | gunzip -c > ${DOWNLOAD_DIR}/boot-extra-${1}/sm1-serial-tv-box-u-boot.bin

# get the self built fresher mesa
if [ "${3}" != "bookworm" ]; then
  wget https://github.com/hexdump0815/mesa-etc-build/releases/download/${mesa_release_version}/opt-mesa-${mesa_release_version}-${3}-${2}.tar.gz -O ${DOWNLOAD_DIR}/opt-mesa-${3}-${2}.tar.gz
fi
