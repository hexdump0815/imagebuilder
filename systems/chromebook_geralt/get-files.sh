# this file is supposed to be sourced by the get-files shell script

# use a chromeos based kernel until mainline starts to be useable
chromebook_geralt_chromeos_release_version="6.1.129-grt-137%2B"

rm -f ${DOWNLOAD_DIR}/kernel-chromebook_geralt-${2}.tar.gz
wget -v https://github.com/hexdump0815/linux-chromeos-kernel/releases/download/${chromebook_geralt_chromeos_release_version}/${chromebook_geralt_chromeos_release_version}.tar.gz -O ${DOWNLOAD_DIR}/kernel-chromebook_geralt-${2}.tar.gz

( cd ${DOWNLOAD_DIR} ; tar xzf kernel-chromebook_geralt-${2}.tar.gz boot ; mv boot/vmlinux.kpart-* boot-chromebook_geralt-${2}.dd ; rm -rf boot )
