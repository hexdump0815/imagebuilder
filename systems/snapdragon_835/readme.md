# snapdragon 835 (msm8998) based laptops

## bootable sd card images

- https://github.com/hexdump0815/imagebuilder/releases/tag/211204-01

## tested systems - working

- asus novago tp370ql

## untested systems

- hp envy x2
- lenovo miix 630
- maybe rhere are more laptops with a snapdragon 835

## kernel build notes

- https://github.com/hexdump0815/linux-mainline-qcom-msm8998-kernel/blob/main/readme.qcn

## special notes

- this is very much work in progress and not really useable yet
- the grub setup so far is only an ugly hack to make it boot at all and the boot config is currently hard coded in /boot/boot/grub/grub.cfg
- currently the dtb file for the asus novago is hard coded in the grub config file, this needs to be adjusted in case of another snapdragon 835 system
- the root filesystems is currently still set to ext4 (but the usual btrfs should work as well i guess)
- so far only tested with bullseye, not sure if grub etc. in focal is new enough to be working
- the linux support for those snapdragon 835 is missing a lot of things like gpu acceleration, wifi, sound, susped/resume, cpu frequency scaling etc., so it might only be useful in case you want to hack on it
- some outdated information and information on how to prepare the system to boot linux can be found here: https://github.com/aarch64-laptops/build
