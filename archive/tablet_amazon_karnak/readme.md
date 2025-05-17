# amazon fire hd 8 2018 tablet - karnak

## bootable sd card images

- https://github.com/velvet-os/imagebuilder/releases/tag/220220-02

## tested systems - working

- amazon fire hd 8 2018 tablet - karnak

## kernel build notes

- right now i'm still using a postmarketos kernel+initrd=boot.img and will maybe later move to an own boot.img
  - https://github.com/hexdump0815/pmaports-amazon/tree/main/linux-amazon-karnak
  - https://github.com/hexdump0815/pmaports-amazon/tree/main/device-amazon-karnak

## priority

- on hold: no further activities planned so far, no more access to hardware

## special notes

- this is not very useable yet, still in a very early and experimental phase
- as there is no mainline kernel support for those devices the legacy kernel (v3.18) is used
  - there is also a v4.9 kernel for karnak, but i was not able to get it booting, maybe this is related to the older bootloader used for the unlocking
- the kernels and initramfs images are built using the postmarketos build systems (which is very nice btw.), thus the postmarketos splash screen on boot :)
- to use those the devices one needs an unlocked boot loader, so they will not work out of the box on a device
  - see: https://forum.xda-developers.com/t/unlock-root-twrp-unbrick-fire-hd-8-2018-karnak-amonet-3.3963496/ and https://forum.xda-developers.com/t/fire-hd-8-2018-only-unbrick-downgrade-unlock-root.3894256/page-57 - don't create any issues around this topic, ask in the forum there
- the unlocked bootloader on karnak is very tricky and if not a lot of care is taken it will end up being locked again easily, thus some a bit more complex procedure is required to write the boot image to the tablet as fastboot is not working and using it will result in boot loops etc.
  - just uncompress the files and write the device image to an sd card
    - write the boot.img using the following commands to the tablet
    - the tablet should be booted into twrp for this and connected via usb cable to a linux system with working adb
    - adb push boot.img /sdcard
    - adb shell dd if=/sdcard/boot.img of=/dev/block/platform/mtk-msdc.0/by-name/boot
    - adb shell sh /fix-bootpatch.sh
    - afterwards reboot via twrp ui
- it seems to be possible to also write the rootfs to the data partition on the emmc, but in this case the extend-rootfs.sh script should not be used as it does not support the special pmos partition setup yet as of now
- usb keyboard and/or mouse can be connected via usb otg (maybe hub)
  - maybe replug them if they do not work
- there is an onscreen keyboard option in the menu of the login screen and available via accessories -> onboard in the xfce session and sometimes also in the menu via the onboard icon
- virtual console terminals do not really work, it is possible to switch to them and to login, but they seem to be black on black :)
- username/password is as usual linux/changeme
- the tablet will only boot with a battery connected and charging the battery while running linux on it and using usb devices at the same time is very complicated to impossible (i at least got it to the point of draining the battery very slowly by using some special otg hub)
- shutdown with power connected seems to reboot the tablet, connecting power always boots it ... so in the end it can only charged while having linux running :)
- the display is setup in landscape mode by default for xorg, if portrait mode is desired then the monitor conf in /etc/X11/xorg.conf.d (see xorg.conf.d.samples for other examples) needs to be adjusted for the screen and /etc/udev/rules.d/90-android-touch-dev.rules for the touch screen
- as this tablet does not have that much memory (1.5gb) there are also images with armv7l 32bit userland are provided to reduce the memory usage next to the aarch64 64bit ones (the kernel is 64bit)
- the kernel builds starting with linux-amazon-karnak-3.18.19-r3 have options enabled so that docker should run on them, although a docker downgrade might be required in case of problems as the legacy kernel might be too old for the latest docker versions
