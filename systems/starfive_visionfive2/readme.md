# starfive visionfive2

## bootable sd card images

- https://github.com/hexdump0815/imagebuilder/releases/tag/230321-02
- https://github.com/hexdump0815/imagebuilder/releases/tag/230115-01

## tested systems - working

- starfive visionfive2 super early bird version (1.2a)

## untested systems

- starfive visionfive2 early bird version (1.3b) (should work as well)

## kernel build notes

- https://github.com/hexdump0815/linux-starfive-visionfive2-kernel/blob/main/readme.vf2

## u-boot build notes

- none yet as for now the vendor u-boot on the sd card is used

## mesa build notes

- none yet, but will come once its time to look closer at gpu support

## priority

- medium: some first experiments with a useable riscv64 sbc

## special notes

- all this is very much wip and not that useable yet
- for the 230321-02 image please switch the dip switches on the board to "sd", i.e. upper one (marked rgpio_1) to 0 (marked ON on the dip switch, i.e. default setting) and lower one (marked rgpio_0) to 1 (marked 2 on the dip switch, i.e. oposite to the default setting) to boot directly from the sd card as this image has sbi/u-boot included in its boot blocks (taken from the 202302 starfive debian image)
- more info coming soon
