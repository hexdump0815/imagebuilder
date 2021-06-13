# chromebook spring

## bootable sd card images

- https://github.com/hexdump0815/imagebuilder/releases/tag/210612-01

## tested systems - working

- hp chromebook 11 g1 - spring 

  - moved to its own chromebook_spring setup based on legacy cros kernel until it will work with mainline - afterwards it can be included into chromeboook_snow again most probably
  - i was able to get it running using a chromeos kernel (https://github.com/hexdump0815/linux-chromeos-kernel/releases) as kpart kernel on a usb stick
  - important: this chromebook is very picky about the usb devices it will boot from, only some usb sticks for instance can be used to boot from - maybe some experimentation is required to find a proper one
  - with mainline i ended up with a black screen which is clear as there is a lot of hardware missing in the mainline exynos5250-spring.dts file (looks like it was started and never finished)
  - i'm trying to bring this dts file forward as a low priority spare time project, maybe it will work some day
  - u-boot.kpart in /boot/extra - it works but does not see any usb devices which are required to boot from as this chromebook does not have an sd card slot - also it cannot boot legacy kernels (hangs with blank screen)

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

## special notes

- suspend/resume/hibernation do not work properly (at least if running from a usb device, results in filesystem errors after resume - emmc not tested yet)
- what works with the legacy kernel: nearly everything should work, i.e. sound, wifi, webcam, gles/opengl with legacy mali blob ...
- the mali gpu is only supported via the legacy mali blob as it is not yet supported by the open source panfrost mali driver (and most probably never will be due to too many hardware errata/bugs)
- the wireless connection seems to drop from time to time, reloading the wifi module usually helps to bring it back (rmmod mwifiex_sdio mwifiex; modprobe mwifiex_sdio)
- different legacy mali blob versions are available: r4p0, r5p0, r6p0, r12p0
