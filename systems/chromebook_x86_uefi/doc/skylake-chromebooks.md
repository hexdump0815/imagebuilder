# special setup required for skylake chromebooks

## overview

this has only been tested with a chell chromebook (hp chromebook 13 g1) so far
and other skylake chromebooks might need some extra setup. the first thing
required will be to remove the wp screw and install the uefi bios from
https://mrchromebox.tech/ ... i also tried the rw uefi payload approach which
seems to be working well for apollo and gemini lake chromebooks, but it does
not seem to work on skylake based devices and thus the full uefi firmware will
have to be flashed.

one thing special about skylake based chromebooks is that audio seems to be
broken for mainline kernels starting with or after v5.13 (i did not find any
information about anyone who got it working with newer kernels).

## getting audio to work

first one needs to install a kernel with working audio for those devices - a
precompiled v5.10 kernel (latest lts version with working audio on those
devices which will be supported until at least end of 2026) can be downloaded
from here:
https://github.com/hexdump0815/linux-mainline-x86-64-kernel/releases/tag/5.10.162-stb-skl%2B

after installing this kernel via:
```
cd /
tar xzf /wherever/ 5.10.162-stb-skl+.tar.gz
update-initramfs -c -k  5.10.162-stb-skl+
update-grub
```
some firmware and audio configuration files have to be installed which can be
obtained from here:
https://github.com/hexdump0815/imagebuilder-firmware/raw/main/chell-audio.tar.gz
via:
```
cd /
tar xzf /wherever/chell-audio.tar.gz
```

after a reboot the newly installed v5.10 kernel should be booted once by hand
in grub to make sure it works properly. if it works, it might be a good idea
to remove the original distribution kernels as they will otherwise always be
booted by default by grub (it always boots the kernel with the highest version
by default) - for removing them watch out for linux-image packages to remove.
after removing the distribution kernels "update-grub" should be run again to
update the grub configuration. on next boot the v5.10 kernel should be the
only one available in grub and thus boot by default. audio should hopefully
just work for the builtin speakers and microphone - to use the headphone
output the profile has to be switched from the default profile to the
headphone profile. a headset microphone seems to not work yet in this setup.
for adding automatic speaker/headphone switching on jack insertation please
have a look at the links below. if a headset with microphone is required it
most probably is best to simply use one of those small usb audio adapters.

please keep in mind to build a new v5.10.x kernel from time to time to get
the latest security updates. some notes about this can be found here:
https://github.com/hexdump0815/imagebuilder/blob/main/doc/building-own-kernels.md
and here:
https://github.com/hexdump0815/imagebuilder/blob/main/doc/installing-a-newer-kernel.md

## suspend/resume

suspend/resume is working fine in s2idle mode, which can be enabled by
uncommenting the correspoding line in /etc/rc.local. maybe even deep sleep
is working, but i did not test that in detail yet.

## links

- https://github.com/iofq/chell_audio - the firmware files and instructions were tkane from this repo
- https://github.com/metaquanta/chell_audio.git - the ucm2 files were tkane from this repo
- https://github.com/devendor/c302ca - this might be interesting for other skylake chromebooks with a slightly different audio setup
- https://github.com/GalliumOS/galliumos-skylake - this might also be a good resource to get other systems working maybe
