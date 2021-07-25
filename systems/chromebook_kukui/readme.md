# chromebook kukui

## bootable sd card images

- https://github.com/hexdump0815/imagebuilder/releases/tag/210724-03

## tested systems - working

- lenovo ideapad duet 10.1 chromebook - krane
- acer chromebook spin cp311-3h - juniper

## untested systems

- acer chromebook spin cp311-3h - juniper
- acer chromebook 311 (c722/c722t) - willow
- asus chromebook cm3 - kakadu
- asus chromebook flip cm3 - damu
- asus chromebook flip cz1 - cerise
- hp chromebook 11a - kappa
- lenovo ideapad flex 3 chromebook (mt8183 version) - fennel
- lenovo 10e chromebook tablet - kodama

## generic mainline linux on arm chromebook notes

- https://github.com/hexdump0815/linux-mainline-on-arm-chromebooks/blob/main/readme.md

## kernel build notes

- https://github.com/hexdump0815/linux-mainline-mediatek-mt81xx-kernel/blob/master/readme.cbm
  - v5.10 kernel with a lot of hacks to make it work somehow at least on the duet (krane)

## special notes

- most things seem to work more or less (mostly thanks to the kernel patches partially taken from https://github.com/Maccraft123/Cadmium/tree/master/baseboard/kukui/patches)
- juniper: sometimes the touchpad does not seem to work after booting, rebooting usually helps
- krane: the display rotation will be set properly after the first reboot automatically, so just reboot once more after the first time
- some log spamming kernel messages have been silenced:
  - krane has usb bandwidth problems, especially with usb audio
  - juniper seems to have some audio related interrupt issues
- the kernel config is merged now for both mt8173 and mt8183, mt8183 patches still seem to break mt8173 drm - so they need to be compiled separately for now
- so far only juniper and krane are supported, but other mt8183 chromebooks might be added easily
- the current sound setup is more a hack than something real, but for basic stuff it seems to work
