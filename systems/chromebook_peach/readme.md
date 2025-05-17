# chromebook peach

## bootable sd card images

- https://github.com/velvet-os/imagebuilder/releases/tag/230924-02
- https://github.com/velvet-os/imagebuilder/releases/tag/230220-02
- https://github.com/velvet-os/imagebuilder/releases/tag/220619-02
- https://github.com/velvet-os/imagebuilder/releases/tag/210725-01
- https://github.com/velvet-os/imagebuilder/releases/tag/210613-01

## tested systems - working

- samsung chromebook xe503c12 - peach pit
- samsung chromebook xe503c32 - peach pi

see also https://github.com/velvet-os/imagebuilder/issues/80 for all above

## untested systems

- none, there are only the above two peach systems

## generic mainline linux on arm chromebook notes

- https://github.com/hexdump0815/linux-mainline-on-arm-chromebooks/blob/main/readme.md

## kernel build notes

- https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/blob/master/readme.cbp
- https://github.com/hexdump0815/linux-chromeos-kernel/blob/main/readme.308
  - just for reference, not really needed anymore

## u-boot build notes

- https://github.com/hexdump0815/u-boot-chainloading-for-arm-chromebooks/blob/master/readme.cbe

## priority

- low: will be worked on and improved rarely, old hardware

## special notes

- for all images starting with version 210725-01 full deep suspend/resume
  should work fine
- the current sound setup is not complete yet:
  - internal mic and headset mic do not work yet, so better use a small usb
    audio interface for a headset or a mic if needed for now
- the mali gpu is only supported via the legacy mali blob as it is not yet
  supported by the open source panfrost mali driver
- starting with the v6.1 kernels the legacy mali support has been dropped, but
  luckily the open source panfrost driver is working quite well on peach
chromebooks as long as the mesa version is v22.3.0 or newer
- zswap does not work as well on armv7l with lpae enabled (to be able to use
  all 4gb of ram) as on other systems as the achieved compression ratio with
zsmalloc/zstd seemed to be limited to around 2 (usually around 3-4 for armv7l)
resulting in more paging to the swapfile on disk, a workaround was to increase
the zswap percentage to 50% in /etc/rc.local which was still well useable in
this setup and resulted in less writes to disk again
- the peach chromebooks seem to not boot properly with all sd cards (and not at
  all from usb devices) ... if booting does not work it might be worth to try
different sd cards ... older and smaller ones seem to have the higher chance to
work well
- the battery of the snow chromebook (xe303c12) seems to be interchangable with
  the battery of the peach pit chromebook (xe503c12)
