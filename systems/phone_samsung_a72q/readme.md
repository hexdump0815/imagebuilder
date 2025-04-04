# samsung galaxy a52/a72 - a52q/a72q

## bootable sd card images

- https://github.com/hexdump0815/imagebuilder/releases/tag/231126-02
- https://github.com/hexdump0815/imagebuilder/releases/tag/230929-01

## tested systems - working

- samsung galaxy a72 - sm-a725f/ds
- samsung galaxy a52 - sm-a525f/ds

## untested systems

- samsung galaxy a72 - other versions
- samsung galaxy a52 - other versions

## kernel build notes

- https://github.com/hexdump0815/linux-mainline-qcom-msm8998-kernel/blob/main/readme.a72
- before using an own kernel build a postmarketos kernel+initrd=boot.img was used
  - https://github.com/hexdump0815/pmaports-other/tree/main/linux-postmarketos-qcom-sm7125
  - https://github.com/hexdump0815/pmaports-other/tree/main/device-samsung-a52q
  - https://github.com/hexdump0815/pmaports-other/tree/main/device-samsung-a72q

## priority

- experimental mode

## special notes

- this is just some experimental initial draft to support this system in some
  - everything you do based on this is done at your own risk as it can seriously brick the device or do orher unexpected things
  - do not consider playing around with this without a deep understanding about linux, android, the android boot process and partition setup
  way
- this is not very useable yet, still in a very early and experimental phase, but at least i got a debian bookworm system booting well using a self built and installed kernel
  - it is strictly required to install twrp as recovery on the device before doing anything to have a last resort in case some installed kernel does not boot
  - in case of installing a non booting kernel/boot image it might be the case that the device cannot be powered off anymore by long pressing the power button as usually, press power+volume-down until the system reboots and immediately after power+volume-up to get into trwp at least (all this has to be done while being connected by a usb-c cable to some pc) - from there a known working boot image can be installed or the device being powered down (only possible without connected power)
  - currently only running from sd card is considered, it would also be possible to run from the internal ufs storage but this is not handled here yet as the risk to brick the device is even higher this way
  - the disk-image (please gunzip the files from the release download before using them) has to be written to an sd card, the boot-a52.img-version or boot-a72.img-version has to be written to the boot partition of the device via twrp and the emptyDTBO.img has to be written to the dtbo partition via twrp
  - usb has been switched to host mode (compared to the peripheral mode of pmos for its usb ethernet) so that it is possible to connect usb devices like ethernet, keyboard, mouse etc. - there is no host power provided by the port, i.e. a powered usb-c hub is required to connect anything (it looks like the device is powered properly this way too)
  - the usb port is usb 2 only, so dp alt mode over type c is not possible to connect an external dp/hdmi monitor but displaylink usb 2 adapters (using the linux udl driver) are working (tested to be working, but refresh and performance is rather slow - even the gpu seems to get properly connected to the udl device as well but is slow as well in this setup)
- a1 rated sd cards are highly recommended as otherwise the performance will be bad due to bad random disk io
