# amazon fire hd 10 2017 tablet - suez

## bootable sd card images

- https://github.com/hexdump0815/imagebuilder/releases/tag/231113-05
- https://github.com/hexdump0815/imagebuilder/releases/tag/211101-04

## tested systems - working

- amazon fire hd 10 2017 tablet - suez

## kernel build notes

- right now i'm still using a postmarketos kernel+initrd=boot.img and will maybe later move to an own boot.img
  - https://github.com/hexdump0815/pmaports-amazon/tree/main/linux-amazon-suez
  - https://github.com/hexdump0815/pmaports-amazon/tree/main/device-amazon-suez

## priority

- low: will be worked on and improved rarely, another try to get native wifi working or otherwise some cheap usb wifi will be included in the kernel config, otherwise not much left to be done due to legacy kernel

## special notes

- this is not very useable yet, still in a very early and experimental phase
- as there is no mainline kernel support for those devices the legacy kernel (v3.18) is used
- the kernels and initramfs images are built using the postmarketos build systems (which is very nice btw.), thus the postmarketos splash screen on boot :)
- to use those the devices one needs an unlocked boot loader, so they will not work out of the box on a device
  - see: https://forum.xda-developers.com/t/unlock-root-twrp-unbrick-fire-hd-10-2017-suez.3913639/ and https://forum.xda-developers.com/t/hd-10-2017-offline-rooting.3734860/ - don't create any issues around this topic, ask in the forum there
  - once the bootloader is unlocked better avoid to start fireos (the amazon android) and in case you end up with it running absolutely avoid connecting to any kind of wifi or other network and even more avoid updating fireos, as it might undo the bootloader unlocking and it might also make it impossible to unlock it again anymore afterwards
- after unlocking the bootlöoader and installing twrp it can be reached on boot when booting with the right volume button and power button pressed together for a few seconds and then releasing only the power button and keeping the volume button pressed until twrp has started
- just uncompress the files, write the boot.img to boot_x via fastboot with the unlocked bootloader via twrp, write the device image to an sd card
- the steps to flash the linux kernel as boot image in detail (working fastboot on the hostsystem required for this):
  - twrp -> reboot -> boot into hacked bl -> small text appears in the corner of the screen
  - connect to computer and check if device is visible with "fastboot devices"
  - fastboot flash boot_x tablet_amazon_ford-boot.img (IMPORTANT: boot_x and not boot!)
  - shutdown via power button
  - boot (a sd card with the written image has to be in the tablet already at this point)
- not recommended: it seems to be possible to also write the rootfs to the data partition on the emmc, but in this case the extend-rootfs.sh script should not be used as it does not support the special pmos partition setup yet as of now and in general it is recommended to not touch the emmc partitions except one really knows what one is doing
- usb keyboard and/or mouse can be connected via usb otg (maybe hub)
  - maybe replug them if they do not work
- there is an onscreen keyboard option in the menu of the login screen and available via accessories -> onboard in the xfce session and sometimes also in the menu via the onboard icon
- virtual console terminals do not really work, it is possible to switch to them and to login, but they seem to be black on black :)
- sound seem to work in principle (via alsaucm enadev even switching between headphones and speakers is working), but there is still quite a bit of improvement required to get it fully working (see todo file)
- username/password is as usual linux/changeme
- the tablet will only boot with a battery connected and charging the battery while running linux on it and using usb devices at the same time is very complicated to impossible (i at least got it to the point of draining the battery very slowly by using some special otg hub)
- shutdown with power connected seems to reboot the tablet, connecting power always boots it ... so in the end it can only charged while having linux running :)
- the display is setup in landscape mode by default for xorg, if portrait mode is desired then the monitor conf in /etc/X11/xorg.conf.d (see xorg.conf.d.samples for other examples) needs to be adjusted for the screen and /etc/udev/rules.d/90-android-touch-dev.rules for the touch screen
- as this tablet does not have that much memory (2gb) there are also images with armv7l 32bit userland are provided to reduce the memory usage next to the aarch64 64bit ones (the kernel is 64bit)
- the kernel builds starting with linux-amazon-suez-3.18.19-r6 have options enabled so that docker should run on them, although a docker downgrade might be required in case of problems as the legacy kernel might be too old for the latest docker versions
