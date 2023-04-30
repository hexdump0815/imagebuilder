# chromebook trogdor

## bootable sd card images

- https://github.com/hexdump0815/imagebuilder/releases/tag/230218-03
- https://github.com/hexdump0815/imagebuilder/releases/tag/220814-01
- https://github.com/hexdump0815/imagebuilder/releases/tag/211120-02

## tested systems - working

- acer chromebook spin sp513-1h/sp513-1hl - lazor
  - see also: https://github.com/hexdump0815/imagebuilder/issues/47
- hp chromebook x2 - coachz
  - see also: https://github.com/hexdump0815/imagebuilder/issues/44
- lenovo chromeboot duet 5 - homestar
  - see also: https://github.com/hexdump0815/imagebuilder/issues/68
- lenovo chromeboot duet 3 - wormdingler

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

- this is still very much wip, things might work or might not work
- wifi, bt, basic sound (on lazor) seem to be ok, suspend/resume does not seem to work properly yet (at least if running from usb, when running from emmc it might work meanwhile, but not sure if really completely as it is not sure yet if it enters the deep sleep mode properly)
- the current sound setup is not complete yet (and broken on homestar right now):
  - headphones and headset mic do not work yet, so better use a small usb audio interface for a headset if needed for now
- on lazor the keyboard backlight can be controlled via /sys/class/leds/cros_ec\:\:kbd_backlight/brightness (values can go from 0-1023)
- when booting from an usb medium the bootup might hang waiting to discover the root device - in such cases it might help to shortly unplug and replug the usb medium the system is booted from
