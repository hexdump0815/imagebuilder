# amlogic meson8

## bootable sd card images

- https://github.com/hexdump0815/imagebuilder/releases/tag/230910-01
- https://github.com/hexdump0815/imagebuilder/releases/tag/230224-03
- https://github.com/hexdump0815/imagebuilder/releases/tag/210808-04
- https://github.com/hexdump0815/imagebuilder/releases/tag/200823-01

## tested systems - working

- mxq tv box (amlogic s805 based)
- mx tv box (amlogic s805 based)
- mxiii tv box (amlogic s802 based)
- mxiii tv box (amlogic s812 based)
- m8s tv box (amlogic s812 based)
- m8s+ tv box (amlogic s812 based)

## untested systems

- other amlogic s805 based tv boxes
- other amlogic s802 based tv boxes
- other amlogic s812 based tv boxes
- odroid c1 (u-boot and boot script missing in image currently for it to boot)
- odroid c1+ (u-boot and boot script missing in image currently for it to boot)

## kernel build notes

- https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/blob/lts/readme.m8x

## priority

- low: will be worked on and improved rarely

## special notes

- tv boxes are always hit and miss, so they might work or might not work and are usually of low quality
  - be happy in case it works for your box
  - it is impossible to support all tv boxes with their wild mix of hardware or usually quite low quality, so please do not open github issues in case the images do not work for your box
  - github issues with tested and structured information on how to get the images working on a box where they did not work out of the box are welcome
  - sound is not working, wifi, bluetooth and sometimes even ethernet might work or might not work depending on the tv box
- before booting the sd card the first time some adjustements are required to configure it for the type of box:
  - adjust the selected dtb in the file uEnv.ini on the boot filesystem (1st partition) - see the comments in the file
  - also in general try different dtbs of the proper type in case the box does not boot
- important: do not touch the emmc on amogic tv boxes as it contains important information to boot them at well defined places of the emmc - if this gets removed the box might no longer boot at all
  - if you want to touch your emmc you should really know what you are doing and are on your own (plus risk to brick your box) - you have been warned ...
- the meson8 mainline support is still very experimental
- since image version 230910-01 the kernel is based on this meson8 mainline based kernel tree: https://github.com/xdarklight/linux/tree/meson-mx-integration-6.2-20221226
  - the changes of that tree were back ported into the v6.1 mainline lts tree as base
  - the hdmi output is working finally with the changes in this tree, but it does not seem to work well with all hdmi display modes (so it might not work with some monitors)
  - some boxes (at least the s802 based mxiii box) seem to loose access to the sd card after a warm reboot (and will reboot into android instead), shutdown and cold boot is working fine - i think i had it working better at some point while trying to get this kernel working, but will have to try to reproduce at which state (kernel config, dtb, dvfs and gpu enabled/disabled etc.) that was
  - erhernet does not seem to work on boxes with gigabit ethernet ports, usb-ethernet is working fine on them as a workaround for now
  - lima gpu support seems to be working
