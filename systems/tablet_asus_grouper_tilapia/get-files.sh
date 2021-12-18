# this file is supposed to be sourced by the get-files shell script

# get a kernel etc. from a special portmarketos based build

asus_grouper_pmos_release_version="linux-asus-grouper-5.14.0_rc3-r1"

rm -rf ${DOWNLOAD_DIR}/boot-extra-${1}
mkdir -p ${DOWNLOAD_DIR}/boot-extra-${1}
wget -v https://github.com/hexdump0815/pmaports-other/releases/download/${asus_grouper_pmos_release_version}/boot.img-grouper-pm269.gz -O - | gunzip -c > ${DOWNLOAD_DIR}/boot-extra-${1}/boot.img-grouper-pm269
wget -v https://github.com/hexdump0815/pmaports-other/releases/download/${asus_grouper_pmos_release_version}/boot.img-grouper-e1565.gz -O - | gunzip -c > ${DOWNLOAD_DIR}/boot-extra-${1}/boot.img-grouper-e1565
wget -v https://github.com/hexdump0815/pmaports-other/releases/download/${asus_grouper_pmos_release_version}/boot.img-tilapia-e1565.gz -O - | gunzip -c > ${DOWNLOAD_DIR}/boot-extra-${1}/boot.img-tilapia-e1565
wget -v https://github.com/hexdump0815/pmaports-other/releases/download/${asus_grouper_pmos_release_version}/config-asus-grouper.armv7.gz -O - | gunzip -c > ${DOWNLOAD_DIR}/boot-extra-${1}/config-other-ford.armv7
wget -v https://github.com/hexdump0815/pmaports-other/releases/download/${asus_grouper_pmos_release_version}/initramfs-extra.gz -O - | gunzip -c > ${DOWNLOAD_DIR}/boot-extra-${1}/initramfs-extra
wget -v https://github.com/hexdump0815/pmaports-other/releases/download/${asus_grouper_pmos_release_version}/initramfs.gz -O - | gunzip -c > ${DOWNLOAD_DIR}/boot-extra-${1}/initramfs
wget -v https://github.com/hexdump0815/pmaports-other/releases/download/${asus_grouper_pmos_release_version}/vmlinuz.gz -O - | gunzip -c > ${DOWNLOAD_DIR}/boot-extra-${1}/vmlinuz.gz
wget -v https://github.com/hexdump0815/pmaports-other/releases/download/${asus_grouper_pmos_release_version}/lib-modules.tar.gz -O ${DOWNLOAD_DIR}/boot-extra-${1}/lib-modules.tar.gz
