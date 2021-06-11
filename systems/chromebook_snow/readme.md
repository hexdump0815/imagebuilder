# chromebook snow

## bootable sd card images

- https://github.com/hexdump0815/imagebuilder/releases/tag/210321-01
- https://github.com/hexdump0815/imagebuilder/releases/tag/191230-01

## tested systems - working

- samsung chromebook xe303c12 rev4 - snow
- samsung chromebook xe303c12 rev5 - snow

## tested systems - partially working

- hp chromebook 11 g1 - spring 

  - moved to its own chromebook_spring setup based on legacy cros kernel until it will work with mainline - afterwards it can be included here again most probably
  - i was able to get it running using a chromeos kernel (https://github.com/hexdump0815/linux-chromeos-kernel/releases) as kpart kernel on a usb stick
  - important: this chromebook is very picky about the usb devices it will boot from, only some usb sticks for instance can be used to boot from - maybe some experimentation is required to find a proper one
  - with mainline i ended up with a black screen which is clear as there is a lot of hardware missing in the mainline exynos5250-spring.dts file (looks like it was started and never finished)
  - i'm trying to bring this dts file forward as a low priority spare time project, maybe it will work some day
  - u-boot.kpart in /boot/extra - it works but does not see any usb devices which are required to boot from as this chromebook does not have an sd card slot

## generic mainline linux on arm chromebook notes

- https://github.com/hexdump0815/linux-mainline-on-arm-chromebooks/blob/main/readme.md

## kernel build notes

- https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/blob/master/readme.cbe
- https://github.com/hexdump0815/linux-chromeos-kernel/blob/main/readme.308
  - adjusted legacy chromeos kernel, required for spring for now

## u-boot build notes

- https://github.com/hexdump0815/u-boot-chainloading-for-arm-chromebooks/blob/master/readme.cbe

## special notes

- active support from google for the snow chromebooks (samsung xe303c12) ended beginning of 2019, so they might be around for cheap
- they are very nice to use with linux: small, light (just a bit above 1kg), battery lasts for 4-6 hours at least
- what does not work with mainline:
  - usb3 port gives trouble with suspend, so i disabled it
  - webcam will not work (the usb bus it is connected to is somehow not seen in mainline)
  - 3g modem (if installed) will not work (situation similar to the webcam i guess, no idea if there even exists a driver for it)
  - full suspend/resume/hibernation do not work properly, so suspend to idle is configured by default and seems to work perfectly and the chromebook should survive about a day in this state from battery
- what works: everything else, i.e. sound, wifi, external monitor, gles/opengl with legacy mali blob
- the mali gpu is only supported via the legacy mali blob as it is not yet supported by the open source panfrost mali driver (and most probably never will be due to too many hardware errata/bugs)
- after first boot please run /scripts/fix-snow-audio.sh as root to fix the ucm audio config files for the corresponding system
- for the rev5 samsung snow chromebook the file extlinux/extlinux.conf in the second partition needs to be edited (otherwise audio will not work properly) - see the comments in the file
- do not lower the display unused value (at xfce -> settings -> power manager -> display -> brightness reduction) below about 35% as at some point it is simply black (even above 0% already)
- the wireless connection seems to drop from time to time, reloading the wifi module usually helps to bring it back (rmmod mwifiex_sdio mwifiex; modprobe mwifiex_sdio)
- different legacy mali blob versions are available: r4p0, r5p0, r6p0, r12p0
