# raspberry pi 4

## bootable sd card images

- https://github.com/hexdump0815/imagebuilder/releases/tag/210808-03

## tested systems - working

- raspberry pi 4b

## untested systems

- raspberry pi 400

## kernel build notes

- https://github.com/hexdump0815/linux-mainline-raspberry-pi-kernel/blob/main/readme.rpi
  - mainline linux kernel
- https://github.com/hexdump0815/linux-raspberry-pi-4-kernel/blob/master/readme.64b
  - downstream raspberry pi kernel used before

## u-boot build notes

- https://github.com/hexdump0815/u-boot-misc/blob/master/readme.rpi

## special notes

- before booting the sd card the first time some adjustements are required to configure it for the type of rpi:
  - adjust the selected dtb in the file extlinux/extlinux.conf on the boot filesystem (1st partition) - see the comments in the file
