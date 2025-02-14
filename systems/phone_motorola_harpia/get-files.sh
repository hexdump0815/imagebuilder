# this file is supposed to be sourced by the get-files shell script

msm8916_kernel_release_version="6.12.12-stb-410%2B"

rm -f ${DOWNLOAD_DIR}/kernel-phone_motorola_harpia-${2}.tar.gz
wget -v https://github.com/hexdump0815/linux-mainline-qcom-kernel/releases/download/${msm8916_kernel_release_version}/${msm8916_kernel_release_version}.tar.gz -O ${DOWNLOAD_DIR}/kernel-phone_motorola_harpia-${2}.tar.gz
