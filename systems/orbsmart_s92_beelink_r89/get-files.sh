if [ "$1" = "orbsmart_s92_beelink_r89" ]; then
  rm -f ${DOWNLOAD_DIR}/kernel-orbsmart_s92_beelink_r89-armv7l.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/releases/download/${orbsmart_s92_beelink_r89_release_version}/${orbsmart_s92_beelink_r89_release_version}.tar.gz -O ${DOWNLOAD_DIR}/kernel-orbsmart_s92_beelink_r89-armv7l.tar.gz
#  rm -f ${DOWNLOAD_DIR}/kernel-mali-orbsmart_s92_beelink_r89-armv7l.tar.gz
#  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/releases/download/${orbsmart_s92_beelink_r89_release_version}/${orbsmart_s92_beelink_r89_release_version}-mali-rk3288.tar.gz -O ${DOWNLOAD_DIR}/kernel-mali-orbsmart_s92_beelink_r89-armv7l.tar.gz
fi
