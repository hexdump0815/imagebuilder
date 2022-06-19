# allwinner h616

## bootable sd card images

- https://github.com/hexdump0815/imagebuilder/releases/tag/220618-02
- https://github.com/hexdump0815/imagebuilder/releases/tag/211204-03

## tested systems - working

- x96q h313 tv box
- tx6s h616 tv box

## untested systems

- orange pi zero 2 sbc
- other allwinner h616 based tv boxes

## kernel build notes

- https://github.com/hexdump0815/linux-mainline-and-mali-allwinner-h6-kernel/blob/master/readme.616

## u-boot build notes

- https://github.com/hexdump0815/u-boot-misc/blob/master/readme.h616

## mesa build notes

- https://github.com/hexdump0815/mesa-etc-build/blob/master/mesa-build.txt

## priority

- medium: will be worked on and improved from time to time

## special notes

- tv boxes are always hit and miss, so they might work or might not work and are usually of low quality
  - be happy in case it works for your box
  - it is impossible to support all tv boxes with their wild mix of hardware or usually quite low quality, so please do not open github issues in case the images do not work for your box
  - github issues with tested and structured information on how to get the images working on a box where they did not work out of the box are welcome
  - sound is not working, wifi, bluetooth and sometimes even ethernet might work or might not work depending on the tv box
- as allwinner socs always boot by default from sd card the emmc can safely be overwritten (but do a backup of the original android system via dd command beforehand - it might be useful later)
- a suitable dtb should be chosen in /boot/extlinux/extlinux.conf (maybe even trying them all to see which works best - default is x96q)
- panfrost opengl gpu acceleration does not seem to work completely stable yet, thus glamor is disabled for xorg (just edit the xorg conf to comment out the Option "AccelMethod" "none" line to enable panfrost)
- if panfrost is enabled there are some visual glitches visible like for instance a missing font for the input field of the login window (this seems to be better with the latest v5.18 kernel and v22.1 mesa)
- gpu accel disabled by default to be on the safe side, but should work fine if enabled
- the whole system seems to be a bit unstable depending on the hardware, it might be require to disable more of the higher freq opp points in the dtb to get more stability
- it looks like gpu frequency scaling does not work properly yet resulting in gpu errors like "gpu sched timeout", "AS_ACTIVE bit stuck" or page faults, what seems to help is to lock the gpu freq to just a single one for now by echoing a freq from /sys/class/devfreq/1800000.gpu/available_frequencies to both /sys/class/devfreq/1800000.gpu/min_freq and /sys/class/devfreq/1800000.gpu/max_freq (maybe in rc.local or similar) - 250000000 seems to work (others most probably as well)
- it looks like its a good idea to disable any power management options for the display in the power manager, as otherwise xorg seems to get into a strange state (no more xorg, but console output instead on vt7 - all this without any error or traces) when the power management kicks in
