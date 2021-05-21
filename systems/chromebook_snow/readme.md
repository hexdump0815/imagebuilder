# chromebook snow

## bootable sd card images

- https://github.com/hexdump0815/imagebuilder/releases/tag/210321-01
- https://github.com/hexdump0815/imagebuilder/releases/tag/191230-01

## tested systems - working

- samsung chromebook xe303c12 rev4 - snow
- samsung chromebook xe303c12 rev5 - snow

## tested systems - partially working

- hp chromebook 11 g1 - spring 

  - i was able to get it running using a chromeos kernel (https://github.com/hexdump0815/linux-chromeos-kernel/releases) as kpart kernel on a usb stick
  - important: this chromebook is very picky about the usb devices it will boot from, only some usb sticks for instance can be used to boot from - maybe some experimentation is required to find a proper one
  - with mainline i ended up with a black screen which is clear as there is a lot of hardware missing in the mainline exynos5250-spring.dts file (looks like it was started and never finished)
  - i'm trying to bring this dts file forward as a low priority spare time project, maybe it will work some day
  - u-boot.kpart in /boot/extra - it works but does not see any usb devices which are required to boot from as this chromebook does not have an sd card slot

## generic mainline linux on arm chromebook notes

- https://github.com/hexdump0815/linux-mainline-and-mali-on-arm-chomebooks/blob/main/readme.md

## kernel build notes

- https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/blob/master/readme.cbe
- https://github.com/hexdump0815/linux-chromeos-kernel/blob/main/readme.308
  - adjusted legacy chromeos kernel, required for spring for now

## u-boot build notes

- https://github.com/hexdump0815/u-boot-chainloading-for-arm-chromebooks/blob/master/readme.cbe

## special notes

- the usb3 is disabled as it did not work very reliable
- the webcam is not supported (it looks like the usb bus it is connected to is not yet seen by the kernel)
- after first boot please run /scripts/fix-snow-audio.sh as root to fix the ucm audio config files for the corresponding system
- the mali gpu is only supported via the legacy mali blob as it is not yet supported by the open source panfrost mali driver
- for the rev5 samsung snow chromebook the file extlinux/extlinux.conf in the second partition needs to be edited (otherwise audio will not work properly) - see the comments in the file
