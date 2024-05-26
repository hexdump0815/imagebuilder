# bouffalo lab bl808

## bootable sd card images

- https://github.com/hexdump0815/imagebuilder/releases/tag/240525-01

## tested systems - working

- sipeed m1s dock

## untested systems

- pine64 ox64 (should work)

## kernel build notes

- https://github.com/hexdump0815/linux-mainline-bouffalo-lab-bl808-kernel/blob/main/readme.obl

## u-boot build notes

- https://github.com/hexdump0815/linux-mainline-bouffalo-lab-bl808-kernel/blob/main/readme.u-boot

## mesa build notes

- not required as no gpu and too little memory

## priority

- medium: some first experiments with a useable riscv64 sbc

## special notes

- all this is very much wip and not that useable yet
- if you do not yet have such a bl808 device, better get one of the milk-v duo boards instead as its specs, performance and potential future support are better, it looks like nobody is working on bl808 support anymore, currently some aspects of the hardware are supported to some degree only or not at all
- the flashing process is described here quite well: https://wiki.postmarketos.org/wiki/Sipeed_M1s_DOCK_(sipeed-m1sdock)
- those boards seem to be quite picky about sd cards - if one does not boot, try another one - older and smaller ones might work better
- booting seems to be sometimes unreliable, partially due to serial console noise in u-boot
- the usb-serial console uses an unusual high speed of 2000000 instead of the usual 115200 and as a result not all usb serial devices can handle it properly - it seems to be possible to switch it to 115200 - see https://github.com/openbouffalo/buildroot_bouffalo/pull/17/
- usb seems to only work reliable in usb 1.1 mode, i even got some of those broken dm9601 usb ethernet adapters working on the m1s (usb 2.0 or higher devices always only resulted in usb errors and no working device)
- wifi is working with some special setup - see https://github.com/bouffalolab/blwnet_xram for details - in the image the required files are located in /opt/blwnet and it is not enabled by default as it seems to be a bit fragile from time to time (i got some kernel crashes in some situations), but in general it seems to work
- for now ext4 is used as root fs as btrfs with compression as usual for those images does not make sense on such a low power system
- as installing packages is way slower than deleting them on those small devices the build tools are preinstalled already and can easily be removed via /scripts/remove-buildtools.sh if not needed
- more info coming soon
