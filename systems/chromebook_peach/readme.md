# chromebook peach

## bootable sd card images

- https://github.com/hexdump0815/imagebuilder/releases/tag/220619-02
- https://github.com/hexdump0815/imagebuilder/releases/tag/210725-01
- https://github.com/hexdump0815/imagebuilder/releases/tag/210613-01

## tested systems - working

- samsung chromebook xe503c12 - peach pit

see also https://github.com/hexdump0815/imagebuilder/issues/80 for all above

## untested systems

- samsung chromebook xe503c32 - peach pi

  - might work with a bit of luck
  - u-boot.kpart in /boot/extra - untested too

## generic mainline linux on arm chromebook notes

- https://github.com/hexdump0815/linux-mainline-on-arm-chromebooks/blob/main/readme.md

## kernel build notes

- https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/blob/master/readme.cbp
- https://github.com/hexdump0815/linux-chromeos-kernel/blob/main/readme.308
  - just for reference, not really needed anymore

## u-boot build notes

- https://github.com/hexdump0815/u-boot-chainloading-for-arm-chromebooks/blob/master/readme.cbe

## priority

- low: will be worked on and improved rarely, too old hardware without mainline gpu support

## special notes

- after first boot please run /scripts/fix-peach-audio.sh as root to fix the ucm audio config files for the corresponding system and reboot
- for all images starting with version 210725-01 full deep suspend/resume should work fine
- the current sound setup is not complete yet:
  - internal mic and headset mic do not work yet, so better use a small usb audio interface for a headset or a mic if needed for now
- the mali gpu is only supported via the legacy mali blob as it is not yet supported by the open source panfrost mali driver
- the battery of the snow chromebook (xe303c12) seems to be interchangable with the battery of the peach chromebook (xe503c12)
