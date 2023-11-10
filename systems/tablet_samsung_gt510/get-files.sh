# this file is supposed to be sourced by the get-files shell script

msm8916_kernel_release_version="6.6.0-stb-410%2B"
mesa_release_version="22.1.1"

rm -f ${DOWNLOAD_DIR}/kernel-tablet_samsung_gt510-${2}.tar.gz
wget -v https://github.com/hexdump0815/linux-mainline-qcom-kernel/releases/download/${msm8916_kernel_release_version}/${msm8916_kernel_release_version}.tar.gz -O ${DOWNLOAD_DIR}/kernel-tablet_samsung_gt510-${2}.tar.gz

# get the self built fresher mesa
if [ "${3}" = "bullseye" ] || [ "${3}" = "focal" ]; then
  wget https://github.com/hexdump0815/mesa-etc-build/releases/download/${mesa_release_version}/opt-mesa-${mesa_release_version}-${3}-${2}.tar.gz -O ${DOWNLOAD_DIR}/opt-mesa-${3}-${2}.tar.gz
fi
