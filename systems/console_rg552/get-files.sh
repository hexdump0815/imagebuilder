# this file is supposed to be sourced by the get-files shell script

rm -f ${DOWNLOAD_DIR}/boot-console_rg552-aarch64.dd
wget -v https://github.com/thenameisluk/u-boot-rk3xxx-bootloader/releases/download/anbernic-rg552_gen1/boot-console_rg552-aarch64.dd.gz -O - | gunzip -c > ${DOWNLOAD_DIR}/boot-console_rg552-aarch64.dd

rm -f ${DOWNLOAD_DIR}/kernel-console_rg552-${2}.tar.gz
wget -v https://github.com/thenameisluk/linux-rk3xxx-kernel/releases/download/6.12.0-stb-rg5%2B/6.12.0-stb-rg5+.tar.gz -O ${DOWNLOAD_DIR}/kernel-console_rg552-${2}.tar.gz