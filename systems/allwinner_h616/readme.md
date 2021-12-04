# allwinner h616

## bootable sd card images

- none yet

## tested systems - working

- x96q h313 tv box

## untested systems

- orange pi zero 2 sbc
- other allwinner h616 based tv boxes

## kernel build notes

- https://github.com/hexdump0815/linux-mainline-and-mali-allwinner-h6-kernel/blob/master/readme.616

## u-boot build notes

- https://github.com/hexdump0815/u-boot-misc/blob/master/readme.h616

## special notes

- tv boxes are always hit and miss, so they might work or might not work and are usually of low quality
  - be happy in case it works for your box
  - it is impossible to support all tv boxes with their wild mix of hardware or usually quite low quality, so please do not open github issues in case the images do not work for your box
  - github issues with tested and structured information on how to get the images working on a box where they did not work out of the box are welcome
  - sound is not working, wifi, bluetooth and sometimes even ethernet might work or might not work depending on the tv box
- as allwinner socs always boot by default from sd card the emmc can safely be overwritten (but do a backup of the original android system via dd command beforehand - it might be useful later)
- panfrost opengl gpu acceleration does not seem to work well yet, thus glamor is disabled for xorg
