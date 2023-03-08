# amlogic meson8

## bootable sd card images

- https://github.com/hexdump0815/imagebuilder/releases/tag/230224-03
- https://github.com/hexdump0815/imagebuilder/releases/tag/210808-04
- https://github.com/hexdump0815/imagebuilder/releases/tag/200823-01

## tested systems - working

- mxq tv box (amlogic s805 based)

## untested systems

some more work will be required to make the devices below working

- amlogic s805 based tv boxes
- amlogic s802 based tv boxes
- amlogic s812 based tv boxes
- odroid c1
- odroid c1+

## kernel build notes

- https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/blob/master/readme.av7
- https://github.com/hexdump0815/linux-mainline-and-mali-amlogic-kernel/blob/master/readme.m8x

## priority

- on hold: no further activities planned so far, maybe this will change when hdmi support hits mainline

## special notes

- tv boxes are always hit and miss, so they might work or might not work and are usually of low quality
  - be happy in case it works for your box
  - it is impossible to support all tv boxes with their wild mix of hardware or usually quite low quality, so please do not open github issues in case the images do not work for your box
  - github issues with tested and structured information on how to get the images working on a box where they did not work out of the box are welcome
  - sound is not working, wifi, bluetooth and sometimes even ethernet might work or might not work depending on the tv box
- before booting the sd card the first time some adjustements are required to configure it for the type of box:
  - adjust the selected dtb in the file extlinux/extlinux.conf on the boot filesystem (1st partition) - see the comments in the file
  - also in general try different dtbs of the proper type in case the box does not boot
- important: do not touch the emmc on amogic tv boxes as it contains important information to boot them at well defined places of the emmc - if this gets removed the box might no longer boot at all
  - if you want to touch your emmc you should really know what you are doing and are on your own (plus risk to brick your box) - you have been warned ...
- the meson8 mainline support is still very experimental
- the hdmi output is not yet supported (so only serial console is possible for now)
