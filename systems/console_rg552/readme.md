# console rg552

## bootable sd card images

- not available now

## tested systems - working

- anberic rg552
  - see also: https://github.com/hexdump0815/imagebuilder/issues/276

_likely won't work on other devices_

## kernel build notes

- https://github.com/thenameisluk/linux-rk3xxx-kernel/blob/main/readme.rg552

## u-boot build notes

- https://github.com/thenameisluk/u-boot-rk3xxx-bootloader/blob/main/readme.rg552

## priority

- medium: will be worked on and improved from time to time

## special notes

- the system comes with [joypad](https://github.com/thenameisluk/joypad-for-debian/) preinstalled, it can be remove with ```sudo apt purge joypad```
    - joypad let's you type with left joystick and 4 action buttons (X/Y/A/B)
    - all key combinations can be found [here](https://github.com/thenameisluk/joypad-for-debian/)
    - examples:
        - login (linux): down-right+Y right+A down-left+X right+X down+A
        - password (changeme) down+B up-right+B up-left+Y down-left+X up-right+y up+X down-left+A up+X
        - enter : B
    - you can also use right joystick and R1/L1 as mouse
- device might take a moment after holding power button to give sign of life (green led lightning up and screen turning on)
- if you take sd out of your device make sure the device isn't suspended
    - if you do it anyway and device has ussues booting
    - put your sd into another computer and run```sudo btrfs rescue super-recover -v /dev/sd?4``` on it
    - _Note. replace ? with correct letter, this might work but might not_
- built-in fan speed can be controlled with script inside ```/scripts/fan-speed```
- device might sometimes get stuck running /init
  - unless filesystem is corrupted, simply restarting the device should resolve the issue