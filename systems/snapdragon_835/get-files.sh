# this file is supposed to be sourced by the get-files shell script

snapdragon_835_release_version="6.1.0-stb-qcn"

rm -f ${DOWNLOAD_DIR}/kernel-snapdragon_835-${2}.tar.gz
wget -v https://github.com/hexdump0815/linux-mainline-qcom-msm8998-kernel/releases/download/${snapdragon_835_release_version}/${snapdragon_835_release_version}.tar.gz -O ${DOWNLOAD_DIR}/kernel-snapdragon_835-${2}.tar.gz
