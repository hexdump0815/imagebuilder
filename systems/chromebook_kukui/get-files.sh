# this file is supposed to be sourced by the get-files shell script

chromebook_kukui_release_version="5.10.25-stb-cbm%2B"

rm -f ${DOWNLOAD_DIR}/kernel-chromebook_kukui-${2}.tar.gz
wget -v https://github.com/hexdump0815/linux-mainline-mediatek-mt81xx-kernel/releases/download/${chromebook_kukui_release_version}/${chromebook_kukui_release_version}.tar.gz -O ${DOWNLOAD_DIR}/kernel-chromebook_kukui-${2}.tar.gz

# hack until there is a kernel package with the proper name
( cd ${DOWNLOAD_DIR} ; tar xzf kernel-chromebook_kukui-${2}.tar.gz boot ; mv boot/vmlinux.kpart-krane-* boot-chromebook_kukui-${2}.dd ; rm -rf boot )
#( cd ${DOWNLOAD_DIR} ; tar xzf kernel-chromebook_kukui-${2}.tar.gz boot ; mv boot/vmlinux.kpart-kukui-* boot-chromebook_kukui-${2}.dd ; rm -rf boot )
