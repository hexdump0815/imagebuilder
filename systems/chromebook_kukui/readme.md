# chromebook kukui

## bootable sd card images

- https://github.com/velvet-os/imagebuilder/releases/tag/230917-01
- https://github.com/velvet-os/imagebuilder/releases/tag/230218-01
- https://github.com/velvet-os/imagebuilder/releases/tag/220818-01
- https://github.com/velvet-os/imagebuilder/releases/tag/220606-01
- https://github.com/velvet-os/imagebuilder/releases/tag/220528-01
- https://github.com/velvet-os/imagebuilder/releases/tag/210724-03
- https://github.com/velvet-os/imagebuilder/releases/tag/210321-01

## tested systems - working

- lenovo ideapad duet 10.1 chromebook - [krane](https://github.com/velvet-os/velvet-os.github.io/blob/main/chromebooks/systems/kukui/krane.md)
  - see also: https://github.com/velvet-os/imagebuilder/issues/53
- acer chromebook spin cp311-3h - juniper
  - see also: https://github.com/velvet-os/imagebuilder/issues/52
- hp chromebook 11a - kappa
  - see also: https://github.com/velvet-os/imagebuilder/issues/52
- lenovo ideapad 3 chromebook 14 inch (mt8183 version) - fennel14
  - see also: https://github.com/velvet-os/imagebuilder/issues/49
- lenovo ideapad flex 3 chromebook (mt8183 version) - fennel
  - see also: https://github.com/velvet-os/imagebuilder/issues/58
- asus chromebook flip cm3 (mt8183 version) - damu
  - see also: https://github.com/velvet-os/imagebuilder/issues/62
- asus chromebook cm3 - kakadu
  - see also: https://github.com/velvet-os/imagebuilder/issues/71
- acer chromebook 314 (cb314-2h/cb314-2ht) - cozmo
  - see also: https://github.com/velvet-os/imagebuilder/issues/75
- acer chromebook 311 - kenzo
  - see https://github.com/velvet-os/imagebuilder/issues/141#issuecomment-1663779043
- lenovo 10e chromebook tablet - [kodama](https://github.com/velvet-os/velvet-os.github.io/blob/main/chromebooks/systems/kukui/kodama.md)
  - see https://github.com/velvet-os/imagebuilder/issues/202
- asus chromebook detachable cz1 - katsu
- hp chromebook 11mk g9 ee - burnet/esche
  - reported via https://github.com/velvet-os/imagebuilder/issues/187

## untested systems

- acer chromebook 311 (c722/c722t) - willow
- asus chromebook cz1 - cerise
- asus chromebook flip cz1 - stern
- hp chromebook x360 11mk g3 ee - burnet
- lenovo 100e chromebook (mt8183 version) - makomo

## generic mainline linux on arm chromebook notes

- https://github.com/hexdump0815/linux-mainline-on-arm-chromebooks/blob/main/readme.md

## kernel build notes

- https://github.com/hexdump0815/linux-mainline-mediatek-mt81xx-kernel/blob/master/readme.mt8

## mesa build notes

- https://github.com/hexdump0815/mesa-etc-build/blob/master/mesa-build.txt

## priority

- high: most activities will most probably happen here

## special notes

- most things seem to work more or less (mostly thanks to the kernel patches partially taken from https://github.com/Maccraft123/Cadmium/tree/master/baseboard/kukui/patches)
- it seems that sometimes kukui devices give a high pitch noise after resuming from suspend (seen with kappa and juniper so far) - a useable workaround is to put the device into suspend and wake it up again, then the noise should be gone - see also: https://github.com/velvet-os/imagebuilder/issues/65
- juniper: sometimes the touchpad does not seem to work after booting, rebooting usually helps
- krane, kakadu and katsu: the display rotation will be set properly during the first boot, afterwards it will reboot once automatically and should come up with the display correctly set to landscape mode - so please don't be surprised about the first automatic reboot and be ready with ctrl-u for the second boot :)
- some log spamming kernel messages have been silenced:
  - krane has usb bandwidth problems, especially with usb audio
  - juniper seems to have some audio related interrupt issues
- the kernel config is merged now for both mt8173 and mt8183, mt8183 patches still seem to break mt8173 drm - so they need to be compiled separately for now
- so far only the above tested kukui chromebooks are supported, but other mt8183 chromebooks most probably will work (at least partially) too or can be added easily
- the current sound setup is not complete yet
  - the levels of the internal mic are very low (as a workaround they can be boosted in software at pulseaudio level via "pactl set-source-volume 1 400%")
  - a headset mic does not work yet, so better use a small usb audio interface for a headset if needed for now
- it looks like gpu frequency scaling does not work properly yet resulting in gpu errors like "gpu sched timeout", "AS_ACTIVE bit stuck" or page faults, what seems to help is to lock the gpu freq to just a single one for now by echoing a freq from /sys/class/devfreq/13040000.gpu/available_frequencies to both /sys/class/devfreq/13040000.gpu/min_freq and /sys/class/devfreq/13040000.gpu/max_freq (maybe in rc.local or similar) - 400000000 seems to work (others most probably as well) - see also: https://oftc.irclog.whitequark.org/panfrost/2022-01-09#30513966 - update: gpu freq scaling should work with the supplied v5.18 kernel
- when booting from an usb medium the bootup might hang waiting to discover the root device - in such cases it might help to shortly unplug and replug the usb medium the system is booted from
- in the past (up to including debian bullseye and ubuntu focal) display gamma and color profile settings (night/red shift mode, display color calibration etc.) were not working at all on arm systems and it seems like starting with debian bookworm it is now working on systems with the proper support for it - luckily on this system it seems to be supported now
