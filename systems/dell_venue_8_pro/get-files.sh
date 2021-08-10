# this file is supposed to be sourced by the get-files shell script

dell_venue_8_pro_release_version="5.10.1-stb-d8p+"

rm -f ${DOWNLOAD_DIR}/kernel-dell_venue_8_pro-${2}.tar.gz
wget -v https://github.com/hexdump0815/linux-mainline-x86-64-kernel/releases/download/${dell_venue_8_pro_release_version}/${dell_venue_8_pro_release_version}.tar.gz -O ${DOWNLOAD_DIR}/kernel-dell_venue_8_pro-${2}.tar.gz
