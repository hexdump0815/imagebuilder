# console x55

## bootable sd card images

- not available now

## tested systems - working

- powkiddy x55
  - see also: https://github.com/hexdump0815/imagebuilder/issues/266

_likely won't work on other devices_

## kernel build notes

- https://github.com/thenameisluk/linux-rk3xxx-kernel/blob/main/readme.x55

## u-boot build notes

- https://github.com/thenameisluk/u-boot-rk3xxx-bootloader/blob/main/readme.x55

## priority

- medium: will be worked on and improved from time to time

## special notes

- the system comes with [joypad](https://github.com/thenameisluk/joypad-for-debian) preinstalled, it can be remove with ```sudo apt purge joypad```
    - joypad-x55 let's you type with left joystick and 4 action buttons (X/Y/A/B)
    - all key combinations can be found [here](https://github.com/thenameisluk/joypad-for-debian#type)
    - examples:
        - login (linux): down-right+Y right+A down-left+X right+X down+A
        - password (changeme) down+B up-right+B up-left+Y down-left+X up-right+y up+X down-left+A up+X
        - enter : B
    - you can also use right joystick and R1/L1 as mouse
    - joypad can be toggled of by pressing volume up and down button at the same time so you can play games
- as long as we use wifi fix patch, bluetooth won't work
- device might take a moment after holding power button to give sign of life (green led lightning up and screen turning on)
- if you take sd out of your device make sure the device isn't suspended
    - if you do it anyway and device has ussues booting
    - put your sd into another computer and run```sudo btrfs rescue super-recover -v /dev/sd?4``` on it
    - _Note. replace ? with correct letter, this might work but might not_
- the device can be undervolted in order to extend battery life
  - by uncommenting FDTOVERLAYS in ```/boot/extlinux/extlinux.conf```
  - there are 3 levels of undervoltating 1-3 (+1 when it's not enabled)
  - the higher level the longer battery life should be at cost of performance