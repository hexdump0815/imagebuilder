# this file is supposed to be sourced by the get-files shell script  

allwinner_h6_release_version="5.10.25-stb-ah6%2B"
allwinner_h6_uboot_version="200718-01"
mesa_release_version="21.0.1"

rm -f ${DOWNLOAD_DIR}/kernel-allwinner_h6-${2}.tar.gz
wget -v https://github.com/hexdump0815/linux-mainline-and-mali-allwinner-h3-h6-kernel/releases/download/${allwinner_h6_release_version}/${allwinner_h6_release_version}.tar.gz -O ${DOWNLOAD_DIR}/kernel-allwinner_h6-${2}.tar.gz

#rm -f ${DOWNLOAD_DIR}/kernel-mali-allwinner_h6-${2}.tar.gz
#wget -v https://github.com/hexdump0815/linux-mainline-and-mali-allwinner-h3-h6-kernel/releases/download/${allwinner_h6_release_version}/${allwinner_h6_release_version}-mali-h6.tar.gz -O ${DOWNLOAD_DIR}/kernel-mali-allwinner_h6-${2}.tar.gz

rm -f ${DOWNLOAD_DIR}/boot-allwinner_h6-${2}.dd
wget -v https://github.com/hexdump0815/u-boot-misc/releases/download/${allwinner_h6_uboot_version}/boot-allwinner_h6-aarch64.dd.gz -O - | gunzip -c >> ${DOWNLOAD_DIR}/boot-allwinner_h6-${2}.dd

# get the self built fresher mesa
wget https://github.com/hexdump0815/mesa-etc-build/releases/download/${mesa_release_version}/opt-mesa-${mesa_release_version}-${3}-${2}.tar.gz -O ${DOWNLOAD_DIR}/opt-mesa-${3}-${2}.tar.gz
