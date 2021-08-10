#!/bin/bash

# add some extra options to the kernel cmdline
sed -i 's,GRUB_CMDLINE_LINUX="",GRUB_CMDLINE_LINUX="rootwait fsck.repair=yes net.ifnames=0 ipv6.disable=1",g' /etc/default/grub
