# raspberry pi 3

## bootable sd card images

- https://github.com/hexdump0815/imagebuilder/releases/tag/210808-02

## tested systems - working

- raspberry pi 3b

## untested systems

- raspberry pi 3b+

## kernel build notes

- https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/blob/master/readme.av8

## u-boot build notes

- https://github.com/hexdump0815/u-boot-misc/blob/master/readme.rpi

## mesa build notes

- https://github.com/hexdump0815/mesa-etc-build/blob/master/mesa-build.txt

## priority

- low: will be worked on and improved rarely, hardware not that interesting anymore nowadays, well supported elsewhere too

## special notes

- before booting the sd card the first time some adjustements are required to configure it for the type of rpi:
  - adjust the selected dtb in the file extlinux/extlinux.conf on the boot filesystem (1st partition) - see the comments in the file
