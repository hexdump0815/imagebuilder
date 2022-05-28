# this file is supposed to be sourced by the get-files shell script

chromebook_gru_release_version="5.18.0-stb-cbg%2B"
mesa_release_version="22.1.0"

rm -f ${DOWNLOAD_DIR}/kernel-chromebook_gru-${2}.tar.gz
wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/releases/download/${chromebook_gru_release_version}/${chromebook_gru_release_version}.tar.gz -O ${DOWNLOAD_DIR}/kernel-chromebook_gru-${2}.tar.gz

( cd ${DOWNLOAD_DIR} ; tar xzf kernel-chromebook_gru-${2}.tar.gz boot ; mv boot/vmlinux.kpart-* boot-chromebook_gru-${2}.dd ; rm -rf boot )

# get the self built fresher mesa
wget https://github.com/hexdump0815/mesa-etc-build/releases/download/${mesa_release_version}/opt-mesa-${mesa_release_version}-${3}-${2}.tar.gz -O ${DOWNLOAD_DIR}/opt-mesa-${3}-${2}.tar.gz
