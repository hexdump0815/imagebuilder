# chromebook corsola

## bootable sd card images

- https://github.com/hexdump0815/imagebuilder/releases/tag/230626-01

## tested systems - working

- lenovo ideaPad slim 3 (mt8186 version) - magenton
- asus chromebook cm14 (cm1402c) - tentacool (dtb says tentacruel)

## untested systems

- lenovo 100e gen 4 (mt8186 version) - rusty
- lenovo 300e gen 4 (mt8186 version) - steelix
- asus chromebook cm14 flip (cm1402f) - tentacruel

## generic mainline linux on arm chromebook notes

- https://github.com/hexdump0815/linux-mainline-on-arm-chromebooks/blob/main/readme.md

## kernel build notes

- https://github.com/hexdump0815/linux-chromeos-kernel/blob/master/readme.col
  - a chromeos based kernel is used until mainline gets useable on this device

## mesa build notes

- not relevant yet

## priority

- experimental mode

## special notes

- this is just some experimental initial draft to support this system in some
  way
- this is still very much wip and untested, things might work or might not work
- as long as the chromeos kernel is used there is no gpu support and other
  stuff might also not work
- it looks like (at least the initial batch of) corsola chromebooks is a bit
  buggy when trying to switch into developer mode and seems to hang there, so
either an update has to be done first or they have to be restored from the
latest recovery image - then switching to developer mode works properly
