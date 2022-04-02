# amlogic gxb, gxl, gxm, g12a, g12b and sm1

## bootable sd card images

- https://github.com/hexdump0815/imagebuilder/releases/tag/210805-01

## tested systems - working

- odroid c2 (gxbb)
- a95x f3 tv box (g12a)

## untested systems

- amlogic s905 based tv boxes (gxbb)
- amlogic s905x based tv boxes (gxl)
- amlogic s905w based tv boxes (gxl)
- amlogic s912 based tv boxes (gxm)
- amlogic s905x2 based tv boxes (g12a)
- amlogic s905x3 based tv boxes (sm1)

some more work will be required to make the devices below working

- nanopi k2 (gxbb)
- odroid c4 (sm1)
- odroid n2 (g12b)
- odroid n2+ (g12b)
- amlogic s922x based tv boxes (g12b)

## kernel build notes

- https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/blob/master/readme.av8
- https://github.com/hexdump0815/linux-mainline-and-mali-amlogic-kernel/blob/master/readme.aml

## u-boot build notes

- https://github.com/hexdump0815/u-boot-misc/blob/master/readme.gxb
- https://github.com/hexdump0815/u-boot-misc/blob/master/readme.gxl
- https://github.com/hexdump0815/u-boot-misc/blob/master/readme.gxy

## priority

- medium: will be worked on and improved from time to time

## special notes

- tv boxes are always hit and miss, so they might work or might not work and are usually of low quality
  - be happy in case it works for your box
  - it is impossible to support all tv boxes with their wild mix of hardware or usually quite low quality, so please do not open github issues in case the images do not work for your box
  - github issues with tested and structured information on how to get the images working on a box where they did not work out of the box are welcome
  - sound is not working, wifi, bluetooth and sometimes even ethernet might work or might not work depending on the tv box
- for booting from sd card on amlogic tv boxes some special preparation will be required
  - get a tooth pick (or something simlar), try to find the boot switch (usually in the audio out port) and get a feeling for pushing and releasing this button with the tooth pick
  - put the sd card with the image written to it into the sd card slot of the tv box
  - press the boot switch button with the tooth pick and keep it pressed
  - power on the tv box
  - wait until it seems to have restarted at least two times on the screen
  - release the boot switch
  - it should now boot from the sd card or at least not boot the internal android any more as long as the sd card isin the slot
  - if it does not, try to power off and on the box
  - if still not, repeat the above steps until it works or you give up at some point
- before booting the sd card the first time some adjustements are required to configure it for the type of box:
  - gxbb and gxl: on the root filesystem (2nd partition) copy /etc/X11/xorg.conf.d.samples/13-lima-meson.conf to /etc/X11/xorg.conf.d to make xorg start properly
  - all tv boxes: adjust the selected dtb in the file extlinux/extlinux.conf on the boot filesystem (1st partition) - see the comments in the file
  - if for g12a the t95q dtb or for sm1 the h96max-x3 dtb result in a kernel crash on boot or instability, try to use the sei520/sei610 dtbs as they do clock the cpu at lower frequencies
  - also in general try different dtbs of the proper type in case the box does not boot
- important: do not touch the emmc on amlogic tv boxes as it contains important information to boot them at well defined places of the emmc - if this gets removed the box will no longer boot at all
  - if you want to touch your emmc you should really know what you are doing and are on your own (plus risk to brick your box) - you have been warned ...
- alternatively there is also support for amlogic socs in alpine linux at: https://git.alpinelinux.org/aports/tree/testing/linux-amlogic/
- there is also a page about amlogic tv boxes in the manjaro wiki: https://wiki.manjaro.org/index.php/Amlogic_TV_boxes
