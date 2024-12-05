# this file is supposed to be sourced by the get-files shell script

rm -f ${DOWNLOAD_DIR}/boot-console_x55-aarch64.dd
wget -v https://github.com/thenameisluk/u-boot-rk35xx-bootloader/releases/download/x55-gen1/boot-console_x55-aarch64.dd.gz -O - | gunzip -c > ${DOWNLOAD_DIR}/boot-console_x55-aarch64.dd

rm -f ${DOWNLOAD_DIR}/kernel-console_x55-${2}.tar.gz
wget -v https://github.com/thenameisluk/linux-rk35xx-kernel/releases/download/6.11.0-stb-x55%2B/6.11.0-stb-x55+.tar.gz -O ${DOWNLOAD_DIR}/kernel-console_x55-${2}.tar.gz

rm -f ${DOWNLOAD_DIR}/overlays-x55.tar.gz
wget -v https://github.com/thenameisluk/linux-rk35xx-kernel/releases/download/6.11.0-stb-x55%2B/overlays-x55.tar.gz -O ${DOWNLOAD_DIR}/overlays-x55.tar.gz