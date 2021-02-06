# this file is supposed to be sourced by the get-files shell script

rm -f ${DOWNLOAD_DIR}/kernel-amlogic_gx-aarch64.tar.gz
wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/releases/download/${amlogic_gx_release_version}/${amlogic_gx_release_version}.tar.gz -O ${DOWNLOAD_DIR}/kernel-amlogic_gx-aarch64.tar.gz
#rm -f ${DOWNLOAD_DIR}/kernel-mali-amlogic_gx-aarch64.tar.gz
#wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/releases/download/${amlogic_gx_release_version}/${amlogic_gx_release_version}-mali-s905.tar.gz -O ${DOWNLOAD_DIR}/kernel-mali-amlogic_gx-aarch64.tar.gz
rm -f ${DOWNLOAD_DIR}/boot-amlogic_gx-aarch64.dd
wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/raw/${amlogic_gx_generic_tree_tag}/misc.av8/u-boot/boot-odroid_c2-aarch64.dd -O ${DOWNLOAD_DIR}/boot-amlogic_gx-aarch64.dd
