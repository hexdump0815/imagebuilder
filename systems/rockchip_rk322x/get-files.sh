# this file is supposed to be sourced by the get-files shell script

rockchip_rk322x_release_version="4.4.194-rkc-322"
rockchip_rk322x_tree_tag="e8c89a16da9860c600e49772db3b7f01331624b9"

rm -f ${DOWNLOAD_DIR}/kernel-rockchip_rk322x-armv7l.tar.gz
wget -v https://github.com/hexdump0815/linux-rockchip-rk322x-kernel/releases/download/${rockchip_rk322x_release_version}/${rockchip_rk322x_release_version}.tar.gz -O ${DOWNLOAD_DIR}/kernel-rockchip_rk322x-armv7l.tar.gz

rm -f ${DOWNLOAD_DIR}/boot-rockchip_rk322x-armv7l.dd
wget -v https://github.com/hexdump0815/linux-rockchip-rk322x-kernel/raw/${rockchip_rk322x_tree_tag}/misc.322/u-boot/boot-rockchip_rk3229_r39_4k-armv7l.dd -O ${DOWNLOAD_DIR}/boot-rockchip_rk322x-armv7l.dd
