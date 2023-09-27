#!/bin/bash

# install some required qcom tools
apt-get -y install protection-domain-mapper qrtr-tools rmtfs tqftpserv

# install some tools required to prepare bootable kernels
apt-get -y install abootimg mkbootimg
