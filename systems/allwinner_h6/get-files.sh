if [ "$1" = "allwinner_h6" ]; then
  rm -f ${DOWNLOAD_DIR}/kernel-allwinner_h6-aarch64.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-allwinner-h3-h6-kernel/releases/download/${allwinner_h6_release_version}/${allwinner_h6_release_version}.tar.gz -O ${DOWNLOAD_DIR}/kernel-allwinner_h6-aarch64.tar.gz
#  rm -f ${DOWNLOAD_DIR}/kernel-mali-allwinner_h6-aarch64.tar.gz
#  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-allwinner-h3-h6-kernel/releases/download/${allwinner_h6_release_version}/${allwinner_h6_release_version}-mali-h6.tar.gz -O ${DOWNLOAD_DIR}/kernel-mali-allwinner_h6-aarch64.tar.gz
  rm -f ${DOWNLOAD_DIR}/boot-allwinner_h6-aarch64.dd
  wget -v https://github.com/hexdump0815/u-boot-misc/releases/download/${allwinner_h6_uboot_version}/boot-allwinner_h6-aarch64.dd.gz -O - | gunzip -c >> ${DOWNLOAD_DIR}/boot-allwinner_h6-aarch64.dd
fi
