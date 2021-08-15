#!/bin/bash

# add some extra options to the kernel cmdline
sed -i 's,GRUB_CMDLINE_LINUX="",GRUB_CMDLINE_LINUX="rootwait fsck.repair=yes net.ifnames=0 ipv6.disable=1 systemd.gpt_auto=0 i915.enable_rc6=1 i915.enable_fbc=1 intel_idle.max_cstate=2 rd.driver.blacklist=i915 rd.driver.blacklist=drm rd.driver.blacklist=drm_kms_helper",g' /etc/default/grub
# the below version can be used in case the displaypanel is built in rotated
#sed -i 's,GRUB_CMDLINE_LINUX="",GRUB_CMDLINE_LINUX="rootwait fsck.repair=yes net.ifnames=0 ipv6.disable=1 systemd.gpt_auto=0 i915.enable_rc6=1 i915.enable_fbc=1 video=DSI-1:panel_orientation=right_side_up intel_idle.max_cstate=2 rd.driver.blacklist=i915 rd.driver.blacklist=drm rd.driver.blacklist=drm_kms_helper",g' /etc/default/grub
