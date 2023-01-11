# chromebook asurada

## bootable sd card images

- https://github.com/hexdump0815/imagebuilder/releases/tag/230109-01 (experimental)
- https://github.com/hexdump0815/imagebuilder/releases/tag/220710-01

## tested systems - working

- acer chromebook cb514-2h - spherion
  - see also: https://github.com/hexdump0815/imagebuilder/issues/60

## untested systems

- asus chromebook flip cm3 (mt8192 version) - hayato

## generic mainline linux on arm chromebook notes

- https://github.com/hexdump0815/linux-mainline-on-arm-chromebooks/blob/main/readme.md

## kernel build notes

- https://github.com/hexdump0815/linux-mainline-mediatek-mt81xx-kernel/blob/master/readme.mt9
  - based on the chromeos kernel mainline integration tree for the mt819x chromebooks at collabora
- https://github.com/hexdump0815/linux-chromeos-kernel/blob/master/readme.asr
  - a chromeos based kernel is used until mainline gets useable on this device

## mesa build notes

- https://github.com/hexdump0815/mesa-etc-build/blob/master/mesa-build.txt

## priority

- draft mode: unclear if it is working at all

## special notes

- this is just some initial draft to support this system without having the actual hardware - in case someone wants to donate the hardware to me, please let me know :)
- this is still very much wip and untested, things might work or might not work
- as long as the chromeos kernel is used there is no gpu support
- the 230109-01 image is an experimental one based on the chromeos kernel mainline integration tree for the mt819x chromebooks at collabora and has panfrost gpu support (tested only on mt8192, but might work on mt8195 as well)
