# chromebook octopus - intel gemini lake with native chromeos boot

## bootable sd card images

- https://github.com/velvet-os/imagebuilder/releases/tag/211204-02

## tested systems - working

- hp chromebook x360 12b with celeron n4000 - bloog
- acer chromebook cb314-1h with celeron n4020 - droid

## untested systems

- most probably other intel chromebooks with gemini lake socs using a 4.14 kernel are working fully or partially as well

## generic mainline linux on intel chromebook notes

- https://github.com/hexdump0815/linux-mainline-on-intel-chromebooks/blob/main/readme.md

## kernel build notes

- https://github.com/hexdump0815/linux-mainline-x86-64-kernel/blob/main/readme.cbo
- https://github.com/hexdump0815/linux-chromeos-kernel/blob/main/readme.414
  - adjusted legacy chromeos kernel

## priority

- on hold: no further activities planned so far, no further plans to work on depthcharge booting on x86 devices for now

## special notes

- there is no legacy or uefi firmware available from https://mrchromebox.tech/ for gemini lake chromebooks, so booting regular linux installers on them does not work
  - update: meanwhile it is available - see: https://mrchromebox.tech/#devices
- these images are using the native chromeos boot procedure (chromeos kernel format written to special chromeos kernel partitions) to be able to run a regular linux system on them anyway
- a regular mainline kernel works based on the chromeos kernel config
- alternatively a self compiled kernel is used based on the corresponding chromeos kernel for those devices (it is included at /boot/extra in the images to have it around)
- the root filesystems is currently still set to ext4 (instead of the usual btrfs for these images) to make it easily possible to switch to the legacy kernel if desired
- glamor/opengl accelerated xorg does not yet work for some reason for the legacy kernel (it works well with the mainline kernel)
- some firmware files are still required from chromeos
- wifi drops the connection as soon as it is established and not all wifi cards are supported by mainline yet (it looks like the iwl7000 driver from chromeos is still missing)
- sound with the mainline kernel does not work yet
- the current sound setup for the legacy kernel is not complete yet:
  - headphones and internal mic do not work yet, so better use a small usb audio interface for a headset if needed for now
- suspend seems to work somewhat in the configured s2idle mode and the mainline kernel, but deep sleep does not seem to work yet
