# orbsmart s92, beelink r89, tronsmart orion r28, ubox tv box

## bootable sd card images

- https://github.com/hexdump0815/imagebuilder/releases/tag/230222-05
- https://github.com/hexdump0815/imagebuilder/releases/tag/220825-01
- https://github.com/hexdump0815/imagebuilder/releases/tag/220612-03
- https://github.com/hexdump0815/imagebuilder/releases/tag/210803-03
- https://github.com/hexdump0815/imagebuilder/releases/tag/210509-02

## tested systems - working

- orbsmart s92 tv box

## untested systems

- beelink r89
  - should just work as i think its the exact same hardware
- tronsmart orion r28
  - should just work as i think its the exact same hardware
- ubox tv box
  - should just work as i think its nearly the same hardware

## kernel build notes

- https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/blob/master/readme.av7

## u-boot build notes

the boot loader of those tv boxes seems to be encrypted and locked and thus cannot be easily replaced, but there is a properly signed etc. boot block which can get regular linux kernel booting - i have adjusted some scripts around this to create a boot block in the proper format from a mainline linux kernel, dtb and initrd at:

- https://github.com/hexdump0815/imagebuilder/tree/main/systems/orbsmart_s92_beelink_r89/extra-files/boot/r89-boot

## mesa build notes

- https://github.com/hexdump0815/mesa-etc-build/blob/master/mesa-build.txt

## priority

- medium: will be worked on and improved from time to time

## special notes

- bluetooth currently does not work, it seems to hang the system when trying to enable it via cmdline tool
- see /boot/r89-boot for the special boot preparation setup required for this tv box
- it looks like this tv box even supports s2idle and deep suspend (tested with v5.19.4 on debian bookworm, but i guess it should work for other setups as well) - to wake it up from suspend just shortly press the power button
- there is excellent support for another type of rk3288 tv box as armbian csc: https://forum.armbian.com/topic/7141-csc-armbian-for-rk3288-tv-box-boards-q8/
- while we are at it, there is also excellent support for rk3228 and rk3229 tv boxes as armbian csc too: https://forum.armbian.com/topic/12656-csc-armbian-for-rk322x-tv-boxes/
