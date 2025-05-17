# chromebook trogdor

## bootable sd card images

- https://github.com/velvet-os/imagebuilder/releases/tag/230922-01
- https://github.com/velvet-os/imagebuilder/releases/tag/230501-01
- https://github.com/velvet-os/imagebuilder/releases/tag/230218-03
- https://github.com/velvet-os/imagebuilder/releases/tag/220814-01
- https://github.com/velvet-os/imagebuilder/releases/tag/211120-02

## tested systems - working

- acer chromebook spin sp513-1h/sp513-1hl - [lazor](https://github.com/velvet-os/velvet-os.github.io/blob/main/chromebooks/systems/trogdor/lazor.md)
  - see also: https://github.com/velvet-os/imagebuilder/issues/47
- hp chromebook x2 - coachz
  - see also: https://github.com/velvet-os/imagebuilder/issues/44
- lenovo chromeboot duet 5 - [homestar](https://github.com/velvet-os/velvet-os.github.io/blob/main/chromebooks/systems/trogdor/homestar.md)
  - see also: https://github.com/velvet-os/imagebuilder/issues/68
- lenovo chromeboot duet 3 - [wormdingler](https://github.com/velvet-os/velvet-os.github.io/blob/main/chromebooks/systems/trogdor/wormdingler.md)
  - see also: https://github.com/velvet-os/imagebuilder/issues/182

## untested systems

- according to the dts files in the kernel there are maybe other trogdor models as well

## generic mainline linux on arm chromebook notes

- https://github.com/hexdump0815/linux-mainline-on-arm-chromebooks/blob/main/readme.md

## kernel build notes

- https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/blob/master/readme.cbq

## mesa build notes

- https://github.com/hexdump0815/mesa-etc-build/blob/master/mesa-build.txt

## priority

- medium: will be worked on and improved from time to time

## special notes

- wifi, bt, basic sound (at least on on lazor and wormdingler) seem to be ok, suspend/resume does not seem to work properly yet if running from usb, when running from emmc it seems to work
- wormdingler: the display rotation will be set properly during the first boot, afterwards it will reboot once automatically and should come up with the display correctly set to landscape mode - so please don't be surprised about the first automatic reboot and be ready with ctrl-u for the second boot :)
- the current sound setup is not complete yet (and broken on homestar right now):
  - headphones and headset mic do not work yet, so better use a small usb audio interface for a headset if needed for now
- on lazor the keyboard backlight can be controlled via /sys/class/leds/cros_ec\:\:kbd_backlight/brightness (values can go from 0-1023)
- when booting from an usb medium the bootup might hang waiting to discover the root device - in such cases it might help to shortly unplug and replug the usb medium the system is booted from
