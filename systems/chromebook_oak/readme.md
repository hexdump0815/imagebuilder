# chromebook oak

## bootable sd card images

- https://github.com/hexdump0815/imagebuilder/releases/tag/230920-01
- https://github.com/hexdump0815/imagebuilder/releases/tag/230218-02
- https://github.com/hexdump0815/imagebuilder/releases/tag/220819-01
- https://github.com/hexdump0815/imagebuilder/releases/tag/220606-02
- https://github.com/hexdump0815/imagebuilder/releases/tag/210724-02
- https://github.com/hexdump0815/imagebuilder/releases/tag/210509-01
- https://github.com/hexdump0815/imagebuilder/releases/tag/210321-01

## tested systems - working

- acer chromebook r13 - elm
- lenovo chromebook 100e (mt8173 version) - [hana](https://github.com/hexdump0815/imagebuilder-doc/blob/main/chromebooks/systems/oak/hana-100e-gen2.md)
- lenovo chromebook 300e (mt8173 version) - hana
- lenovo chromebook n23 - hana
- asus chromebook c202xa - hana

## untested systems

- lenovo chromebook c330 - hana
- lenovo chromebook s330 - hana
- lenovo ideapad flex 3 chromebook (mt8173 version) - hana

## generic mainline linux on arm chromebook notes

- https://github.com/hexdump0815/linux-mainline-on-arm-chromebooks/blob/main/readme.md

## kernel build notes

- https://github.com/hexdump0815/linux-mainline-mediatek-mt81xx-kernel/blob/master/readme.mt7

## priority

- medium: will be worked on and improved from time to time, waiting for working suspend/resume on latest kernels and mainline gpu driver to get ready

## special notes

- this system stays on the linux v5.10 kernel for now as later mainline kernels have problems with the display reinitialization after resume
  - this is no longer the case since the 220606-02 image
- most things seem to work more or less
- there is no gpu acceleration as there is no open source driver available for the powervr gpu in the mt8173 soc, mesa software rendering is used instead for opengl etc.
- suspend/resume status:
  - with v5.10 it works fine (console and xorg) with https://github.com/hexdump0815/imagebuilder/blob/main/systems/chromebook_oak/extra-files/usr/lib/systemd/system-sleep/mrvl-reload - so all images starting with version 210724-02 should be fine
  - with v5.11+ it is broken as the display does not come back after resume - see todo
  - with v5.18 it is working again, only display sleep is broken and being worked around by special power management settings in the image
- when booting from an usb medium the bootup might hang waiting to discover the root device - in such cases it might help to shortly unplug and replug the usb medium the system is booted from
- in the past (up to including debian bullseye and ubuntu focal) display gamma and color profile settings (night/red shift mode, display color calibration etc.) were not working at all on arm systems and it seems like starting with debian bookworm it is now working on systems with the proper support for it - luckily on this system it seems to be supported now
- alternatively there is also support for oak-elm in alpine linux at:
  - https://git.alpinelinux.org/aports/tree/testing/linux-elm/
