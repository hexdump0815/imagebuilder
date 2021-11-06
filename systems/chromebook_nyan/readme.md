# chromebook nyan

## bootable sd card images

- https://github.com/hexdump0815/imagebuilder/releases/tag/210724-01
- https://github.com/hexdump0815/imagebuilder/releases/tag/210613-02
- https://github.com/hexdump0815/imagebuilder/releases/tag/210321-01
- https://github.com/hexdump0815/imagebuilder/releases/tag/200526-01

## tested systems - working

- acer chromebook cb5 311 - nyan big
- acer chromebook 13 c810 - nyan big

## untested systems

- hp chromebook 14 g3 - nyan blaze
  - never seen one of those, but at least there is a dtb for it in the mainline kernel

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

## special notes

- this system stays on the linux v5.4 kernel for now as later mainline kernels have problems with the display initialization
- when switching nyan chromebooks into developer mode for the first time an error might occur (something with executing some command showing an error in the top left of the screen) - just wait 10+ minutes and if nothing happens, just turn off the chromebook and on restart it will switch into developer mode again automatically and this time it should succeed
- most things seem to work more or less (suspend/resume and the gpu are the most troublesome areas)
- there are two sets of images provided: one using a v5.4 mainline kernel (with not really useable suspend/resume) and another with av3.10 legacy cromeos kernel (with working suspend/resume but the kernel is no longer maintained)
  - if suspend/resume is urgently required the legacy kernel might be the only useable option (i had some problems with the keyboard and touchpad not working anymore in x11 after resume even with the legacy kernel with ubuntu focal - but i also saw it working in this setup)
  - if not the mainline kernel version should be used
  - both image types contain both kernels (the other kernel tar.gz file is located in /boot/extra) and can be converted into each other with a hand full of commands (will add them here soon)
  - to make it useable with both kernels the root filesystems uses ext4 and not btrfs like those images here usually as the btrfs support in the legacy kernel is too old to be really useable
- there are several versions of the nyan big available: 2g/4g ram and hd/full hd display
  - the 4gb/full hd i have is working well
  - the 2gb/hd i have is working well, but the u-boot output is not visible as u-boot does not seem to be able to initialize the display properly (a lot of screen flickering) - as a result one has to type the number at the boot prompt blindly at the right time for now :)
  - the 2gb model requires a different u-boot to be written to the first partition after the image was written to the sd card (the default u-boot in the image is for the 4gb version) - the u-boot image to be written can be found in the extra folder of the boot partition or can be downloaded from here (gunzip first before writing it to the first partition): https://github.com/hexdump0815/u-boot-chainloading-for-arm-chromebooks/releases/download/v2021.07-rc4-cbt/uboot.kpart.cbt-2g.gz
- sometimes the initial kernel console output stays blank but xorg will start well after a while - this seems to affect the v5.10 and newer kernels (seems to get worse with each version - maybe related to fw_devlink dependencies during parallel probing at boot), the v5.4 kernel seems to be much more reliable in this respect (this is why the nyan images were reverted back to use the v5.4 kernel for now)
- some nyan big related issue with some info: https://github.com/hexdump0815/imagebuilder/issues/6
- the nouveau gpu driver does not work too well (artifacts sometimes and glmark2 haengs at some point with memory allocation problems on the 4gb model) and is thus disabled by default
- for the nouveau mesa opengl driver a newer version of the xorg server is required
- the thermal cpu throttling is not working yet and the cpu frequency is limited to 1.7 ghz in /etc/rc.local for now to avoid automatic shutdown due to overheating in case of constant full load (a patch to improve this somewhat will be in future kernels)
- with the mainline kernel after suspend/resume the display is not properly reenabled
  - there is an ugly hack implemented to bring it back via xrandr hook (see: https://github.com/hexdump0815/imagebuilder/blob/main/systems/chromebook_nyan/extra-files/lib/systemd/system-sleep/mrvl-and-edp-reload )
- deep suspend does not seem work with the mainline kernel and the suspend to idle (s2idle) used in the images so far does not seem to save a lot of energy (it drained about 50% of the battery in around 5 hours)
- hibernation (suspend to disk) does not seem to work with the mainline kernel neither, it at least fails to restore the display on resume and maybe even crashes (no more details due to missing serial console)
- the write protect screw of the cb5 311 (nyan-big) is not that easy to find: there is a screw marked 'jp10' on the board, this one has to be removed und the metal sticker has to be peeled off in order to remove the hardware write protection
- especially the acer cb5 311 chromebook (nyan-big) seems to have problems with battery calibration and quite often thinks that the battery is daed after it had not been used for a while - one possible solution might be the following:
  - unplug the power
  - use a paperclip or a needle and push iabout 5-10 seconds into the small hole in the bottom of the device
  - let it sit unpowered for about 5-10 minutes
  - plug in the power
  - battery will hopefully be back afterwards, maybe charging it over night might be required to bring it back
  - see also: https://www.youtube.com/watch?v=NfhgnxUJoZo
  - if that does not help, then most probably the battery is beyond its end of life
  - in case the battery is really dead: it looks like the battery of the acer cb3 111 chromebook (intel) can also be used in the nyan chromebook (cb5 311) - that one has only 3 (vs 4) cells and thus a lower voltage and capacity, but the nyan seems to deal well with this (ifixit also lists this battery as compatible with the acer cb5 311: https://www.ifixit.com/Store/PC-Laptop/Acer-AC14B18J-Laptop-Battery/IF352-003?o=2#)
