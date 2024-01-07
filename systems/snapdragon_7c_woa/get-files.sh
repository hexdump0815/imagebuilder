# this file is supposed to be sourced by the get-files shell script

snapdragon_7c_woa_release_version="6.6.9-stb-qc7+"

rm -f ${DOWNLOAD_DIR}/kernel-snapdragon_7c_woa-${2}.tar.gz
wget -v https://github.com/hexdump0815/linux-mainline-qcom-msm8998-kernel/releases/download/${snapdragon_7c_woa_release_version}/${snapdragon_7c_woa_release_version}.tar.gz -O ${DOWNLOAD_DIR}/kernel-snapdragon_7c_woa-${2}.tar.gz
