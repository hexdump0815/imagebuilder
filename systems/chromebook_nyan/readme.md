# chromebook nyan

## bootable sd card images

- https://github.com/hexdump0815/imagebuilder/releases/tag/230915-02
- https://github.com/hexdump0815/imagebuilder/releases/tag/230218-04
- https://github.com/hexdump0815/imagebuilder/releases/tag/220611-01
- https://github.com/hexdump0815/imagebuilder/releases/tag/211114-01
- https://github.com/hexdump0815/imagebuilder/releases/tag/210724-01 (with legacy images)
- https://github.com/hexdump0815/imagebuilder/releases/tag/210613-02
- https://github.com/hexdump0815/imagebuilder/releases/tag/210321-01
- https://github.com/hexdump0815/imagebuilder/releases/tag/200526-01

## tested systems - working

- acer chromebook cb5 311 - nyan big
- acer chromebook 13 c810 - nyan big
- hp chromebook 14 g3 - nyan blaze

see also https://github.com/hexdump0815/imagebuilder/issues/79 for all above

## untested systems

- maybe there are more nyan models which were not tested yet

## generic mainline linux on arm chromebook notes

- https://github.com/hexdump0815/linux-mainline-on-arm-chromebooks/blob/main/readme.md

## kernel build notes

- https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/blob/master/readme.cbt
- https://github.com/hexdump0815/linux-mainline-tegra-k1-kernel/blob/master/readme.cbt
  - older v5.4 mainline kernel
- https://github.com/hexdump0815/linux-chromeos-kernel/blob/main/readme.310
  - adjusted legacy chromeos kernel

## u-boot build notes

- https://github.com/hexdump0815/u-boot-chainloading-for-arm-chromebooks/blob/master/readme.cbt

## mesa build notes

- https://github.com/hexdump0815/mesa-etc-build/blob/master/mesa-build.txt

## priority

- medium: will be worked on and improved from time to time

## special notes

- when switching nyan chromebooks into developer mode for the first time an error might occur (something with executing some command showing an error in the top left of the screen) - just wait 10+ minutes and if nothing happens, just turn off the chromebook and on restart it will switch into developer mode again automatically and this time it should succeed
- most things seem to work more or less (suspend/resume and the gpu are the most troublesome areas)
- there are two sets of images provided: one using a v5.x mainline kernel (with not really useable suspend/resume) and another with a v3.10 legacy cromeos kernel (with working suspend/resume but the kernel is no longer maintained)
  - if suspend/resume is urgently required the legacy kernel might be the only useable option (i had some problems with the keyboard and touchpad not working anymore in x11 after resume even with the legacy kernel with ubuntu focal - but i also saw it working in this setup)
  - if not the mainline kernel version should be used
  - both image types contain both kernels (the other kernel tar.gz file is located in /boot/extra) and can be converted into each other with a hand full of commands (will add them here soon)
  - to make it useable with both kernels the root filesystems uses ext4 and not btrfs like those images here usually as the btrfs support in the legacy kernel is too old to be really useable
  - for information about using the legacy kernel with legacy gpu drivers please have a look at https://github.com/hexdump0815/imagebuilder/issues/174
- there are several versions of the nyan big available: 2g/4g ram and hd/full hd display
  - the 4gb/full hd i have is working well
  - the 2gb/hd i have is working well, but the u-boot output is not visible as u-boot does not seem to be able to initialize the display properly (a lot of screen flickering or a black screen) - as a result one has to type the number at the boot prompt blindly at the right time for now :)
  - the 2gb model requires a different u-boot to be written to the first partition after the image was written to the sd card (the default u-boot in the image is for the 4gb version) - the u-boot image to be written can be found in the extra folder of the boot partition or can be downloaded from here (gunzip first before writing it to the first partition): https://github.com/hexdump0815/u-boot-chainloading-for-arm-chromebooks/releases/tag/v2021.10-cbt
  - in case of a lot of screen flickering in the u-boot stage there is a "-noflicker" version of the u-boot, which should show a black screen instead of the crazy flickering
- some nyan blaze notes:
  - for the nyan blaze the same u-boot can be used as for the nyan big (depending on the memory in the system the 2gb or 4gb version)
  - sound still needs a bit of config work, but in principle it can be made working
  - the legacy image should work out of the box for the nyan blaze
- on the u-boot prompt there are three possible options:
  - 1: linux-big - nyan big with the 1366x768 screen
  - 2: linux-big-fhd - nyan big with the full hd 1920x1080 screen
  - 3: linux-blaze - nyan blaze with the 1366x768 screen (not sure if there is maybe a full hd version of the blaze as well?)
- the default boot blocks installed for the image are for the 4gb model and the default dtb selected is the lower res nyan-big model - not sure if this combination really exists, but one can easily choose the second option (linux-big-fhd) in the u-boot menu to boot for the full hd model and for all other combinations new bootblocks will have to be written and the extlinux.conf file has to be adjusted anyway
- some nyan big related issue with some info: https://github.com/hexdump0815/imagebuilder/issues/6
- for more info about xorg gpu support see doc/xorg-and-nouveau.md
- for more info about the suspend/resume topic see doc/suspend-resume.md
- the thermal cpu throttling was not working with older kernels and the cpu frequency was limited to 1.7 ghz in /etc/rc.local to avoid automatic shutdown due to overheating in case of constant full load (fixed for v5.18+ kernels)
- in the past (up to including debian bullseye and ubuntu focal) display gamma and color profile settings (night/red shift mode, display color calibration etc.) were not working at all on arm systems and it seems like starting with debian bookworm it is now working on systems with the proper support for it - sadly on this system it is not supported as the kernel support for it seems to be missing
- the write protect screw of the cb5 311 (nyan-big) is not that easy to find: there is a screw marked 'jp10' on the board, this one has to be removed und the metal sticker has to be peeled off in order to remove the hardware write protection
- especially the acer cb5 311 chromebook (nyan-big) seems to have problems with battery calibration and quite often thinks that the battery is dead after it had not been used for a while - one possible solution might be the following:
  - unplug the power
  - use a paperclip or a needle and push about 5-10 seconds into the small hole in the bottom of the device
  - let it sit unpowered for about 5-10 minutes
  - plug in the power
  - battery will hopefully be back afterwards, maybe charging it over night might be required to bring it back
  - see also: https://www.youtube.com/watch?v=NfhgnxUJoZo
  - if that does not help, then most probably the battery is beyond its end of life which seems to be the case for many of them in 2022+
  - in case the battery is really dead: it looks like the battery of the acer cb3 111 chromebook (intel) can also be used in the nyan chromebook (cb5 311) - that one has only 3 (vs 4) cells and thus a lower voltage and capacity, but the nyan seems to deal well with this (ifixit also lists this battery as compatible with the acer cb5 311: https://www.ifixit.com/Store/PC-Laptop/Acer-AC14B18J-Laptop-Battery/IF352-003?o=2#)
- it looks like putting the nyan big into battery disconnect mode seems to work with the paperclip procedure described above as well, as after pushing that little button for about 5-10 seconds the chromebook will no longer power on without a power supply connected (neither via power button nor by opening the lid) - it is recommended to do this before storing the device for a longer time to avoid battery drain ... looks like this only works with an original cb3 111 battery in the nyan and not with the original nyan one and also not with third party batteries
- it looks a bit like the original nyan batteries have some planned obsolescence built in as close to all of my nyan batteries died at about the same time now, always with the voltage going below the limit at which charging would still happen - otherwise the batteries were all looking well (no ballooning etc.)
- how to use the legacy kernel instead of the mainline one:
  - dd the image to an sd card
  - mount partition 4 of it somewhere (example: /mnt) and partition 3 at boot below it (example: /mnt/boot)
  - go to the mounted root (example: cd /mnt)
  - unpack the legacy kernel: tar xzf boot/extra/kernel-chromebook_nyan-legacy.tar.gz
  - dd the kpart kernel (vmlinux.kpart-3.10.18-cos-r91) to the first partition of the sd card
  - umount everything mounted before
  - try to boot that sd card
