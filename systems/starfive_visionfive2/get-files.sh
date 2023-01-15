# this file is supposed to be sourced by the get-files shell script

starfive_visionfive2_release_version="5.15.0-vf2-260%2B"

rm -f ${DOWNLOAD_DIR}/kernel-starfive_visionfive2-${2}.tar.gz
wget -v https://github.com/hexdump0815/linux-starfive-visionfive2-kernel/releases/download/${starfive_visionfive2_release_version}/${starfive_visionfive2_release_version}.tar.gz -O ${DOWNLOAD_DIR}/kernel-starfive_visionfive2-${2}.tar.gz
