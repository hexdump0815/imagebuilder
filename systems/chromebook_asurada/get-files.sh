# this file is supposed to be sourced by the get-files shell script

chromebook_asurada_release_version="6.12.15-stb-cbm%2B"

rm -f ${DOWNLOAD_DIR}/kernel-chromebook_asurada-${2}.tar.gz
wget -v https://github.com/hexdump0815/linux-mainline-mediatek-mt81xx-kernel/releases/download/${chromebook_asurada_release_version}/${chromebook_asurada_release_version}.tar.gz -O ${DOWNLOAD_DIR}/kernel-chromebook_asurada-${2}.tar.gz

( cd ${DOWNLOAD_DIR} ; tar xzf kernel-chromebook_asurada-${2}.tar.gz boot ; mv boot/vmlinux.kpart-* boot-chromebook_asurada-${2}.dd ; rm -rf boot )
