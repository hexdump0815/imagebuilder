if [ "$1" = "amlogic_m8" ]; then
  rm -f ${DOWNLOAD_DIR}/kernel-amlogic_m8-armv7l.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-amlogic-kernel/releases/download/${amlogic_m8_release_version}/${amlogic_m8_release_version}.tar.gz -O ${DOWNLOAD_DIR}/kernel-amlogic_m8-armv7l.tar.gz
fi
