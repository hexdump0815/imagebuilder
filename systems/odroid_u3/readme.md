# odroid u3, u2, x2, x, u

## bootable sd card images

- https://github.com/hexdump0815/imagebuilder/releases/tag/220824-01
- https://github.com/hexdump0815/imagebuilder/releases/tag/220612-02
- https://github.com/hexdump0815/imagebuilder/releases/tag/210803-01
- https://github.com/hexdump0815/imagebuilder/releases/tag/210508-01

## tested systems - working

- odroid u3+
- odroid u3
- odroid u2
- odroid u
- odroid x2
- odroid x

## untested systems

- looks like there is none of them left :)

## kernel build notes

- https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/blob/master/readme.exy

## u-boot build notes

- https://github.com/hexdump0815/u-boot-misc/blob/master/readme.exy

## mesa build notes

- https://github.com/hexdump0815/mesa-etc-build/blob/master/mesa-build.txt

## priority

- medium: will be worked on and improved from time to time

## special notes

- for the odroid x2 the file extlinux/extlinux.conf in the first partition needs to be edited - see the comments in the file
- for the odroid x the file extlinux/extlinux.conf in the first partition needs to be edited - see the comments in the file
- a fixed ether mac address is set in the same file and can be changed if multiple such devices are running in the same network or omitted to get a new random ethernet mac address on each boot
- the odroid u3 (and the others most probably too) seems to be very sensitive to stable power supply, so if you see strange crashes on boot, check if the power supply is good enough
- s2idle and deep suspend seem to be working at least on the odroid u3 (the others were not tested yet), resume is done via the physical button (tested with v5.19.1 on debian bullseye, but it was already working before as well - hibernation not tested this time, but could be that it was tested to be working back then, so it might even be working too)
- there is a thread on the odroid forums about running mainline on the odroid u3 at https://forum.odroid.com/viewtopic.php?f=55&t=3691&sid=1a9bcfd371f8be232c2620b64bad2150&start=450
- for a working edid file for a 1280x720 screen resolution see https://forum.odroid.com/viewtopic.php?p=329241&sid=7a49d9e1a9c91ee32c46bf6dc64c5b47#p329241
- for a patched libc to make widevine working see https://forum.odroid.com/viewtopic.php?p=329192&sid=7a49d9e1a9c91ee32c46bf6dc64c5b47#p329192
- for a precompiled kodi with hw accel to use with this image please see https://forum.odroid.com/viewtopic.php?p=329945&sid=7a49d9e1a9c91ee32c46bf6dc64c5b47#p329945
- some notes on running the image on the odroid u: https://github.com/hexdump0815/imagebuilder/issues/39
