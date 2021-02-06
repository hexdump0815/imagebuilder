# this file is supposed to be sourced by the get-files shell script

rm -f ${DOWNLOAD_DIR}/kernel-rockchip_rk33xx-aarch64.tar.gz
wget -v https://github.com/hexdump0815/linux-mainline-and-mali-rockchip-rk33xx-kernel/releases/download/${rockchip_rk33xx_release_version}/${rockchip_rk33xx_release_version}.tar.gz -O ${DOWNLOAD_DIR}/kernel-rockchip_rk33xx-aarch64.tar.gz
#rm -f ${DOWNLOAD_DIR}/kernel-mali-rockchip_rk33xx-aarch64.tar.gz
#wget -v https://github.com/hexdump0815/linux-mainline-and-mali-rockchip-rk33xx-kernel/releases/download/${rockchip_rk33xx_release_version}/${rockchip_rk33xx_release_version}-mali-rk3328.tar.gz -O ${DOWNLOAD_DIR}/kernel-mali-rockchip_rk33xx-aarch64.tar.gz
#rm -f ${DOWNLOAD_DIR}/kernel-mali-b-rockchip_rk33xx-aarch64.tar.gz
#wget -v https://github.com/hexdump0815/linux-mainline-and-mali-rockchip-rk33xx-kernel/releases/download/${rockchip_rk33xx_release_version}/${rockchip_rk33xx_release_version}-mali-rk3399.tar.gz -O ${DOWNLOAD_DIR}/kernel-mali-b-alt-rockchip_rk33xx-aarch64.tar.gz
rm -f ${DOWNLOAD_DIR}/boot-rockchip_rk33xx-aarch64.dd
wget -v https://github.com/hexdump0815/u-boot-misc/releases/download/${rockchip_rk33xx_uboot_version}/boot-rk3328-ddrbin-spl-aarch64.dd.gz -O - | gunzip -c >> ${DOWNLOAD_DIR}/boot-rockchip_rk33xx-aarch64.dd
