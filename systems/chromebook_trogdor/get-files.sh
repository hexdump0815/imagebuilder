# this file is supposed to be sourced by the get-files shell script

chromebook_trogdor_release_version="5.19.1-stb-cbq%2B"
mesa_release_version="22.1.1"

rm -f ${DOWNLOAD_DIR}/kernel-chromebook_trogdor-${2}.tar.gz
wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/releases/download/${chromebook_trogdor_release_version}/${chromebook_trogdor_release_version}.tar.gz -O ${DOWNLOAD_DIR}/kernel-chromebook_trogdor-${2}.tar.gz

( cd ${DOWNLOAD_DIR} ; tar xzf kernel-chromebook_trogdor-${2}.tar.gz boot ; mv boot/vmlinux.kpart-* boot-chromebook_trogdor-${2}.dd ; rm -rf boot )

# some qcom tools are required to get wifi working on snapdragon sc7180 devices

qcom_tools_version="20211117-01"

rm -rf ${DOWNLOAD_DIR}/postinstall-${1}
mkdir -p ${DOWNLOAD_DIR}/postinstall-${1}
wget -v https://github.com/hexdump0815/qcom-tools-build/releases/download/${qcom_tools_version}/qcom-tools-${2}-${3}.tar.gz -O ${DOWNLOAD_DIR}/postinstall-${1}/qcom-tools-${2}-${3}.tar.gz

# get the self built fresher mesa
wget https://github.com/hexdump0815/mesa-etc-build/releases/download/${mesa_release_version}/opt-mesa-${mesa_release_version}-${3}-${2}.tar.gz -O ${DOWNLOAD_DIR}/opt-mesa-${3}-${2}.tar.gz
