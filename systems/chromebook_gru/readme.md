# chromebook gru

## bootable sd card images

- https://github.com/hexdump0815/imagebuilder/releases/tag/230220-03
- https://github.com/hexdump0815/imagebuilder/releases/tag/220822-01
- https://github.com/hexdump0815/imagebuilder/releases/tag/220612-01
- https://github.com/hexdump0815/imagebuilder/releases/tag/211120-01

## tested systems - working

- asus chromebook flip c101p - bob
- samsung chromebook plus xe513c24 - kevin
- acer chromebook tab 10 - scarlet (wip)

## untested systems

- asus chromebook tablet ct100 - maybe scarlet too?

## generic mainline linux on arm chromebook notes

- https://github.com/hexdump0815/linux-mainline-on-arm-chromebooks/blob/main/readme.md

## kernel build notes

- https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/blob/master/readme.cbg

## mesa build notes

- https://github.com/hexdump0815/mesa-etc-build/blob/master/mesa-build.txt

## priority

- medium: will be worked on and improved from time to time

## special notes

- wifi, bt, basic sound seem to be ok, suspend/resume seems to work, earlier display/drm init will need some more work (if it is at all possible)
- the current sound setup is not complete yet:
  - headphones and headset mic do not work yet, so better use a small usb audio interface for a headset if needed for now
- alternatively there is also support for gru-kevin in alpine linux at:
  - https://git.alpinelinux.org/aports/tree/testing/linux-gru/
- the extremely large display resolution of kevin (2400x1600) seems to put the gpu to its limits with panfrost as xrandr display scaling does not seem to work well (display looks frozen)
- in the past (up to including debian bullseye and ubuntu focal) display gamma and color profile settings (night/red shift mode, display color calibration etc.) were not working at all on arm systems and it seems like starting with debian bookworm it is now working on systems with the proper support for it - luckily on this system it seems to be supported now
