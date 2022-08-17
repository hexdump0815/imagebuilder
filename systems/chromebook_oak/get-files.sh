# this file is supposed to be sourced by the get-files shell script

chromebook_oak_release_version="5.19.1-stb-mt7%2B"
chromebook_oak_oldrelease_version="5.10.99-stb-mt7%2B"
mesa_release_version="22.1.1"

rm -f ${DOWNLOAD_DIR}/kernel-chromebook_oak-${2}.tar.gz
wget -v https://github.com/hexdump0815/linux-mainline-mediatek-mt81xx-kernel/releases/download/${chromebook_oak_release_version}/${chromebook_oak_release_version}.tar.gz -O ${DOWNLOAD_DIR}/kernel-chromebook_oak-${2}.tar.gz

( cd ${DOWNLOAD_DIR} ; tar xzf kernel-chromebook_oak-${2}.tar.gz boot ; mv boot/vmlinux.kpart-* boot-chromebook_oak-${2}.dd ; rm -rf boot )

# get the self built fresher mesa - not enabled for now
#wget https://github.com/hexdump0815/mesa-etc-build/releases/download/${mesa_release_version}/opt-mesa-${mesa_release_version}-${3}-${2}.tar.gz -O ${DOWNLOAD_DIR}/opt-mesa-${3}-${2}.tar.gz

# put an alternative v5.10 kernel to /boot/extra as it at least had working dpms supsend
rm -rf ${DOWNLOAD_DIR}/boot-extra-${1}
mkdir -p ${DOWNLOAD_DIR}/boot-extra-${1}
wget -v https://github.com/hexdump0815/linux-mainline-mediatek-mt81xx-kernel/releases/download/${chromebook_oak_oldrelease_version}/${chromebook_oak_oldrelease_version}.tar.gz -O ${DOWNLOAD_DIR}/boot-extra-${1}/kernel-chromebook_oak-v5.10.tar.gz
