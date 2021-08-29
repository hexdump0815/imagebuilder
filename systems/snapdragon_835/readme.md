# snapdragon 835 (msm8998) based laptops

## bootable sd card images

- none yet

## tested systems - working

- asus novago tp370ql

## untested systems

- hp envy x2
- lenovo miix 630
- maybe rhere are more laptops with a snapdragon 835

## kernel build notes

- https://github.com/hexdump0815/linux-mainline-qcom-msm8998-kernel/blob/main/readme.qcn

## special notes

- this is very much work in progress and not useable yet
- so far only tested with bullseye, not sure if grub etc. in focal is new enough to be working
- the linux support for those snapdragon 835 is missing a lot of things like gpu acceleration, wifi, sound, susped/resume, cpu frequency scaling etc., so it might only be useful in case you want to hack on it
- some outdated information can be found here: https://github.com/aarch64-laptops/build
