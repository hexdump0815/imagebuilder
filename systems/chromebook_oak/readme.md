# chromebook oak

## bootable sd card images

- https://github.com/hexdump0815/imagebuilder/releases/tag/210509-01
- https://github.com/hexdump0815/imagebuilder/releases/tag/210321-01

## tested systems - working

- lenovo chromebook n23 - hana
- acer chromebook r13 - elm

## untested systems

- asus chromebook c202xa - hana
- lenovo chromebook 300e - hana
- lenovo chromebook c330 - hana
- lenovo chromebook s330 - hana
- lenovo chromebook 100e 2nd gen - hana

## generic mainline linux on arm chromebook notes

- https://github.com/hexdump0815/linux-mainline-on-arm-chromebooks/blob/main/readme.md

## kernel build notes

- https://github.com/hexdump0815/linux-mainline-mediatek-mt81xx-kernel/blob/master/readme.mt7

## special notes

- there is no gpu acceleration as there is no open source driver available for the powervr gpu in the mt8173 soc, mesa software rendering is used instead for opengl etc.
- suspend/resume status:
  - with v5.10.25 it works fine (console and xorg) with https://github.com/hexdump0815/imagebuilder/blob/main/systems/chromebook_oak/extra-files/usr/lib/systemd/system-sleep/mrvl-reload - so allimages after version 210509-01 should be fine
  - with v5.13.0 it works but drm fails on restore - bisecting required
