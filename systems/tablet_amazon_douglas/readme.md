# amazon fire hd 8 2017 tablet - douglas

## bootable sd card images

- https://github.com/hexdump0815/imagebuilder/releases/tag/211101-03

## tested systems - working

- amazon fire hd 8 2017 tablet - douglas

## kernel build notes

- right now i'm still using a postmarketos kernel+initrd=boot.img and will maybe later move to an own boot.img
  - https://github.com/hexdump0815/pmaports-amazon/tree/main/linux-amazon-douglas
  - https://github.com/hexdump0815/pmaports-amazon/tree/main/device-amazon-douglas

## special notes

- this is not very useable yet, still in a very early and experimental phase
- as there is no mainline kernel support for those devices the legacy kernel (v3.18) is used
- the kernels and initramfs images are built using the postmarketos build systems (which is very nice btw.), thus the postmarketos splash screen on boot :)
- to use those the devices one needs an unlocked boot loader, so they will not work out of the box on a device
  - see: https://forum.xda-developers.com/t/unlock-root-twrp-unbrick-fire-hd-8-2017-douglas.3962846/ - don't create any issues around this topic, ask in the forum there
- just uncompress the files, write the boot.img to boot_x via fastboot with the unlocked bootloader via twrp, write the device image to an sd card
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
- wifi seems to work by using the android firmware and tools in a minimal android bionic chroot env
  - wifi can be stated via /scripts/start-wifi.sh
  - uncomment the start of this script in /etc/rc.local in case wifi should be enabled by default
  - wifi support was added in february 2022, so all images from before do not have it yet but it can be added easily afterwards
- the kernel builds starting with linux-amazon-douglas-3.18.19-r8 have options enabled so that docker should run on them, although a docker downgrade might be required in case of problems as the legacy kernel might be too old for the latest docker versions
