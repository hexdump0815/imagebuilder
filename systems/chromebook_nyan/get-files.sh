# this file is supposed to be sourced by the get-files shell script

chromebook_nyan_release_version="5.10.25-stb-cbt%2B"
chromebook_nyan_uboot_version="v2018.11-cbt"

rm -f ${DOWNLOAD_DIR}/kernel-chromebook_nyan-armv7l.tar.gz
wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/releases/download/${chromebook_nyan_release_version}/${chromebook_nyan_release_version}.tar.gz -O ${DOWNLOAD_DIR}/kernel-chromebook_nyan-armv7l.tar.gz

rm -f ${DOWNLOAD_DIR}/boot-chromebook_nyan-armv7l.dd
wget -v https://github.com/hexdump0815/u-boot-chainloading-for-arm-chromebooks/releases/download/${chromebook_nyan_uboot_version}/uboot.kpart.cbt.gz -O - | gunzip -c > ${DOWNLOAD_DIR}/boot-chromebook_nyan-armv7l.dd

# as long as there is a separate build for the tegra mesa, get it here - will disappear soon ...
rm -f ${DOWNLOAD_DIR}/opt-mesa-${3}-${2}.tar.gz
wget https://github.com/hexdump0815/mesa-etc-build/releases/download/${mesa_release_version}/opt-mesa-tegra-${mesa_release_version}-${3}-${2}.tar.gz -O ${DOWNLOAD_DIR}/opt-mesa-${3}-${2}.tar.gz

# on tegra a fresher xorg is required as well
rm -f ${DOWNLOAD_DIR}/opt-xserver-${3}-${2}.tar.gz
wget https://github.com/hexdump0815/mesa-etc-build/releases/download/${mesa_release_version}/opt-xserver-${mesa_release_version}-${3}-${2}.tar.gz -O ${DOWNLOAD_DIR}/opt-xserver-${3}-${2}.tar.gz
