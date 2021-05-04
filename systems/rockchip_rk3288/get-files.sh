# this file is supposed to be sourced by the get-files shell script

rockchip_rk3288_release_version="5.10.25-stb-av7%2B"
rockchip_rk3288_generic_tree_tag=${generic_tree_tag}

rm -f ${DOWNLOAD_DIR}/kernel-rockchip_rk3288-armv7l.tar.gz
wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/releases/download/${rockchip_rk3288_release_version}/${rockchip_rk3288_release_version}.tar.gz -O ${DOWNLOAD_DIR}/kernel-rockchip_rk3288-armv7l.tar.gz

#rm -f ${DOWNLOAD_DIR}/kernel-mali-rockchip_rk3288-armv7l.tar.gz
#wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/releases/download/${rockchip_rk3288_release_version}/${rockchip_rk3288_release_version}-mali-rk3288.tar.gz -O ${DOWNLOAD_DIR}/kernel-mali-rockchip_rk3288-armv7l.tar.gz

rm -f ${DOWNLOAD_DIR}/boot-rockchip_rk3288-armv7l.dd
wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/raw/${rockchip_rk3288_generic_tree_tag}/misc.av7/u-boot/boot-tinkerboard-armv7l.dd -O ${DOWNLOAD_DIR}/boot-rockchip_rk3288-armv7l.dd
