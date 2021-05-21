# odroid u3, u2, x2, x, u

## bootable sd card images

- https://github.com/hexdump0815/imagebuilder/releases/tag/210508-01

## tested systems - working

- odroid u3
- odroid u2
- odroid x2
- odroid x

## untested systems

- odroid u

## kernel build notes

- https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/blob/master/readme.exy

## u-boot build notes

- https://github.com/hexdump0815/u-boot-misc/blob/master/readme.exy

## special notes

- for the odroid x2 the file extlinux/extlinux.conf in the first partition needs to be edited - see the comments in the file
- for the odroid x the file extlinux/extlinux.conf in the first partition needs to be edited - see the comments in the file
- a fixed ether mac address is set in the same file and can be changed if multiple such devices are running in the same network or omitted to get a new random ethernet mac address on each boot
