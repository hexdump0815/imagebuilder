# allwinner h616

## bootable sd card images

- https://github.com/velvet-os/imagebuilder/releases/tag/230910-02
- https://github.com/velvet-os/imagebuilder/releases/tag/230222-02
- https://github.com/velvet-os/imagebuilder/releases/tag/220618-02
- https://github.com/velvet-os/imagebuilder/releases/tag/211204-03

## tested systems - working

- x96q h313 tv box
- tx6s h616 tv box
- t95max h618 tv box

## untested systems

- orange pi zero 2 sbc
- orange pi zero 3 sbc
- other allwinner h616 and h618 based tv boxes

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
  - names do not mean anything for tv boxes: two boxes with the same name and look might be identical inside, slightly different (often wifi, bt, memory and or emmc/nand chips) or completely different (different socs, nand instead of emmc, fake specs like 1gb ram and 8gb nand instead of 4gb ram and 32gb emmc) - all three options are possible even if they were bought together at the same time at the same place
  - it is impossible to support all tv boxes with their wild mix of hardware or usually quite low quality, so please do not open github issues in case the images do not work for your box
  - github issues with tested and structured information on how to get the images working on a box where they did not work out of the box are welcome
  - sound is not working, wifi, bluetooth and sometimes even ethernet might work or might not work depending on the tv box
- as allwinner socs always boot by default from sd card the emmc can safely be overwritten (but do a backup of the original android system via dd command beforehand - it might be useful later)
- a suitable dtb should be chosen in /boot/extlinux/extlinux.conf (maybe even trying them all to see which works best - default is x96q)
- in the extra dir of the boot partition are a few different boot block options which might be worth a try - for h618 based tv boxes boot-allwinner_h616-axp313a.dd might work - those boot blocks have to be written via "dd if=boot-xyz.dd of=/dev/sd_card_device bs=512 seek=1 skip=1" to the sd card after writing the image to it
- there seem to be newer (as 2022 or newer maybe) h313/h616 tv boxes which use lpddr3/lpddr4 memory and partially also slightly different soc versions and thuse will not boot at all with those images here for now (see https://oftc.irclog.whitequark.org/linux-sunxi/2023-03-27#32013409 and arround for more info)
- panfrost opengl gpu acceleration does not seem to work completely stable yet, thus it is disabled by default
- if panfrost is enabled there are some visual glitches visible like for instance a missing font for the input field of the login window, this should be no longer relevant for the newwer images
- if the whole system seems to be a bit unstable depending on the hardware, it might be require to disable more of the higher freq opp points in the dtb to get more stability (see experimental box dtb section below)
- it looks like gpu frequency scaling does not work properly yet resulting in gpu errors like "gpu sched timeout", "AS_ACTIVE bit stuck" or page faults, what seems to help is to lock the gpu freq to just a single one - see the corresponding section in /etc/rc.local
- it looks like its a good idea to disable any power management options for the display in the power manager, as otherwise xorg seems to get into a strange state (no more xorg, but console output instead on vt7 - all this without any error or traces) when the power management kicks in
- there are some experimental box dtb files for three voltage levels: around normal voltage levels, 30mv and 60mv overvoltage added
  - the higher the overvoltage the higher is the chance it will work on lower quality socs at the cost of shorter lifetime, higher temperature and higher energy consumption
  - the cpu freqs for those box dtb files is limited to 1.2 ghz by default to make it hopefully run with the lowest quality devices, this limit can be raised in /etc/rc.local to whatever is possible to still get a stable system (instability might mean a non booting system or the system crashin after a few days in the end)
  - a good procedure is to start with the 60mv dtb and if it is stable either go to the 30mv or normal dtb (if low temperature, energy consumption and long life time is the goal) or to start raising the max cpu freq (if max performance is the goal) - both approaches can also be mixed to end up somewhere in the middle or in case the soc is of higher quality, i.e. going from 60mv to 30mv after still being stable at 1.8ghz and then raising the max cpu freq again ...
