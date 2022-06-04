# this file is supposed to be sourced by the get-files shell script  


allwinner_h6_release_version="5.18.0-stb-ah6%2B"
allwinner_h6_uboot_version="211229-01"
mesa_release_version="22.1.1"

rm -f ${DOWNLOAD_DIR}/kernel-allwinner_h6-${2}.tar.gz
wget -v https://github.com/hexdump0815/linux-mainline-and-mali-allwinner-h6-kernel/releases/download/${allwinner_h6_release_version}/${allwinner_h6_release_version}.tar.gz -O ${DOWNLOAD_DIR}/kernel-allwinner_h6-${2}.tar.gz

# get different u-boot versions for different allwinner h6 systems to have them around
rm -rf ${DOWNLOAD_DIR}/boot-extra-${1}
mkdir -p ${DOWNLOAD_DIR}/boot-extra-${1}
for system in eachlink_h6_mini orange_pi_3 pine-h64 noname_h6_tv_box orangepi_one_plus tanix_tx6; do
  wget -v https://github.com/hexdump0815/u-boot-misc/releases/download/${allwinner_h6_uboot_version}/boot-${system}-aarch64.dd.gz -O - | gunzip -c > ${DOWNLOAD_DIR}/boot-extra-${1}/boot-${system}.dd
done

# use the eachlink h6 mini u-boot as default
cp ${DOWNLOAD_DIR}/boot-extra-${1}/boot-eachlink_h6_mini.dd ${DOWNLOAD_DIR}/boot-allwinner_h6-${2}.dd

# get the self built fresher mesa
wget https://github.com/hexdump0815/mesa-etc-build/releases/download/${mesa_release_version}/opt-mesa-${mesa_release_version}-${3}-${2}.tar.gz -O ${DOWNLOAD_DIR}/opt-mesa-${3}-${2}.tar.gz
