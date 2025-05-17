# chromebook cherry

## bootable sd card images

- https://github.com/velvet-os/imagebuilder/releases/tag/230109-01 (experimental)
- https://github.com/velvet-os/imagebuilder/releases/tag/220710-01

## tested systems - working

- acer chromebook cp513-2h - tomato
  - see also: https://github.com/velvet-os/imagebuilder/issues/61

## untested systems

- hp chromebook x360 13.3 (2023) - dojo
  - it uses a sligtly slower (max 2.6ghz) kompanio 1200 soc vs. kompanio 1380
    (max 3.0ghz) in tomato and seems to have nvme storage vs. emmc in tomato
  - some more information from pmos:
    https://wiki.postmarketos.org/wiki/HP_Chromebook_x360_13b-ca0xxx_(google-dojo)

## generic mainline linux on arm chromebook notes

- https://github.com/hexdump0815/linux-mainline-on-arm-chromebooks/blob/main/readme.md

## kernel build notes

- https://github.com/hexdump0815/linux-mainline-mediatek-mt81xx-kernel/blob/master/readme.mt9
  - based on the chromeos kernel mainline integration tree for the mt819x chromebooks at collabora
- https://github.com/hexdump0815/linux-chromeos-kernel/blob/master/readme.chr
  - a chromeos based kernel is used until mainline gets useable on this device

## mesa build notes

- https://github.com/hexdump0815/mesa-etc-build/blob/master/mesa-build.txt

## priority

- experimental mode

## special notes

- this is just some initial draft to support this system without having the actual hardware - in case someone wants to donate the hardware to me, please let me know :)
- this is still very much wip and untested, things might work or might not work
- as long as the chromeos kernel is used there is no gpu support
- the 230109-01 image is an experimental one based on the chromeos kernel mainline integration tree for the mt819x chromebooks at collabora and has panfrost gpu support (tested only on mt8192, but might work on mt8195 as well)
