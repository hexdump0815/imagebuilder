# this file is supposed to be sourced by the get-files shell script

# right now i'm still using a postmarketos kernel+initrd=boot.img and will maybe later move to an own boot.img

# get a kernel etc. from a special portmarketos based build

motorola_harpia_pmos_release_version="linux-postmarketos-qcom-msm8916-5.18-r101"
mesa_release_version="22.1.1"

rm -rf ${DOWNLOAD_DIR}/postinstall-${1}
mkdir -p ${DOWNLOAD_DIR}/postinstall-${1}
wget -v https://github.com/hexdump0815/pmaports-other/releases/download/${motorola_harpia_pmos_release_version}/boot-and-modules-motorola-harpia.tar.gz -O ${DOWNLOAD_DIR}/postinstall-${1}/boot-and-modules.tar.gz

# some qcom tools are required to get wifi working on snapdragon socs

qcom_tools_version="20211117-01"

wget -v https://github.com/hexdump0815/qcom-tools-build/releases/download/${qcom_tools_version}/qcom-tools-${2}-${3}.tar.gz -O ${DOWNLOAD_DIR}/postinstall-${1}/qcom-tools-${2}-${3}.tar.gz

# get the self built fresher mesa
if [ "${3}" != "bookworm" ]; then
  wget https://github.com/hexdump0815/mesa-etc-build/releases/download/${mesa_release_version}/opt-mesa-${mesa_release_version}-${3}-${2}.tar.gz -O ${DOWNLOAD_DIR}/opt-mesa-${3}-${2}.tar.gz
fi
