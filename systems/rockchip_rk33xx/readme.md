# rockchip rk3318, rk3328, rk3399

## bootable sd card images

- https://github.com/velvet-os/imagebuilder/releases/tag/230930-02
- https://github.com/velvet-os/imagebuilder/releases/tag/230220-05
- https://github.com/velvet-os/imagebuilder/releases/tag/220821-01
- https://github.com/velvet-os/imagebuilder/releases/tag/220616-01
- https://github.com/velvet-os/imagebuilder/releases/tag/210805-02
- https://github.com/velvet-os/imagebuilder/releases/tag/200702-01

## tested systems - working

- pinebook pro rk3399
- h96max rk3318 tv box
- t9 rk3328 tv box

## untested systems

- other rockchip rk3318 or rk3328 tv boxes

some more work will be required to make the devices below working

- pine64 rock64
- rockpi 4a
- rockpi 4b
- nanopi m4
- nanopi m4v2
- orangepi 4
- rockchip rk3399 tv boxes

## kernel build notes

- https://github.com/hexdump0815/linux-mainline-and-mali-rockchip-rk33xx-kernel/blob/master/readme.rkc
- https://github.com/hexdump0815/linux-rockchip-rk33xx-kernel/blob/master/readme.rkc

## u-boot build notes

- https://github.com/hexdump0815/u-boot-misc/blob/master/readme.rkc

## mesa build notes

- https://github.com/hexdump0815/mesa-etc-build/blob/master/mesa-build.txt

## priority

- medium: will be worked on and improved from time to time

## special notes

- on the pinebook pro it is assumed that towboot is installed in the spi
- on the pinebook pro s2idle and deep suspend are working (tested with v5.19.1 and towboot)
- tv boxes are always hit and miss, so they might work or might not work and are usually of low quality
  - be happy in case it works for your box
  - names do not mean anything for tv boxes: two boxes with the same name and look might be identical inside, slightly different (often wifi, bt, memory and or emmc/nand chips) or completely different (different socs, nand instead of emmc, fake specs like 1gb ram and 8gb nand instead of 4gb ram and 32gb emmc) - all three options are possible even if they were bought together at the same time at the same place
  - it is impossible to support all tv boxes with their wild mix of hardware or usually quite low quality, so please do not open github issues in case the images do not work for your box
  - github issues with tested and structured information on how to get the images working on a box where they did not work out of the box are welcome
  - sound is not working, wifi, bluetooth and sometimes even ethernet might work or might not work depending on the tv box
- before booting the sd card the first time some adjustements are required to configure it for the type of box:
  - all tv boxes: adjust the selected dtb in the file extlinux/extlinux.conf on the boot filesystem (1st partition) - see the comments in the file
  - if the selected dtb results in a kernel crash on boot or instability, try to use the h96max-rk3318 dtb as it does clock the cpu at lower frequencies
  - also in general try different dtbs of the proper type in case the box does not boot
- important: do not touch the emmc on rockchip tv boxes as it contains important information to boot them at well defined places of the emmc - if this gets removed the box might no longer boot at all
  - if you want to touch your emmc you should really know what you are doing and are on your own (plus risk to brick your box) - you have been warned ...
- alternatively there is also excellent support for rk3318 and rk3328 tv boxes as armbian csc: https://forum.armbian.com/topic/17597-csc-armbian-for-rk3318-tv-box-boards/
- some things relevant for the pinebook pro:
  - it looks like wifi will not come up properlyafter a reboot, doing a full cold shutdown and a poweron instead seems to work
  - for updating the keyboard/touchpad firmware please have a look at: https://wiki.postmarketos.org/index.php?title=PINE64_Pinebook_Pro_(pine64-pinebookpro)&mobileaction=toggle_view_desktop#Updating_the_keyboard_and_touchpad_firmware - for this the libusb-1.0.0-dev needs to be installed on debian (and i guess on ubuntu too)
