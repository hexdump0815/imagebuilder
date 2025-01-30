#!/bin/bash

# install the qcom tools qrtr-ns and rmtfs
apt-get -y install qrtr-tools rmtfs

# adjust the cmdline of rmtfs to read its files from /lib/firmware/rmtfs
sed -i 's,ExecStart=/usr/bin/rmtfs -r -P -s,ExecStart=/usr/bin/rmtfs -r -s -v -o /lib/firmware/rmtfs,g' /lib/systemd/system/rmtfs.service

# avoid updates of the rmtfs package so that the above change does not get overwritten
apt-mark hold rmtfs
