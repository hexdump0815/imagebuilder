# this file is supposed to be sourced by the get-files shell script  

allwinner_h616_release_version="6.1.51-stb-616%2B"
allwinner_h616_uboot_version="230127-01"
mesa_release_version="22.1.1"

rm -f ${DOWNLOAD_DIR}/kernel-allwinner_h616-${2}.tar.gz
wget -v https://github.com/hexdump0815/linux-mainline-and-mali-allwinner-h6-kernel/releases/download/${allwinner_h616_release_version}/${allwinner_h616_release_version}.tar.gz -O ${DOWNLOAD_DIR}/kernel-allwinner_h616-${2}.tar.gz

rm -f ${DOWNLOAD_DIR}/boot-allwinner_h616-${2}.dd
wget -v https://github.com/hexdump0815/u-boot-misc/releases/download/${allwinner_h616_uboot_version}/boot-allwinner_h616-tx6s-aarch64.dd.gz -O - | gunzip -c > ${DOWNLOAD_DIR}/boot-allwinner_h616-${2}.dd

# get different u-boot versions for different veyron versions to have them around
rm -rf ${DOWNLOAD_DIR}/boot-extra-${1}
mkdir -p ${DOWNLOAD_DIR}/boot-extra-${1}
cp ${DOWNLOAD_DIR}/boot-allwinner_h616-${2}.dd ${DOWNLOAD_DIR}/boot-extra-${1}/boot-allwinner_h616-tx6s.dd
wget -v https://github.com/hexdump0815/u-boot-misc/releases/download/${allwinner_h616_uboot_version}/boot-allwinner_h616-t95-aarch64.dd.gz -O - | gunzip -c > ${DOWNLOAD_DIR}/boot-extra-${1}/boot-allwinner_h616-t95.dd
wget -v https://github.com/hexdump0815/u-boot-misc/releases/download/${allwinner_h616_uboot_version}/boot-allwinner_h616-x96mate-aarch64.dd.gz -O - | gunzip -c > ${DOWNLOAD_DIR}/boot-extra-${1}/boot-allwinner_h616-x96mate.dd
wget -v https://github.com/hexdump0815/u-boot-misc/releases/download/${allwinner_h616_uboot_version}/boot-allwinner_h616-opizero2-aarch64.dd.gz -O - | gunzip -c > ${DOWNLOAD_DIR}/boot-extra-${1}/boot-allwinner_h616-opizero2.dd
# get the warpme minimyth2 based axp313a boot block as well for h618 experiments
wget -v https://github.com/hexdump0815/linux-mainline-and-mali-allwinner-h6-kernel/raw/3ecf55b1961a892211c8ff3b3ba7e7039dfe48ef/misc.616/u-boot/boot-h618-axp313a.dd.gz -O - | gunzip -c > ${DOWNLOAD_DIR}/boot-extra-${1}/boot-allwinner_h616-axp313a.dd

# get the self built fresher mesa
if [ "${3}" = "bullseye" ] || [ "${3}" = "focal" ]; then
  wget https://github.com/hexdump0815/mesa-etc-build/releases/download/${mesa_release_version}/opt-mesa-${mesa_release_version}-${3}-${2}.tar.gz -O ${DOWNLOAD_DIR}/opt-mesa-${3}-${2}.tar.gz
fi
