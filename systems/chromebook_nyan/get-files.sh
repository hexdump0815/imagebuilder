# this file is supposed to be sourced by the get-files shell script

# this one is for the v5.4 kernel tree which has a way more reliable display handling
chromebook_nyan_release_version="5.4.125-stb-cbt%2B"
chromebook_nyan_kernel_tree="linux-mainline-tegra-k1-kernel"
# this one is for the v5.10 or newer kernel tree which still has very unreliable display handling
#chromebook_nyan_release_version="5.10.25-stb-cbt%2B"
#chromebook_nyan_kernel_tree="linux-mainline-and-mali-generic-stable-kernel"
chromebook_nyan_uboot_version="v2018.11-cbt"
chromebook_nyan_2g_uboot_version="v2021.07-rc4-cbt"
xserver_release_version="21.0.1"

rm -f ${DOWNLOAD_DIR}/kernel-chromebook_nyan-armv7l.tar.gz
wget -v https://github.com/hexdump0815/${chromebook_nyan_kernel_tree}/releases/download/${chromebook_nyan_release_version}/${chromebook_nyan_release_version}.tar.gz -O ${DOWNLOAD_DIR}/kernel-chromebook_nyan-armv7l.tar.gz

rm -f ${DOWNLOAD_DIR}/boot-chromebook_nyan-armv7l.dd
wget -v https://github.com/hexdump0815/u-boot-chainloading-for-arm-chromebooks/releases/download/${chromebook_nyan_uboot_version}/uboot.kpart.cbt.gz -O - | gunzip -c > ${DOWNLOAD_DIR}/boot-chromebook_nyan-armv7l.dd

# keep the u-boot image in the extra dir to have it around
rm -rf ${DOWNLOAD_DIR}/boot-extra-${1}
mkdir -p ${DOWNLOAD_DIR}/boot-extra-${1}
cp ${DOWNLOAD_DIR}/boot-chromebook_nyan-armv7l.dd ${DOWNLOAD_DIR}/boot-extra-${1}/uboot.kpart.cbt-nyan-4g
wget -v https://github.com/hexdump0815/u-boot-chainloading-for-arm-chromebooks/releases/download/${chromebook_nyan_2g_uboot_version}/uboot.kpart.cbt-2g.gz -O - | gunzip -c > ${DOWNLOAD_DIR}//boot-extra-${1}/uboot.kpart.cbt-nyan-2g

# the v5.4 kernel does not work well together with the nouveau gpu driver, so this is not required yet
## on tegra a fresher xorg is required as well
#rm -f ${DOWNLOAD_DIR}/opt-xserver-${3}-${2}.tar.gz
#wget https://github.com/hexdump0815/mesa-etc-build/releases/download/${xserver_release_version}/opt-xserver-${3}-${2}.tar.gz -O ${DOWNLOAD_DIR}/opt-xserver-${3}-${2}.tar.gz
