# this file is supposed to be sourced by the get-files shell script

chromebook_cherry_release_version="6.1.0-cos-mt9%2B"

rm -f ${DOWNLOAD_DIR}/kernel-chromebook_cherry-${2}.tar.gz
wget -v https://github.com/hexdump0815/linux-chromeos-kernel/releases/download/${chromebook_cherry_release_version}/${chromebook_cherry_release_version}.tar.gz -O ${DOWNLOAD_DIR}/kernel-chromebook_cherry-${2}.tar.gz

( cd ${DOWNLOAD_DIR} ; tar xzf kernel-chromebook_cherry-${2}.tar.gz boot ; mv boot/vmlinux.kpart-* boot-chromebook_cherry-${2}.dd ; rm -rf boot )
