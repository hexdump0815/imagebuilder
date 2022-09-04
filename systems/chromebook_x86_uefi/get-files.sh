# this file is supposed to be sourced by the get-files shell script

chromebook_x86_uefi_extra_release_version="5.19.6-stb-odk+"

# put the newer extra kernel into /boot/extra to have it around
rm -rf ${DOWNLOAD_DIR}/boot-extra-${1}
mkdir -p ${DOWNLOAD_DIR}/boot-extra-${1}
wget -v https://github.com/hexdump0815/linux-mainline-x86-64-kernel/releases/download/${chromebook_x86_uefi_extra_release_version}/${chromebook_x86_uefi_extra_release_version}.tar.gz -O ${DOWNLOAD_DIR}/boot-extra-${1}/${chromebook_x86_uefi_extra_release_version}.tar.gz
