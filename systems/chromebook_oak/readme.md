# chromebook oak

## bootable sd card images

- https://github.com/hexdump0815/imagebuilder/releases/tag/210724-02
- https://github.com/hexdump0815/imagebuilder/releases/tag/210509-01
- https://github.com/hexdump0815/imagebuilder/releases/tag/210321-01

## tested systems - working

- lenovo chromebook n23 - hana
- acer chromebook r13 - elm

## untested systems

- asus chromebook c202xa - hana
- lenovo chromebook 300e (mt8173 version) - hana
- lenovo chromebook c330 - hana
- lenovo chromebook s330 - hana
- lenovo chromebook 100e (mt8173 version) - hana
- lenovo ideapad flex 3 chromebook (mt8173 version) - hana

## generic mainline linux on arm chromebook notes

- https://github.com/hexdump0815/linux-mainline-on-arm-chromebooks/blob/main/readme.md

## kernel build notes

- https://github.com/hexdump0815/linux-mainline-mediatek-mt81xx-kernel/blob/master/readme.mt7

## special notes

- this system stays on the linux v5.10 kernel for now as later mainline kernels have problems with the display reinitialization after resume
- most things seem to work more or less
- there is no gpu acceleration as there is no open source driver available for the powervr gpu in the mt8173 soc, mesa software rendering is used instead for opengl etc.
- suspend/resume status:
  - with v5.10 it works fine (console and xorg) with https://github.com/hexdump0815/imagebuilder/blob/main/systems/chromebook_oak/extra-files/usr/lib/systemd/system-sleep/mrvl-reload - so all images starting with version 210724-02 should be fine
  - with v5.11+ it is broken as the display does not come back after resume - see todo
- alternatively there is also support for oak-elm and gru-kevin in alpine linux at:
  - https://git.alpinelinux.org/aports/tree/testing/linux-elm/
  - https://git.alpinelinux.org/aports/tree/testing/linux-gru/
