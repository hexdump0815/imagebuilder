# rockchip rk3566, rk3568

## bootable sd card images

- https://github.com/hexdump0815/imagebuilder/releases/tag/231002-04
- https://github.com/hexdump0815/imagebuilder/releases/tag/230224-02
- https://github.com/hexdump0815/imagebuilder/releases/tag/230122-01 (experimental first image)

## tested systems - working

- x96 x6 tv box

## untested systems

- pine64 quartz64 b
- radxa rock 3a
- radxa rock 3b

some more work will be required to make the devices below working

- other rockchip rk3566 tv boxes
- other rk3566 or rk3568 sbc devices

## kernel build notes

- https://github.com/hexdump0815/linux-mainline-and-mali-rockchip-rk33xx-kernel/blob/master/readme.r56

## u-boot build notes

- none yet as for now the minimyth2 legacy based boot blocks are used

## priority

- medium: some first experiments with rk356x devices

## special notes

- all this is very much wip and not that useable yet
- more info coming soon
- tv boxes are always hit and miss, so they might work or might not work and are usually of low quality
  - be happy in case it works for your box
  - names do not mean anything for tv boxes: two boxes with the same name and look might be identical inside, slightly different (often wifi, bt, memory and or emmc/nand chips) or completely different (different socs, nand instead of emmc, fake specs like 1gb ram and 8gb nand instead of 4gb ram and 32gb emmc) - all three options are possible even if they were bought together at the same time at the same place
  - it is impossible to support all tv boxes with their wild mix of hardware or usually quite low quality, so please do not open github issues in case the images do not work for your box
  - github issues with tested and structured information on how to get the images working on a box where they did not work out of the box are welcome
  - sound is not working, wifi, bluetooth and sometimes even ethernet might work or might not work depending on the tv box
