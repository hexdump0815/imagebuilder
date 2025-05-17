# rockchip rk3588

## bootable sd card images

- https://github.com/velvet-os/imagebuilder/releases/tag/230321-01 (radxa rock 5b)
- https://github.com/velvet-os/imagebuilder/releases/tag/230122-02 (orange pi 5)

## tested systems - working

- radxa rock 5b
- orange pi 5

## untested systems

some more work will be required to make the devices below working

- other rk3588 sbc devices

## kernel build notes

- https://github.com/hexdump0815/linux-rockchip-rk3588-kernel/blob/main/readme.r5b
- https://github.com/hexdump0815/linux-rockchip-rk3588-kernel/blob/main/readme.op5

## u-boot build notes

- none yet as for now the legacy rock-5b and orange-pi-5 boot blocks are used

## priority

- medium: some first experiments with rk3588 devices

## special notes

- all this is very much wip and not that useable yet
- the first image (230122-02) was tested and should boot on the orange pi 5 and not on the radxa rock 5b
- the second image (230321-01) was tested and should boot on the radxa rock 5b (a boot block and kernel for the orange pi 5 is in /boot/extra)
- more info coming soon
