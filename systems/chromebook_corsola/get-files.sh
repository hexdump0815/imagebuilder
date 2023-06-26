# this file is supposed to be sourced by the get-files shell script

# use a chromeos based kernel until mainline starts to be useable
chromebook_corsola_chromeos_release_version="5.15.108-col-114%2B"

rm -f ${DOWNLOAD_DIR}/kernel-chromebook_corsola-${2}.tar.gz
wget -v https://github.com/hexdump0815/linux-chromeos-kernel/releases/download/${chromebook_corsola_chromeos_release_version}/${chromebook_corsola_chromeos_release_version}.tar.gz -O ${DOWNLOAD_DIR}/kernel-chromebook_corsola-${2}.tar.gz

( cd ${DOWNLOAD_DIR} ; tar xzf kernel-chromebook_corsola-${2}.tar.gz boot ; mv boot/vmlinux.kpart-* boot-chromebook_corsola-${2}.dd ; rm -rf boot )
