# chromebook snow

## bootable sd card images

- https://github.com/hexdump0815/imagebuilder/releases/tag/230924-01
- https://github.com/hexdump0815/imagebuilder/releases/tag/230220-01
- https://github.com/hexdump0815/imagebuilder/releases/tag/220619-01
- https://github.com/hexdump0815/imagebuilder/releases/tag/210725-02
- https://github.com/hexdump0815/imagebuilder/releases/tag/210613-04
- https://github.com/hexdump0815/imagebuilder/releases/tag/210321-01
- https://github.com/hexdump0815/imagebuilder/releases/tag/191230-01

## tested systems - working

- samsung chromebook xe303c12 rev4 - snow
- samsung chromebook xe303c12 rev5 - snow

see also https://github.com/hexdump0815/imagebuilder/issues/78 for all above

## tested systems - partially working

- hp chromebook 11 g1 - spring 
  - moved to its own chromebook_spring setup based on legacy cros kernel until it will work with mainline - afterwards it can be included here again most probably

## generic mainline linux on arm chromebook notes

- https://github.com/hexdump0815/linux-mainline-on-arm-chromebooks/blob/main/readme.md

## kernel build notes

- https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/blob/master/readme.cbe
- https://github.com/hexdump0815/linux-chromeos-kernel/blob/main/readme.308
  - adjusted legacy chromeos kernel, required for spring for now

## u-boot build notes

- https://github.com/hexdump0815/u-boot-chainloading-for-arm-chromebooks/blob/master/readme.cbe

## priority

- low: will be worked on and improved rarely, too old hardware without mainline gpu support

## special notes

- active support from google for the snow chromebooks (samsung xe303c12) ended beginning of 2019, so they might be around for cheap
- they are very nice to use with linux: small, light (just a bit above 1kg), battery lasts for 4-6 hours at least
- it looks like he snow chromebooks from 2014 on are rev5, but i'm not sure at which point in time exactly the switch between rev4 and rev5 is - end of 2012 is definitely rev4 (and the very early ones seem to even be buggy - see below) and early 2013 is rev4 as well
- please be aware that there seems to be an early batch of snow chromebooks which are not running stable with a mainline kernel, but are running well with a legacy chromeos based kernel - looks like some hardware problem, which was silently fixed in the chromeos kernel but never made it to mainline - this problem has been observed on a snow chromebook from october 2012 and on one from january 2013, so i guess it affects the first ones from end of 2012 and beginning of 2013 - see: https://github.com/hexdump0815/imagebuilder/issues/63
- what does not work with mainline:
  - usb3 might be unreliable, connecting devices through a usb2 hub seems to be a possible workaround in case of problems
  - 3g modem (not tested)
  - before version 210725-02 full suspend/resume/hibernation do not work properly, so suspend to idle is configured by default and seems to work perfectly and the chromebook should survive about a day in this state from battery
  - for all images starting with version 210725-02 full deep suspend/resume should work fine
- what works: everything else, i.e. sound, wifi, external hdmi monitor (broken with the v6.1.51 kernel, use the v6.1.59 kernel instead), gles/opengl with legacy mali blob
- the current sound setup is more a hack than something real, but for basic stuff it seems to work
- sound seems to be gone after resume from suspend, if it is really required it might be considered to switch to s2idle for suspend in /etc/rc.local
- the mali gpu is only supported via the legacy mali blob as it is not yet supported by the open source panfrost mali driver (and most probably never will be due to too many hardware errata/bugs)
- starting with the v6.1 kernels the legacy mali support has been dropped, so if it is really required it is recommended to use the v5.15 lts kernel which still has it and should be supported for quite some time as well
- after first boot please run /scripts/fix-snow-audio.sh as root to fix the ucm audio config files for the corresponding system and reboot
- for the rev5 samsung snow chromebook the file extlinux/extlinux.conf in the second partition needs to be edited (otherwise audio will not work properly) - see the comments in the file
- do not lower the display unused value (at xfce -> settings -> power manager -> display -> brightness reduction) below about 35% as at some point it is simply black (even above 0% already)
- the wireless connection seems to drop from time to time, reloading the wifi module usually helps to bring it back (rmmod mwifiex_sdio mwifiex; modprobe mwifiex_sdio)
- different legacy mali blob versions are available: r4p0, r5p0, r6p0, r12p0
- in the past (up to including debian bullseye and ubuntu focal) display gamma and color profile settings (night/red shift mode, display color calibration etc.) were not working at all on arm systems and it seems like starting with debian bookworm it is now working on systems with the proper support for it - sadly on this system it is not supported as the kernel support for it seems to be missing
- the snow chromebooks seem to not boot properly with all sd cards ... if booting does not work it might be worth to try different sd cards ... older and smaller ones seem to have the higher chance to work well
- the battery of the snow chromebook (xe303c12) seems to be interchangable with the battery of the peach pit chromebook (xe503c12)
- it looks like some snow chromebooks (maybe some rev5 ones) seem to have an atmel touchpad instead of the usual cyapa one - see https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/issues/6 for a kernel patch and the other referenced issue in this one
- how to use the legacy kernel instead of the mainline one:
  - dd the image to an sd card
  - mount partition 4 of it somewhere (example: /mnt) and partition 3 at boot below it (example: /mnt/boot)
  - go to the mounted root (example: cd /mnt)
  - unpack the legacy kernel: tar xzf boot/extra/kernel-chromebook_snow-legacy.tar.gz
  - dd the kpart kernel (vmlinux.kpart-3.10.38-cos-r91) to the first partition of the sd card
  - umount everything mounted before
  - try to boot that sd card
