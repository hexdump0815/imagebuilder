# this file is supposed to be sourced by the get-files shell script

chromebook_elm_release_version="5.10.20-stb-mt7%2B"

rm -f ${DOWNLOAD_DIR}/kernel-chromebook_elm-aarch64.tar.gz
wget -v https://github.com/hexdump0815/linux-mainline-mediatek-mt81xx-kernel/releases/download/${chromebook_elm_release_version}/${chromebook_elm_release_version}.tar.gz -O ${DOWNLOAD_DIR}/kernel-chromebook_elm-aarch64.tar.gz

( cd ${DOWNLOAD_DIR} ; tar xzf kernel-chromebook_elm-aarch64.tar.gz boot ; mv boot/vmlinux.kpart-elm-* boot-chromebook_elm-aarch64.dd ; rm -rf boot )
