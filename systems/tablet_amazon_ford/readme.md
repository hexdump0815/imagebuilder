# amazon fire 7 2015 tablet - ford

## bootable sd card images

- https://github.com/hexdump0815/imagebuilder/releases/tag/211101-01

## tested systems - working

- amazon fire 7 2015 tablet - ford

## kernel build notes

- https://github.com/hexdump0815/linux-amazon-mt8127-kernel/blob/master/readme.f27
- right now i'm still using a postmarketos kernel+initrd=boot.img and will maybe later move to an own boot.img
  - https://github.com/hexdump0815/pmaports-amazon/tree/main/linux-amazon-ford
  - https://github.com/hexdump0815/pmaports-amazon/tree/main/device-amazon-ford

## special notes

- this is not very useable yet, still in a very early and experimental phase
- as there is no mainline kernel support for those devices the legacy kernel (v3.10) is used
- the kernels and initramfs images are built using the postmarketos build systems (which is very nice btw.), thus the postmarketos splash screen on boot :)
- to use those the devices one needs an unlocked boot loader, so they will not work out of the box on a device
  - see: https://forum.xda-developers.com/t/unlock-root-twrp-unbrick-downgrade-fire-7-ford-and-austin.3899860/ - don't create any issues around this topic, ask in the forum there
- just uncompress the files, write the boot.img to boot via fastboot with the unlocked bootloader via twrp, write the device image to an sd card
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
