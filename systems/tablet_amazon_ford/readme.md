# amazon fire 7 2015 tablet - ford

## bootable sd card images

- https://github.com/hexdump0815/imagebuilder/releases/tag/231113-01
- https://github.com/hexdump0815/imagebuilder/releases/tag/211101-01

## tested systems - working

- amazon fire 7 2015 tablet - ford

## kernel build notes

- https://github.com/hexdump0815/linux-amazon-mt8127-kernel/blob/master/readme.f27
- right now i'm still using a postmarketos kernel+initrd=boot.img and will maybe later move to an own boot.img
  - https://github.com/hexdump0815/pmaports-amazon/tree/main/linux-amazon-ford
  - https://github.com/hexdump0815/pmaports-amazon/tree/main/device-amazon-ford

## priority

- on hold: no more changes planned and it is unlikely that there will be images beyond the bookworm ones

## special notes

- this is not very useable yet, still in a very early and experimental phase
- as there is no mainline kernel support for those devices the legacy kernel (v3.10) is used
- the kernels and initramfs images are built using the postmarketos build systems (which is very nice btw.), thus the postmarketos splash screen on boot :)
- to use those the devices one needs an unlocked boot loader, so they will not work out of the box on a device
  - see: https://forum.xda-developers.com/t/unlock-root-twrp-unbrick-downgrade-fire-7-ford-and-austin.3899860/ - don't create any issues around this topic, ask in the forum there
  - once the bootloader is unlocked better avoid to start fireos (the amazon android) and in case you end up with it running absolutely avoid connecting to any kind of wifi or other network and even more avoid updating fireos, as it might undo the bootloader unlocking and it might also make it impossible to unlock it again anymore afterwards
- after unlocking the bootlöoader and installing twrp it can be reached on boot when booting with the left volume button and power button pressed together for a few seconds and then releasing only the power button and keeping the volume button pressed until twrp has started
- just uncompress the files, write the boot.img to boot via fastboot with the unlocked bootloader via twrp (a reboot into twrp and power down in it is required afterwards to patch the boot partition properly), write the device image to an sd card
- the steps to flash the linux kernel as boot image in detail (working fastboot on the hostsystem required for this):
    - twrp -> reboot -> boot into hacked bl -> small text appears in the corner of the screen
    - connect to computer and check if device is visible with "fastboot devices"
    - fastboot flash boot tablet_amazon_ford-boot.img
    - shutdown via power button
    - boot into twrp -> reboot -> power off
    - boot (a sd card with the written image has to be in the tablet already at this point)
- not recommended: it seems to be possible to also write the rootfs to the data partition on the emmc, but in this case the extend-rootfs.sh script should not be used as it does not support the special pmos partition setup yet as of now and in general it is recommended to not touch the emmc partitions except one really knows what one is doing
- usb keyboard and/or mouse can be connected via usb otg (maybe hub)
  - maybe replug them if they do not work
- there is an onscreen keyboard option in the menu of the login screen and available via accessories -> onboard in the xfce session and sometimes also in the menu via the onboard icon
- virtual console terminals seem to work
- username/password is as usual linux/changeme
- the focal image seems to reboot as soon as the touch screen is touched (needs some debugging), better use the bullseye image for now
- the tablet will only boot with a battery connected and charging the battery while running linux on it and using usb devices at the same time is very complicated to impossible (i at least got it to the point of draining the battery very slowly by using some special otg hub)
- shutdown with power connected seems to reboot the tablet, connecting power always boots it ... so in the end it can only charged while having linux running :)
- there is some minimal opengl support via some legacy mali blob possible (there are scripts to download the mali blob and gl4es in /scripts - then export LD_LIBRARY_PATH=/opt/gl4es...:/opt/mali... and export LIBGL_FB=3 and some simple programs like glxgears will use the gpu, some programs work, some not)
- the display is setup in landscape mode by default for xorg, if portrait mode is desired then the monitor conf in /etc/X11/xorg.conf.d (see xorg.conf.d.samples for other examples) needs to be adjusted for the screen and /etc/udev/rules.d/90-android-touch-dev.rules for the touch screen
- wifi seems to work by using the android firmware and tools in a minimal android bionic chroot env
  - wifi can be stated via /scripts/start-wifi.sh
  - uncomment the start of this script in /etc/rc.local in case wifi should be enabled by default
  - wifi support was added in february 2022, so all images from before do not have it yet but it can be added easily afterwards
- there is also a 9th generation 2019 version of the fire 7 tablet, which is not recommended as most of the devices produced from 2020 on cannot get their bootloader unlocked and getting a kernel version working for it seems to be quite complicated as well
