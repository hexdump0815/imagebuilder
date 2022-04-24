# this file is supposed to be sourced by the get-files shell script

# toggle installing legacy kernel or mainline kernel by default
LEGACY_KERNEL="no"

# this one is for the v5.4 kernel tree which had a way more reliable display handling in the past
#chromebook_nyan_release_version="5.4.125-stb-cbt%2B"
#chromebook_nyan_kernel_tree="linux-mainline-tegra-k1-kernel"
# this one is for the v5.15 newer kernel which seems to work similarly well now
chromebook_nyan_release_version="5.15.22-stb-cbt%2B"
chromebook_nyan_kernel_tree="linux-mainline-and-mali-generic-stable-kernel"
chromebook_nyan_legacy_release_version="3.10.18-cos-r91"
chromebook_nyan_2g_uboot_version="v2021.10-cbt"
chromebook_nyan_2g_noflicker_uboot_version="v2021.10-cbt"
chromebook_nyan_4g_uboot_version="v2021.10-cbt"
chromebook_nyan_4g_noflicker_uboot_version="v2021.10-cbt"
mesa_release_version="21.0.1"
xserver_release_version="21.0.1"

rm -rf ${DOWNLOAD_DIR}/boot-extra-${1}
mkdir -p ${DOWNLOAD_DIR}/boot-extra-${1}
# get different u-boot versions for different nyan chromebook versions
wget -v https://github.com/hexdump0815/u-boot-chainloading-for-arm-chromebooks/releases/download/${chromebook_nyan_2g_uboot_version}/uboot.kpart.cbt-2g.gz -O - | gunzip -c > ${DOWNLOAD_DIR}/boot-extra-${1}/uboot.kpart.cbt-2g
wget -v https://github.com/hexdump0815/u-boot-chainloading-for-arm-chromebooks/releases/download/${chromebook_nyan_2g_noflicker_uboot_version}/uboot.kpart.cbt-2g-noflicker.gz -O - | gunzip -c > ${DOWNLOAD_DIR}/boot-extra-${1}/uboot.kpart.cbt-2g-noflicker
wget -v https://github.com/hexdump0815/u-boot-chainloading-for-arm-chromebooks/releases/download/${chromebook_nyan_4g_uboot_version}/uboot.kpart.cbt-4g.gz -O - | gunzip -c > ${DOWNLOAD_DIR}/boot-extra-${1}/uboot.kpart.cbt-4g
wget -v https://github.com/hexdump0815/u-boot-chainloading-for-arm-chromebooks/releases/download/${chromebook_nyan_4g_noflicker_uboot_version}/uboot.kpart.cbt-4g-noflicker.gz -O - | gunzip -c > ${DOWNLOAD_DIR}/boot-extra-${1}/uboot.kpart.cbt-4g-noflicker
rm -f ${DOWNLOAD_DIR}/boot-chromebook_nyan-armv7l.dd

if [ ${LEGACY_KERNEL} = "no" ]; then

  # get the mainline kernel
  rm -f ${DOWNLOAD_DIR}/kernel-chromebook_nyan-armv7l.tar.gz
  wget -v https://github.com/hexdump0815/${chromebook_nyan_kernel_tree}/releases/download/${chromebook_nyan_release_version}/${chromebook_nyan_release_version}.tar.gz -O ${DOWNLOAD_DIR}/kernel-chromebook_nyan-armv7l.tar.gz

  # copy the 4gb nyan u-boot to the right place, so that it will be written to the kernel partition
  cp ${DOWNLOAD_DIR}/boot-extra-${1}/uboot.kpart.cbt-4g ${DOWNLOAD_DIR}/boot-chromebook_nyan-armv7l.dd

  # put the legacy kernel into /boot/extra as well - just in case
  wget -v https://github.com/hexdump0815/linux-chromeos-kernel/releases/download/${chromebook_nyan_legacy_release_version}/${chromebook_nyan_legacy_release_version}.tar.gz -O ${DOWNLOAD_DIR}/boot-extra-${1}/kernel-chromebook_nyan-legacy.tar.gz

else

  # get the the legacy chromeos kernel
  rm -f ${DOWNLOAD_DIR}/kernel-chromebook_nyan-armv7l.tar.gz
  wget -v https://github.com/hexdump0815/linux-chromeos-kernel/releases/download/${chromebook_nyan_legacy_release_version}/${chromebook_nyan_legacy_release_version}.tar.gz -O ${DOWNLOAD_DIR}/kernel-chromebook_nyan-armv7l.tar.gz

  # extract the cros kpart image from the kernel tar.gz to use it for the cros kernel partition
  ( cd ${DOWNLOAD_DIR} && tar xzf kernel-chromebook_nyan-armv7l.tar.gz boot/vmlinux.kpart-${chromebook_nyan_legacy_release_version} && mv boot/vmlinux.kpart-${chromebook_nyan_legacy_release_version} boot-chromebook_nyan-armv7l.dd && rmdir boot )

  # put the mainline kernel into /boot/extra as well - just in case
  wget -v https://github.com/hexdump0815/${chromebook_nyan_kernel_tree}/releases/download/${chromebook_nyan_release_version}/${chromebook_nyan_release_version}.tar.gz -O ${DOWNLOAD_DIR}/boot-extra-${1}/kernel-chromebook_nyan-mainline.tar.gz

fi

# get the self built fresher mesa - except for jammy (for now) which has a newer version already
if [ "${3}" != "jammy" ]; then
  wget https://github.com/hexdump0815/mesa-etc-build/releases/download/${mesa_release_version}/opt-mesa-${mesa_release_version}-${3}-${2}.tar.gz -O ${DOWNLOAD_DIR}/opt-mesa-${3}-${2}.tar.gz
fi

## on tegra a fresher xorg is required as well
#rm -f ${DOWNLOAD_DIR}/opt-xserver-${3}-${2}.tar.gz
#wget https://github.com/hexdump0815/mesa-etc-build/releases/download/${xserver_release_version}/opt-xserver-${3}-${2}.tar.gz -O ${DOWNLOAD_DIR}/opt-xserver-${3}-${2}.tar.gz
