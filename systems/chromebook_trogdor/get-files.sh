# this file is supposed to be sourced by the get-files shell script

chromebook_trogdor_release_version="6.1.51-stb-cbq"
mesa_release_version="22.1.1"

rm -f ${DOWNLOAD_DIR}/kernel-chromebook_trogdor-${2}.tar.gz
wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/releases/download/${chromebook_trogdor_release_version}/${chromebook_trogdor_release_version}.tar.gz -O ${DOWNLOAD_DIR}/kernel-chromebook_trogdor-${2}.tar.gz

( cd ${DOWNLOAD_DIR} ; tar xzf kernel-chromebook_trogdor-${2}.tar.gz boot ; mv boot/vmlinux.kpart-* boot-chromebook_trogdor-${2}.dd ; rm -rf boot )
