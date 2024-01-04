# snapdragon 835 (msm8998) based laptops

## bootable sd card images

- https://github.com/hexdump0815/imagebuilder/releases/tag/230322-01
- https://github.com/hexdump0815/imagebuilder/releases/tag/221101-01
- https://github.com/hexdump0815/imagebuilder/releases/tag/211204-01

## tested systems - working

- asus novago tp370ql
- lenovo miix 630

## untested systems

- hp envy x2
- maybe there are more laptops with a snapdragon 835

## kernel build notes

- https://github.com/hexdump0815/linux-mainline-qcom-msm8998-kernel/blob/main/readme.qcn

## priority

- low: will be worked on and improved rarely, still very limited mainline support which is unlikely to change soon

## special notes

- this is very much work in progress, not really useable yet and mostly ment as a starting point for helping to bring mainline linux forward on this platform
- the grub setup so far is only an ugly hack to make it boot at all and the boot config is currently hard coded in /boot/boot/grub/grub.cfg
- currently the dtb file for the asus novago is hard coded in the grub config file, this needs to be adjusted in case of another snapdragon 835 system
- the root filesystems is currently still set to ext4 (but the usual btrfs should work as well i guess)
- so far only tested with bullseye, not sure if grub etc. in focal is new enough to be working
- the linux support for those snapdragon 835 is missing a lot of things like gpu acceleration, wifi, sound, susped/resume, cpu frequency scaling etc., so it might only be useful in case you want to hack on it
- booting should only be done from usb for now, please keep the windows installation on emmc/ufs as it might be required to get updated firmware files from it still
- secure boot needs to be disabled in the bios in order to be able to boot those images as all
- some outdated information and information on how to prepare the system to boot linux can be found here: https://github.com/aarch64-laptops/build
- it looks like it is possible to create a recovery disk/drive from within windows via "start/windows" button and then searching for "recovery drive" (or whatever the proper translation for the installed windows language might be) and then using the resulting application to create such a drive on some usb disk following the dialogs - i did not try or use this yet, but it looks like its a good idea to create such a thing before even starting to play around with linux on a windows on arm device as there are usually no recovery media available for them
