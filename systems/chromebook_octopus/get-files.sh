# this file is supposed to be sourced by the get-files shell script

# this is for the legacy chromeos kernel
#chromebook_octopus_release_version="4.14.228-cos-r91+"
chromebook_octopus_release_version="5.15.2-stb-cbo"

rm -f ${DOWNLOAD_DIR}/kernel-chromebook_octopus-${2}.tar.gz
# this is for the legacy chromeos kernel
#wget -v https://github.com/hexdump0815/linux-chromeos-kernel/releases/download/${chromebook_octopus_release_version}/${chromebook_octopus_release_version}.tar.gz -O ${DOWNLOAD_DIR}/kernel-chromebook_octopus-${2}.tar.gz
wget -v https://github.com/hexdump0815/linux-mainline-x86-64-kernel/releases/download/${chromebook_octopus_release_version}/${chromebook_octopus_release_version}.tar.gz -O ${DOWNLOAD_DIR}/kernel-chromebook_octopus-${2}.tar.gz

( cd ${DOWNLOAD_DIR} ; tar xzf kernel-chromebook_octopus-${2}.tar.gz boot ; mv boot/vmlinux.kpart-* boot-chromebook_octopus-${2}.dd ; rm -rf boot )
