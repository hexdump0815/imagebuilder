# this file is supposed to be sourced by the get-files shell script

rm -f ${DOWNLOAD_DIR}/idbloader.img
wget -v https://github.com/thenameisluk/u-boot-rk35xx-bootloader/releases/download/x55-gen1/idbloader.img -O ${DOWNLOAD_DIR}/idbloader.img


rm -f ${DOWNLOAD_DIR}/u-boot.itb
wget -v https://github.com/thenameisluk/u-boot-rk35xx-bootloader/releases/download/x55-gen1/u-boot.itb -O ${DOWNLOAD_DIR}/u-boot.itb

