# using tow boot for the odroid c2, c4 and n2

it is possible to use tow boot as boot loader on the mentioned odroid devices
(tested so far only with an odroid n2, but it should work on the c2 and c4
for which there is a towboot build as well too).

for more information about tow boot please have a look at
- https://tow-boot.org/
- https://github.com/Tow-Boot/Tow-Boot
- https://tow-boot.org/devices/odroid-C2.html
- https://tow-boot.org/devices/odroid-C4.html
- https://tow-boot.org/devices/odroid-N2.html

the method described here is the so called "shared storage strategy" where tow
boot simply is being written as boot loader at the beginning of the sd card.
for the odroid n2 there is also the option to write it to the spi - for this
option please have a look at the tow boot documentation.

first get the latest version of tow boot for the board it should be installed
from https://github.com/Tow-Boot/Tow-Boot/releases and unpack it. inside of
the distribution archive a file called "shared.disk-image.img" can be found.
this file has to be written to the sd card via the following command:
```
dd if=/xyz/shared.disk-image.img of=/dev/sd-card-device bs=512 seek=1 skip=1
```

at the next boot tow boot should be used and that should use the boot
configuration defined in /boot/extlinux/extlinux.conf (i.e.
/extlinux/extlinux.conf on the first partitioni) on the sd card.
