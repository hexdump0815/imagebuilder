# this file is supposed to be sourced by the get-files shell script

starfive_visionfive2_release_version="5.15.0-vf2-104%2B"
starfive_visionfive2_boot_version="202302"

rm -f ${DOWNLOAD_DIR}/kernel-starfive_visionfive2-${2}.tar.gz
wget -v https://github.com/hexdump0815/linux-starfive-visionfive2-kernel/releases/download/${starfive_visionfive2_release_version}/${starfive_visionfive2_release_version}.tar.gz -O ${DOWNLOAD_DIR}/kernel-starfive_visionfive2-${2}.tar.gz

rm -f ${DOWNLOAD_DIR}/boot-starfive_visionfive2-${2}.dd
wget -v https://github.com/hexdump0815/linux-starfive-visionfive2-kernel/raw/${starfive_visionfive2_release_version}/misc.vf2/misc/boot-vf2-${starfive_visionfive2_boot_version}.dd.gz -O - | gunzip -c | dd bs=512 seek=34 skip=34 of=${DOWNLOAD_DIR}/boot-starfive_visionfive2-${2}.dd
