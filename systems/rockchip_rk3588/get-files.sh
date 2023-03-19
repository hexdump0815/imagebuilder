# this file is supposed to be sourced by the get-files shell script

rockchip_rk3588_release_version="5.10.110-rxa-r58%2B"
rockchip_rk3588_u_boot_binary_version="b9f18fe55c4f6663bb944343abdef57041890430"

rm -f ${DOWNLOAD_DIR}/kernel-rockchip_rk3588-${2}.tar.gz
wget -v https://github.com/hexdump0815/linux-rockchip-rk3588-kernel/releases/download/${rockchip_rk3588_release_version}/${rockchip_rk3588_release_version}.tar.gz -O ${DOWNLOAD_DIR}/kernel-rockchip_rk3588-${2}.tar.gz

rm -f ${DOWNLOAD_DIR}/boot-rockchip_rk3588-${2}.dd
wget -v https://github.com/hexdump0815/linux-rockchip-rk3588-kernel/raw/${rockchip_rk3588_u_boot_binary_version}/misc.r58/u-boot/boot-orange-pi-5.dd.gz -O - | gunzip -c | dd bs=512 seek=34 skip=34 of=${DOWNLOAD_DIR}/boot-rockchip_rk3588-${2}.dd

# get different u-boot versions for different rk33xx rockchip versions to have them around
rm -rf ${DOWNLOAD_DIR}/boot-extra-${1}
mkdir -p ${DOWNLOAD_DIR}/boot-extra-${1}
cp ${DOWNLOAD_DIR}/boot-rockchip_rk3588-${2}.dd ${DOWNLOAD_DIR}/boot-extra-${1}/boot-orange-pi-5.dd
wget -v https://github.com/hexdump0815/linux-rockchip-rk3588-kernel/raw/${rockchip_rk3588_u_boot_binary_version}/misc.r58/u-boot/boot-rock-5b.dd.gz -O - | gunzip -c | dd bs=512 seek=34 skip=34 of=${DOWNLOAD_DIR}/boot-extra-${1}/boot-rock-5b.dd
