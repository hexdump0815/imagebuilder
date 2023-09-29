# this file is supposed to be sourced by the get-files shell script

# use a chromeos based kernel until mainline starts to be useable
chromebook_asurada_chromeos_release_version="6.1.0-cos-mt9%2B"
# this will be required when panfrost starts to get useable
#mesa_release_version="22.1.1"

rm -f ${DOWNLOAD_DIR}/kernel-chromebook_asurada-${2}.tar.gz
wget -v https://github.com/hexdump0815/linux-chromeos-kernel/releases/download/${chromebook_asurada_chromeos_release_version}/${chromebook_asurada_chromeos_release_version}.tar.gz -O ${DOWNLOAD_DIR}/kernel-chromebook_asurada-${2}.tar.gz

( cd ${DOWNLOAD_DIR} ; tar xzf kernel-chromebook_asurada-${2}.tar.gz boot ; mv boot/vmlinux.kpart-* boot-chromebook_asurada-${2}.dd ; rm -rf boot )
