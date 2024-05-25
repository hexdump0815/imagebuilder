# this file is supposed to be sourced by the get-files shell script

milk_v_duo_release_version="5.10.4-mkv-duo+"

rm -f ${DOWNLOAD_DIR}/kernel-milk_v_duo-${2}.tar.gz
wget -v https://github.com/hexdump0815/linux-cvitek-cv18xx-kernel/releases/download/${milk_v_duo_release_version}/${milk_v_duo_release_version}.tar.gz -O ${DOWNLOAD_DIR}/kernel-milk_v_duo-${2}.tar.gz
