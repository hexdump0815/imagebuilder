# this file is supposed to be sourced by the get-files shell script

bouffalo_lab_bl808_release_version="6.5.11-stb-obl+"

rm -f ${DOWNLOAD_DIR}/kernel-bouffalo_lab_bl808-${2}.tar.gz
wget -v https://github.com/hexdump0815/linux-mainline-bouffalo-lab-bl808-kernel/releases/download/${bouffalo_lab_bl808_release_version}/${bouffalo_lab_bl808_release_version}.tar.gz -O ${DOWNLOAD_DIR}/kernel-bouffalo_lab_bl808-${2}.tar.gz

# the bootblocks are in the to be flashed firmware and that is
# already in /boot/extra via extra-files
