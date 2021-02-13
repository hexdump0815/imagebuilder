# this file is supposed to be sourced by the get-files shell script

rockchip_rk33xx_release_version="5.10.1-stb-rkc%2B"
rockchip_rk33xx_uboot_rk3318_ddrbin_legacy_atf_version="210131-01"
rockchip_rk33xx_uboot_rk3328_ddrbin_legacy_atf_version="210131-01"
rockchip_rk33xx_uboot_ddrbin_spl_version="210131-01"
rockchip_rk33xx_uboot_ddrbin_666mhz_spl_version="210131-01"
rockchip_rk33xx_uboot_tpl_spl_version="210131-01"

rm -f ${DOWNLOAD_DIR}/kernel-rockchip_rk33xx-aarch64.tar.gz
wget -v https://github.com/hexdump0815/linux-mainline-and-mali-rockchip-rk33xx-kernel/releases/download/${rockchip_rk33xx_release_version}/${rockchip_rk33xx_release_version}.tar.gz -O ${DOWNLOAD_DIR}/kernel-rockchip_rk33xx-aarch64.tar.gz

#rm -f ${DOWNLOAD_DIR}/kernel-mali-rockchip_rk33xx-aarch64.tar.gz
#wget -v https://github.com/hexdump0815/linux-mainline-and-mali-rockchip-rk33xx-kernel/releases/download/${rockchip_rk33xx_release_version}/${rockchip_rk33xx_release_version}-mali-rk3328.tar.gz -O ${DOWNLOAD_DIR}/kernel-mali-rockchip_rk33xx-aarch64.tar.gz
#rm -f ${DOWNLOAD_DIR}/kernel-mali-b-rockchip_rk33xx-aarch64.tar.gz
#wget -v https://github.com/hexdump0815/linux-mainline-and-mali-rockchip-rk33xx-kernel/releases/download/${rockchip_rk33xx_release_version}/${rockchip_rk33xx_release_version}-mali-rk3399.tar.gz -O ${DOWNLOAD_DIR}/kernel-mali-b-alt-rockchip_rk33xx-aarch64.tar.gz

rm -f ${DOWNLOAD_DIR}/boot-rockchip_rk33xx-aarch64.dd
wget -v https://github.com/hexdump0815/u-boot-misc/releases/download/${rockchip_rk33xx_uboot_rk3318_ddrbin_legacy_atf_version}/boot-rk3318-ddrbin-legacy-atf-aarch64.dd.gz -O - | gunzip -c >> ${DOWNLOAD_DIR}/boot-rockchip_rk33xx-aarch64.dd

# get different u-boot versions for different amlogic versions to have them around
mkdir -p ${DOWNLOAD_DIR}/boot-extra-${1}
cp ${DOWNLOAD_DIR}/boot-rockchip_rk33xx-aarch64.dd ${DOWNLOAD_DIR}/boot-extra-${1}/boot-rk3318-ddrbin-legacy-atf.dd
wget -v https://github.com/hexdump0815/u-boot-misc/releases/download/${rockchip_rk33xx_uboot_rk3328_ddrbin_legacy_atf_version}/boot-rk3328-ddrbin-legacy-atf-aarch64.dd.gz -O - | gunzip -c >> ${DOWNLOAD_DIR}/boot-extra-${1}/boot-rk3328-ddrbin-legacy-atf.dd
wget -v https://github.com/hexdump0815/u-boot-misc/releases/download/${rockchip_rk33xx_uboot_ddrbin_spl_version}/boot-rk3328-ddrbin-spl-aarch64.dd.gz -O - | gunzip -c >> ${DOWNLOAD_DIR}/boot-extra-${1}/boot-rk3328-ddrbin-spl.dd
wget -v https://github.com/hexdump0815/u-boot-misc/releases/download/${rockchip_rk33xx_uboot_ddrbin_666mhz_spl_version}/boot-rk3328-ddrbin-666mhz-spl-aarch64.dd.gz -O - | gunzip -c >> ${DOWNLOAD_DIR}/boot-extra-${1}/boot-rk3328-ddrbin-666mhz-spl.dd
wget -v https://github.com/hexdump0815/u-boot-misc/releases/download/${rockchip_rk33xx_uboot_tpl_spl_version}/boot-rk3328-tpl-spl-aarch64.dd.gz -O - | gunzip -c >> ${DOWNLOAD_DIR}/boot-extra-${1}/boot-rk3328-tpl-spl.dd
wget -v https://github.com/hexdump0815/u-boot-misc/releases/download/${rockchip_rk33xx_uboot_tpl_spl_version}/u-boot-rk3328.img.gz -O - | gunzip -c >> ${DOWNLOAD_DIR}/boot-extra-${1}/u-boot-rk3328.img
