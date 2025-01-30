#!/bin/bash

# install the qcom tools qrtr-ns and rmtfs
apt-get -y install qrtr-tools tqftpserv

# make sure those are enabled
systemctl enable msm-firmware-loader.service
systemctl enable msm-firmware-loader-unpack.service

# install some tools required to prepare bootable kernels
apt-get -y install abootimg mkbootimg
