# this file is supposed to be sourced by the get-files shell script

chromebook_kukui_release_version="6.1.51-stb-mt8%2B"
mesa_release_version="22.1.1"

rm -f ${DOWNLOAD_DIR}/kernel-chromebook_kukui-${2}.tar.gz
wget -v https://github.com/hexdump0815/linux-mainline-mediatek-mt81xx-kernel/releases/download/${chromebook_kukui_release_version}/${chromebook_kukui_release_version}.tar.gz -O ${DOWNLOAD_DIR}/kernel-chromebook_kukui-${2}.tar.gz

( cd ${DOWNLOAD_DIR} ; tar xzf kernel-chromebook_kukui-${2}.tar.gz boot ; mv boot/vmlinux.kpart-* boot-chromebook_kukui-${2}.dd ; rm -rf boot )

# get the self built fresher mesa
if [ "${3}" = "bullseye" ] || [ "${3}" = "focal" ]; then
  wget https://github.com/hexdump0815/mesa-etc-build/releases/download/${mesa_release_version}/opt-mesa-${mesa_release_version}-${3}-${2}.tar.gz -O ${DOWNLOAD_DIR}/opt-mesa-${3}-${2}.tar.gz
fi
