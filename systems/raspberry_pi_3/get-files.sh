# this file is supposed to be sourced by the get-files shell script

raspberry_pi_3_release_version="5.15.22-stb-av8%2B"
raspberry_pi_3_uboot_version="220301-01"
mesa_release_version="22.1.1"
# bootloader blob and dtb versions
dtb_commit="fb0bfa6a669745578041e838fc73cc17e8c543c9"
boot_commit="9c04ed2c1ad06a615d8e6479806ab252dbbeb95a"

rm -f ${DOWNLOAD_DIR}/kernel-raspberry_pi_3-${2}.tar.gz
wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/releases/download/${raspberry_pi_3_release_version}/${raspberry_pi_3_release_version}.tar.gz -O ${DOWNLOAD_DIR}/kernel-raspberry_pi_3-${2}.tar.gz

# get u-boot.bin
rm -rf ${DOWNLOAD_DIR}/postinstall-${1}
mkdir -p ${DOWNLOAD_DIR}/postinstall-${1}
wget -v https://github.com/hexdump0815/u-boot-misc/releases/download/${raspberry_pi_3_uboot_version}/u-boot.bin-rpi4b.gz -O - | gunzip -c > ${DOWNLOAD_DIR}/postinstall-${1}/u-boot.bin-rpi4b
wget -v https://github.com/hexdump0815/u-boot-misc/releases/download/${raspberry_pi_3_uboot_version}/u-boot.bin-rpi3bplus.gz -O - | gunzip -c > ${DOWNLOAD_DIR}/postinstall-${1}/u-boot.bin-rpi3bplus
wget -v https://github.com/hexdump0815/u-boot-misc/releases/download/${raspberry_pi_3_uboot_version}/u-boot.bin-rpi3b.gz -O - | gunzip -c > ${DOWNLOAD_DIR}/postinstall-${1}/u-boot.bin-rpi3b

# get the bootloader blobs and dtbs
wget -v https://github.com/raspberrypi/firmware/raw/${dtb_commit}/boot/bcm2711-rpi-400.dtb -O ${DOWNLOAD_DIR}/postinstall-${1}/bcm2711-rpi-400.dtb
wget -v https://github.com/raspberrypi/firmware/raw/${dtb_commit}/boot/bcm2711-rpi-4-b.dtb -O ${DOWNLOAD_DIR}/postinstall-${1}/bcm2711-rpi-4-b.dtb
wget -v https://github.com/raspberrypi/firmware/raw/${dtb_commit}/boot/bcm2710-rpi-3-b-plus.dtb -O ${DOWNLOAD_DIR}/postinstall-${1}/bcm2710-rpi-3-b-plus.dtb
wget -v https://github.com/raspberrypi/firmware/raw/${dtb_commit}/boot/bcm2710-rpi-3-b.dtb -O ${DOWNLOAD_DIR}/postinstall-${1}/bcm2710-rpi-3-b.dtb
wget -v https://github.com/raspberrypi/firmware/raw/${boot_commit}/boot/bootcode.bin -O ${DOWNLOAD_DIR}/postinstall-${1}/bootcode.bin
wget -v https://github.com/raspberrypi/firmware/raw/${boot_commit}/boot/fixup4cd.dat -O ${DOWNLOAD_DIR}/postinstall-${1}/fixup4cd.dat
wget -v https://github.com/raspberrypi/firmware/raw/${boot_commit}/boot/fixup4.dat -O ${DOWNLOAD_DIR}/postinstall-${1}/fixup4.dat
wget -v https://github.com/raspberrypi/firmware/raw/${boot_commit}/boot/fixup4db.dat -O ${DOWNLOAD_DIR}/postinstall-${1}/fixup4db.dat
wget -v https://github.com/raspberrypi/firmware/raw/${boot_commit}/boot/fixup4x.dat -O ${DOWNLOAD_DIR}/postinstall-${1}/fixup4x.dat
wget -v https://github.com/raspberrypi/firmware/raw/${boot_commit}/boot/fixup_cd.dat -O ${DOWNLOAD_DIR}/postinstall-${1}/fixup_cd.dat
wget -v https://github.com/raspberrypi/firmware/raw/${boot_commit}/boot/fixup.dat -O ${DOWNLOAD_DIR}/postinstall-${1}/fixup.dat
wget -v https://github.com/raspberrypi/firmware/raw/${boot_commit}/boot/fixup_db.dat -O ${DOWNLOAD_DIR}/postinstall-${1}/fixup_db.dat
wget -v https://github.com/raspberrypi/firmware/raw/${boot_commit}/boot/fixup_x.dat -O ${DOWNLOAD_DIR}/postinstall-${1}/fixup_x.dat
wget -v https://github.com/raspberrypi/firmware/raw/${boot_commit}/boot/start4cd.elf -O ${DOWNLOAD_DIR}/postinstall-${1}/start4cd.elf
wget -v https://github.com/raspberrypi/firmware/raw/${boot_commit}/boot/start4db.elf -O ${DOWNLOAD_DIR}/postinstall-${1}/start4db.elf
wget -v https://github.com/raspberrypi/firmware/raw/${boot_commit}/boot/start4.elf -O ${DOWNLOAD_DIR}/postinstall-${1}/start4.elf
wget -v https://github.com/raspberrypi/firmware/raw/${boot_commit}/boot/start4x.elf -O ${DOWNLOAD_DIR}/postinstall-${1}/start4x.elf
wget -v https://github.com/raspberrypi/firmware/raw/${boot_commit}/boot/start_cd.elf -O ${DOWNLOAD_DIR}/postinstall-${1}/start_cd.elf
wget -v https://github.com/raspberrypi/firmware/raw/${boot_commit}/boot/start_db.elf -O ${DOWNLOAD_DIR}/postinstall-${1}/start_db.elf
wget -v https://github.com/raspberrypi/firmware/raw/${boot_commit}/boot/start.elf -O ${DOWNLOAD_DIR}/postinstall-${1}/start.elf
wget -v https://github.com/raspberrypi/firmware/raw/${boot_commit}/boot/start_x.elf -O ${DOWNLOAD_DIR}/postinstall-${1}/start_x.elf
