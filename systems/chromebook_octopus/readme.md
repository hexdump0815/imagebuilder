# chromebook octopus - intel gemini lake with native chromeos boot

## bootable sd card images

- none yet

## tested systems - working

- hp chromebook x360 12b with celeron n4000 - bloog

## untested systems

- most probably other intel chromebooks with gemini lake socs using a 4.14 kernel are working fully or partially as well

## generic mainline linux on intel chromebook notes

- https://github.com/hexdump0815/linux-mainline-on-intel-chromebooks/blob/main/readme.md

## kernel build notes

- https://github.com/hexdump0815/linux-chromeos-kernel/blob/main/readme.414

## special notes

- there is no legacy or uefi firmware available from https://mrchromebox.tech/ for gemini lake chromebooks, so booting regular linux installers on them does not work
- these images are using the native chromeos boot procedure (chromeos kernel format written to special chromeos kernel partitions) to be able to run a regular linux system on them anyway
- currently a self compiled kernel is used based on the corresponding chromeos kernel for those devices
- glamor/opengl accelerated xorg does not yet work for some reason
- some firmware files are still required from chromeos
- wifi drops the connection as soon as it is established
- the current sound setup is not complete yet:
  - headphones and internal mic do not work yet, so better use a small usb audio interface for a headset if needed for now
