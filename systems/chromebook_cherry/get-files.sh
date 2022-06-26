# this file is supposed to be sourced by the get-files shell script

# use a chromeos based kernel until mainline starts to be useable
chromebook_cherry_chromeos_release_version="5.10.83-chr-r98%2B"
# this will be required when panfrost starts to get useable
#mesa_release_version="22.1.1"

rm -f ${DOWNLOAD_DIR}/kernel-chromebook_cherry-${2}.tar.gz
wget -v https://github.com/hexdump0815/linux-chromeos-kernel/releases/download/${chromebook_cherry_chromeos_release_version}/${chromebook_cherry_chromeos_release_version}.tar.gz -O ${DOWNLOAD_DIR}/kernel-chromebook_cherry-${2}.tar.gz

( cd ${DOWNLOAD_DIR} ; tar xzf kernel-chromebook_cherry-${2}.tar.gz boot ; mv boot/vmlinux.kpart-* boot-chromebook_cherry-${2}.dd ; rm -rf boot )

## get the self built fresher mesa
#wget https://github.com/hexdump0815/mesa-etc-build/releases/download/${mesa_release_version}/opt-mesa-${mesa_release_version}-${3}-${2}.tar.gz -O ${DOWNLOAD_DIR}/opt-mesa-${3}-${2}.tar.gz
