# chromebook kukui

## bootable sd card images

- https://github.com/hexdump0815/imagebuilder/releases/tag/210321-01

## tested systems - working

- lenovo ideapad duet 10.1 chromebook - krane
  - somewhat working, see notes for the release download
- acer chromebook spin cp311-3h - juniper
  - somewhat working with v5.13 kernel - see notes below

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

- krane is working ok with the v5.10 kernel
- krane and juniper are working ok with the v5.13 kernel
  - gpu did not work for me yet (tested with xorg only so far), seems to work in cadmium so should be fixable
  - krane has usb bandwidth problems most probably due to usb-c only and some patches missing
  - juniper can not get edid info for its panel driver if panfrost is y, works with panfrost m
  - kernel config is merged for both mt8173 and mt8183, mt8183 still seem to break mt8173 drm - so they need to be compiled separately for now
- things to come:
  - wlan and bluetooth - firmware files from cadmium are in now
  - sound - cadmium has it working, ucm files are available from chromium sources
