# this file is supposed to be sourced by the get-files shell script

chromebook_x86_native_release_version="4.14.228-cos-r91+"

rm -f ${DOWNLOAD_DIR}/kernel-chromebook_x86_native-${2}.tar.gz
#wget -v https://github.com/hexdump0815/linux-chromeos-kernel/releases/download/${chromebook_x86_native_release_version}/${chromebook_x86_native_release_version}.tar.gz -O ${DOWNLOAD_DIR}/kernel-chromebook_x86_native-${2}.tar.gz
cp /compile/result/chromeos/${chromebook_x86_native_release_version}.tar.gz ${DOWNLOAD_DIR}/kernel-chromebook_x86_native-${2}.tar.gz

( cd ${DOWNLOAD_DIR} ; tar xzf kernel-chromebook_x86_native-${2}.tar.gz boot ; mv boot/vmlinux.kpart-* boot-chromebook_x86_native-${2}.dd ; rm -rf boot )
