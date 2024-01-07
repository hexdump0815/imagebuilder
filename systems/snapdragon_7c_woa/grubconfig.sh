#!/bin/bash

# add some extra options to the kernel cmdline - not really used here yet as some special grup is used for now
sed -i 's,GRUB_CMDLINE_LINUX="",GRUB_CMDLINE_LINUX="rootwait fsck.repair=yes net.ifnames=0 ipv6.disable=1 systemd.gpt_auto=0 efi=novamap,noruntime clk_ignore_unused pd_ignore_unused console=tty0 ignore_loglevel noresume deferred_probe_timeout=30 apparmor=0",g' /etc/default/grub
