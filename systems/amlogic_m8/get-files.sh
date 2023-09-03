# this file is supposed to be sourced by the get-files shell script

amlogic_m8_release_version="6.1.51-stb-m8x%2B"
amlogic_m8_generic_tree_tag=${generic_tree_tag}

rm -f ${DOWNLOAD_DIR}/kernel-amlogic_m8-armv7l.tar.gz
wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-kernel/releases/download/${amlogic_m8_release_version}/${amlogic_m8_release_version}.tar.gz -O ${DOWNLOAD_DIR}/kernel-amlogic_m8-armv7l.tar.gz
