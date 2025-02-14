# this file is supposed to be sourced by the get-files shell script

orbsmart_s92_beelink_r89_release_version="6.12.12-stb-av7%2B"

rm -f ${DOWNLOAD_DIR}/kernel-orbsmart_s92_beelink_r89-armv7l.tar.gz
wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/releases/download/${orbsmart_s92_beelink_r89_release_version}/${orbsmart_s92_beelink_r89_release_version}.tar.gz -O ${DOWNLOAD_DIR}/kernel-orbsmart_s92_beelink_r89-armv7l.tar.gz
