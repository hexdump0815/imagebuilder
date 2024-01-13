#!/bin/bash

# install the qcom tools qrtr-ns and rmtfs
apt-get -y install protection-domain-mapper qrtr-tools rmtfs tqftpserv

# make sure those are enabled
systemctl enable msm-firmware-loader.service
systemctl enable msm-firmware-loader-unpack.service
# those seem to be not required on this system - maybe they should not be installed at all
systemctl disable pd-mapper.service
systemctl disable rmtfs.service

# install some tools required to prepare bootable kernels
apt-get -y install abootimg mkbootimg

# add some dummy firmware files to make firmware loading work in some setups
#mkdir -p /lib/firmware/rmtfs
#dd if=/dev/zero bs=1M count=2 of=/lib/firmware/rmtfs/modem_fs1
#dd if=/dev/zero bs=1M count=2 of=/lib/firmware/rmtfs/modem_fs2
#dd if=/dev/zero bs=1M count=2 of=/lib/firmware/rmtfs/modem_fsg
#dd if=/dev/zero bs=1M count=2 of=/lib/firmware/rmtfs/modem_fsc

# adjust the cmdline of rmtfs to read its files from /lib/firmware/rmtfs
# maybe this can be avoided by putting the dummy files from above to the
# default location /boot but some early tests did not work - might be worth
# to retest this
#sed -i 's,ExecStart=/usr/bin/rmtfs -r -P -s,ExecStart=/usr/bin/rmtfs -r -s -v -o /lib/firmware/rmtfs,g' /lib/systemd/system/rmtfs.service

# avoid updates of the rmtfs package so that the above change does not get overwritten
#apt-mark hold rmtfs
