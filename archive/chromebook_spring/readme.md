# chromebook spring

## bootable sd card images

- https://github.com/velvet-os/imagebuilder/releases/tag/210726-01
- https://github.com/velvet-os/imagebuilder/releases/tag/210612-01

## tested systems - working

- hp chromebook 11 g1 - spring 

## generic mainline linux on arm chromebook notes

- https://github.com/hexdump0815/linux-mainline-on-arm-chromebooks/blob/main/readme.md

## kernel build notes

- https://github.com/hexdump0815/linux-chromeos-kernel/blob/main/readme.308
  - adjusted legacy chromeos kernel, required for spring for now
- https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/blob/master/readme.cbe
  - mainline kernel, hopefully working at some point in the future on spring too

## u-boot build notes

- https://github.com/hexdump0815/u-boot-chainloading-for-arm-chromebooks/blob/master/readme.cbe
  - mainline u-boot, hopefully working at some point in the future on spring too

## priority

- on hold: no further activities planned so far, mainline support is in bad shape, too old hardware without mainline gpu support, no more access to hardware

## special notes

- i was able to get it running using a chromeos kernel (https://github.com/hexdump0815/linux-chromeos-kernel/releases) as kpart kernel on a usb stick
- important: this chromebook is very picky about the usb devices it will boot from, only some usb sticks for instance can be used to boot from - maybe some experimentation is required to find a proper one
- with mainline i ended up with a black screen which is clear as there is a lot of hardware missing in the mainline exynos5250-spring.dts file (looks like it was started and never finished)
- i'm trying to bring this dts file forward as a low priority spare time project, maybe it will work some day
- u-boot.kpart in /boot/extra - it works but does not see any usb devices which are required to boot from as this chromebook does not have an sd card slot - also it cannot boot legacy kernels (hangs with blank screen)
- suspend/resume/hibernation do not work properly even with the chromeos kernel (at least if running from a usb device, results in filesystem errors after resume - if running from emmc only it seems to work fine)
- what works with the legacy kernel: nearly everything should work, i.e. sound, wifi, webcam, gles/opengl with legacy mali blob ...
- the mali gpu is only supported via the legacy mali blob as it is not yet supported by the open source panfrost mali driver (and most probably never will be due to too many hardware errata/bugs)
- the wireless connection seems to drop from time to time, reloading the wifi module usually helps to bring it back (rmmod mwifiex_sdio mwifiex; modprobe mwifiex_sdio)
- different legacy mali blob versions are available: r4p0, r5p0, r6p0, r12p0
- at least my spring seems to have a problem with rather quick battery drain if it is not connected to power for a few days, not sure if its a general problem or only affects mine (looks like it drained more when a usb device was connected when turned off, but not sure if this really makes a difference)
