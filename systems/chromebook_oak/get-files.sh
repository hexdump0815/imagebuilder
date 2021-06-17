# this file is supposed to be sourced by the get-files shell script

chromebook_oak_release_version="5.10.25-stb-mt7%2B"

rm -f ${DOWNLOAD_DIR}/kernel-chromebook_oak-aarch64.tar.gz
wget -v https://github.com/hexdump0815/linux-mainline-mediatek-mt81xx-kernel/releases/download/${chromebook_oak_release_version}/${chromebook_oak_release_version}.tar.gz -O ${DOWNLOAD_DIR}/kernel-chromebook_oak-aarch64.tar.gz

# hack until there is a kernel package with the proper name
( cd ${DOWNLOAD_DIR} ; tar xzf kernel-chromebook_oak-aarch64.tar.gz boot ; mv boot/vmlinux.kpart-elm-* boot-chromebook_oak-aarch64.dd ; rm -rf boot )
#( cd ${DOWNLOAD_DIR} ; tar xzf kernel-chromebook_oak-aarch64.tar.gz boot ; mv boot/vmlinux.kpart-oak-* boot-chromebook_oak-aarch64.dd ; rm -rf boot )
