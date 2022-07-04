# chromebook trogdor

## bootable sd card images

- https://github.com/hexdump0815/imagebuilder/releases/tag/211120-02

## tested systems - working

- acer chromebook spin sp513-1h - lazor
  - see also: https://github.com/hexdump0815/imagebuilder/issues/47
- hp chromebook x2 - coachz
  - see also: https://github.com/hexdump0815/imagebuilder/issues/44

## untested systems

- lenovo chromeboot duet 5 - homestar
- lenovo chromeboot duet 3 - wormdingler

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
- wifi, bt, basic sound seem to be ok, suspend/resume does not seem to work properly yet (at least if running from usb, when running from emmc it is reported to work somewhat at least on lazor, but not sure if really completely as it does not seem to enter the deep sleep mode properly)
- the current sound setup is not complete yet:
  - headphones and headset mic do not work yet, so better use a small usb audio interface for a headset if needed for now
- on lazor the keyboard backlight can be controlled via /sys/class/leds/cros_ec\:\:kbd_backlight/brightness (values can go from 0-1023)
- when booting from an usb medium the bootup might hang waiting to discover the root device - in such cases it might help to shortly unplug and replug the usb medium the system is booted from
