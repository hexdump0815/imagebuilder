# this file is supposed to be sourced by the get-files shell script

orbsmart_s92_beelink_r89_release_version="5.15.22-stb-av7%2B"
mesa_release_version="22.1.0"

rm -f ${DOWNLOAD_DIR}/kernel-orbsmart_s92_beelink_r89-armv7l.tar.gz
wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/releases/download/${orbsmart_s92_beelink_r89_release_version}/${orbsmart_s92_beelink_r89_release_version}.tar.gz -O ${DOWNLOAD_DIR}/kernel-orbsmart_s92_beelink_r89-armv7l.tar.gz

#rm -f ${DOWNLOAD_DIR}/kernel-mali-orbsmart_s92_beelink_r89-armv7l.tar.gz
#wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/releases/download/${orbsmart_s92_beelink_r89_release_version}/${orbsmart_s92_beelink_r89_release_version}-mali-rk3288.tar.gz -O ${DOWNLOAD_DIR}/kernel-mali-orbsmart_s92_beelink_r89-armv7l.tar.gz

# get the self built fresher mesa
wget https://github.com/hexdump0815/mesa-etc-build/releases/download/${mesa_release_version}/opt-mesa-${mesa_release_version}-${3}-${2}.tar.gz -O ${DOWNLOAD_DIR}/opt-mesa-${3}-${2}.tar.gz
