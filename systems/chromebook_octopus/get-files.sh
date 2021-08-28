# this file is supposed to be sourced by the get-files shell script

chromebook_octopus_release_version="4.14.228-cos-r91+"

rm -f ${DOWNLOAD_DIR}/kernel-chromebook_octopus-${2}.tar.gz
wget -v https://github.com/hexdump0815/linux-chromeos-kernel/releases/download/${chromebook_octopus_release_version}/${chromebook_octopus_release_version}.tar.gz -O ${DOWNLOAD_DIR}/kernel-chromebook_octopus-${2}.tar.gz

( cd ${DOWNLOAD_DIR} ; tar xzf kernel-chromebook_octopus-${2}.tar.gz boot ; mv boot/vmlinux.kpart-* boot-chromebook_octopus-${2}.dd ; rm -rf boot )
