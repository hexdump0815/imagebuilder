# intel 64bit atom systems with 32bit uefi bios

## bootable sd card images

- none yet

## tested systems - working

- chuwi vi8 plus windows 10 / android tablet
- dell venue 8 pro windows 10 tablet (model 5830 only)

## untested systems

- there might be various other windwos 10 / android tablets which may work with this image

## kernel build notes

- the regular debian/ubuntu distribution kernel is used in this case, so no kernel build required
- https://github.com/hexdump0815/linux-mainline-x86-64-kernel/blob/main/readme.d8p
  - old special kernel for the dell venue 8 pro which seems to no longer be required

## special notes

- to change the screen orientation to landscape mode by default /etc/lightdm/lighdm.conf needs to be adjusted by uncommenting the corresponding shell script for supported devices
- bluetooth and the cameras are not supported yet
- be careful with the micro-usb connector as it is the rare type-a version into which a type-b plug can easily inserted the wrong way around which most probably would kill the device
- there is a lot of information about running linux on this device at https://www.studioteabag.com/science/dell-venue-pro-linux/
