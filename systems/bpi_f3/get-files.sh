# this file is supposed to be sourced by the get-files shell script

bpi_f3_release_version="6.1.15-bf3-001+"
bpi_f3_boot_version="6.1.15-bf3-001+"
bpi_f3_firmware_version="6.1.15-bf3-001+"

rm -f ${DOWNLOAD_DIR}/kernel-bpi_f3-${2}.tar.gz
wget -v https://github.com/hexdump0815/linux-spacemit-k1-kernel/releases/download/${bpi_f3_release_version}/${bpi_f3_release_version}.tar.gz -O ${DOWNLOAD_DIR}/kernel-bpi_f3-${2}.tar.gz

rm -f ${DOWNLOAD_DIR}/boot-bpi_f3-${2}.dd
wget -v https://github.com/hexdump0815/linux-spacemit-k1-kernel/raw/${bpi_f3_boot_version}/misc.bf3/misc/boot-bpi-f3-armbian.dd.gz -O - | gunzip -c > ${DOWNLOAD_DIR}/boot-bpi_f3-${2}.dd

# the boot blocks
rm -rf ${DOWNLOAD_DIR}/boot-extra-${1}
mkdir -p ${DOWNLOAD_DIR}/boot-extra-${1}
cp ${DOWNLOAD_DIR}/boot-bpi_f3-${2}.dd ${DOWNLOAD_DIR}/boot-extra-${1}/boot-bpi-f3-armbian.dd

# the required remoteproc firmware
rm -rf ${DOWNLOAD_DIR}/postinstall-${1}
mkdir -p ${DOWNLOAD_DIR}/postinstall-${1}
wget -v https://github.com/hexdump0815/linux-spacemit-k1-kernel/raw/${bpi_f3_firmware_version}/misc.bf3/misc/firmware/esos.elf.gz -O - | gunzip -c > ${DOWNLOAD_DIR}/postinstall-${1}/esos.elf
