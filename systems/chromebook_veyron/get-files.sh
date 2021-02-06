if [ "$1" = "chromebook_veyron" ]; then
  rm -f ${DOWNLOAD_DIR}/kernel-chromebook_veyron-armv7l.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/releases/download/${chromebook_veyron_release_version}/${chromebook_veyron_release_version}.tar.gz -O ${DOWNLOAD_DIR}/kernel-chromebook_veyron-armv7l.tar.gz
  rm -f ${DOWNLOAD_DIR}/boot-chromebook_veyron-armv7l.dd
  # we assemble the bootblocks from a prepared chromebook partition table and the proper u-boot kpart image
  cp files/chromebook-boot/cb.dd-single-part ${DOWNLOAD_DIR}/boot-chromebook_veyron-armv7l.dd
  wget -v https://github.com/hexdump0815/u-boot-chainloading-for-arm-chromebooks/releases/download/${chromebook_veyron_uboot_version}/uboot.kpart.cbr.gz -O - | gunzip -c >> ${DOWNLOAD_DIR}/boot-chromebook_veyron-armv7l.dd
fi
