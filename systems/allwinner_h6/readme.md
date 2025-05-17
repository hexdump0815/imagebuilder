# allwinner h6

## bootable sd card images

- https://github.com/velvet-os/imagebuilder/releases/tag/230930-01
- https://github.com/velvet-os/imagebuilder/releases/tag/230222-01
- https://github.com/velvet-os/imagebuilder/releases/tag/220617-01
- https://github.com/velvet-os/imagebuilder/releases/tag/211230-01
- https://github.com/velvet-os/imagebuilder/releases/tag/210805-03

## tested systems - working

- eachlink mini h6 tv box
- qplus h6 tv box

## untested systems

- other allwinner h6 based tv boxes

some more work will be required to make the devices below working

- orangepi 3
- pine64 h64
- pine64 h64b

## kernel build notes

- https://github.com/hexdump0815/linux-mainline-and-mali-allwinner-h6-kernel/blob/master/readme.ah6

## u-boot build notes

- https://github.com/hexdump0815/u-boot-misc/blob/master/readme.h6

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
  - sound, wifi, bluetooth and sometimes even ethernet might work or might not work depending on the tv box
- as allwinner socs always boot by default from sd card the emmc can safely be overwritten (but do a backup of the original android system via dd command beforehand - it might be useful later)
- there are some allwinner h6 tv boxes which cannot detect the size of the memory properly (they detect more memory than there is) and others cannot detect a connected hdmi monitor properly - to make the images working with most devices the two kernel cmdline parameters are set bydefault to overcome those problems: "mem=2048M video=HDMI-A-1:e" - those options can be omitted in case a box is working well to utilize the full amount of memory and the automatic hdmi monitor detection
- there are graphics errors due to problems with the self compiled mesa version being used on the image (the lightdm login screen is distorted and the login to the xfce session does not seem to work at all on the ubuntu images) - installing a hopefully more stable newer self compiled version of mesa to /opt/mesa should hopefully fix this - in generel: if gpu accel is required, the bullseye image is definitely the better choice
  - panfrost is disabled by default now to be on the safe side
