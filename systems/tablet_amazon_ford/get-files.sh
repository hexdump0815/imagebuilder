# this file is supposed to be sourced by the get-files shell script

# right now i'm still using a postmarketos kernel+initrd=boot.img and will maybe later move to an own boot.img
#
#amazon_ford_release_version="3.10.54-amz-f27%2B"
#
#rm -f ${DOWNLOAD_DIR}/kernel-tablet_amazon_ford-armv7l.tar.gz
#wget -v https://github.com/hexdump0815/linux-amazon-mt8127-kernel/releases/download/${tablet_amazon_ford_release_version}/${tablet_amazon_ford_release_version}.tar.gz -O ${DOWNLOAD_DIR}/kernel-tablet_amazon_ford-armv7l.tar.gz

# get a kernel etc. from a special portmarketos based build

amazon_ford_pmos_release_version="linux-amazon-ford-3.10.54-r3"

rm -rf ${DOWNLOAD_DIR}/boot-extra-${1}
mkdir -p ${DOWNLOAD_DIR}/boot-extra-${1}
wget -v https://github.com/hexdump0815/pmaports-amazon/releases/download/${amazon_ford_pmos_release_version}/boot.img.gz -O - | gunzip -c > ${DOWNLOAD_DIR}/boot-extra-${1}/boot.img
wget -v https://github.com/hexdump0815/pmaports-amazon/releases/download/${amazon_ford_pmos_release_version}/config-amazon-ford.armv7.gz -O - | gunzip -c > ${DOWNLOAD_DIR}/boot-extra-${1}/config-amazon-ford.armv7
wget -v https://github.com/hexdump0815/pmaports-amazon/releases/download/${amazon_ford_pmos_release_version}/initramfs-extra.gz -O - | gunzip -c > ${DOWNLOAD_DIR}/boot-extra-${1}/initramfs-extra
wget -v https://github.com/hexdump0815/pmaports-amazon/releases/download/${amazon_ford_pmos_release_version}/initramfs.gz -O - | gunzip -c > ${DOWNLOAD_DIR}/boot-extra-${1}/initramfs
wget -v https://github.com/hexdump0815/pmaports-amazon/releases/download/${amazon_ford_pmos_release_version}/vmlinuz.gz -O - | gunzip -c > ${DOWNLOAD_DIR}/boot-extra-${1}/vmlinuz.gz
wget -v https://github.com/hexdump0815/pmaports-amazon/releases/download/${amazon_ford_pmos_release_version}/lib-modules.tar.gz -O ${DOWNLOAD_DIR}/boot-extra-${1}/lib-modules.tar.gz

# the fb refresher is required for mt8127 based amazon fire 7 tablets to keep the screen updated

fb_refresher_version="1.0"

rm -rf ${DOWNLOAD_DIR}/postinstall-${1}
mkdir -p ${DOWNLOAD_DIR}/postinstall-${1}
wget -v https://github.com/hexdump0815/msm-fb-refresher/releases/download/${fb_refresher_version}/opt-msm-fb-refresher-${3}-armv7l.tar.gz -O ${DOWNLOAD_DIR}/postinstall-${1}/opt-msm-fb-refresher-${3}-armv7l.tar.gz

# get the firmware and related files to get wifi working
wget -v https://github.com/hexdump0815/imagebuilder-firmware/raw/main/tablet_amazon_ford-firmware.tar.gz -O ${DOWNLOAD_DIR}/postinstall-${1}/tablet_amazon_ford-firmware.tar.gz
