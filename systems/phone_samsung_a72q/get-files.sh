# this file is supposed to be sourced by the get-files shell script

samsung_a72q_release_version="5.19.0-stb-a72%2B"

rm -f ${DOWNLOAD_DIR}/kernel-phone_samsung_a72q-${2}.tar.gz
wget -v https://github.com/hexdump0815/linux-mainline-qcom-kernel/releases/download/${samsung_a72q_release_version}/${samsung_a72q_release_version}.tar.gz -O ${DOWNLOAD_DIR}/kernel-phone_samsung_a72q-${2}.tar.gz

# get the firmware and related files to get wifi and other things working - maybe an option for the future ...
#wget -v https://github.com/hexdump0815/imagebuilder-firmware/raw/main/phone-samsung-a72q-firmware.tar.gz -O ${DOWNLOAD_DIR}/postinstall-${1}/phone-samsung-a72q-firmware.tar.gz
