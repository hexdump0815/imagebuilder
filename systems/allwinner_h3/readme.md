# allwinner a20 and h3

## bootable sd card images

- https://github.com/hexdump0815/imagebuilder/releases/tag/231126-01
- https://github.com/hexdump0815/imagebuilder/releases/tag/210808-01

## tested systems - working

- banana pi m1
- r39 start h3 tv box
- tx1 h3 tv box

## untested systems

some more work will be required to make the devices below working

- various orangepi h3 sbc's
- various nanopi h3 sbc's
- other allwinner h3 based tv boxes

## kernel build notes

- https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/blob/master/readme.av7

## u-boot build notes

- https://github.com/hexdump0815/u-boot-misc/blob/master/readme.bpi
- https://github.com/hexdump0815/u-boot-misc/blob/master/readme.h3

## mesa build notes

- https://github.com/hexdump0815/mesa-etc-build/blob/master/mesa-build.txt

## priority

- on hold: no more changes planned and it is unlikely that there will be images beyond the bookworm ones

## special notes

- tv boxes are always hit and miss, so they might work or might not work and are usually of low quality
  - be happy in case it works for your box
  - names do not mean anything for tv boxes: two boxes with the same name and look might be identical inside, slightly different (often wifi, bt, memory and or emmc/nand chips) or completely different (different socs, nand instead of emmc, fake specs like 1gb ram and 8gb nand instead of 4gb ram and 32gb emmc) - all three options are possible even if they were bought together at the same time at the same place
  - it is impossible to support all tv boxes with their wild mix of hardware or usually quite low quality, so please do not open github issues in case the images do not work for your box
  - github issues with tested and structured information on how to get the images working on a box where they did not work out of the box are welcome
  - sound, wifi, bluetooth and sometimes even ethernet might work or might not work depending on the tv box
- the image will boot by default on a banana pi m1, for other systems the corresponding u-boot from the /boot/extra directory has to be written to disk
- as allwinner socs always boot by default from sd card the emmc can safely be overwritten (but do a backup of the original android system via dd command beforehand - it might be useful later)
- at least the r39 u-boot seems to be far from perfect as sometimes it needs a few tries to boot successfully, also using the sd card on my r39 box seems to be unreliable - it works with u-boot only on some small sd card and everything else on usb
