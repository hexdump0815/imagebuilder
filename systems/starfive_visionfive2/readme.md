# starfive visionfive2

## bootable sd card images

- https://github.com/velvet-os/imagebuilder/releases/tag/240519-01
- https://github.com/velvet-os/imagebuilder/releases/tag/230321-02
- https://github.com/velvet-os/imagebuilder/releases/tag/230115-01

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
- it looks like the hifive specific partition types in fdisk got renumbered (most probably to their final numbers) in fdisk now in the proper debian sid packages and as a result the partition numbers in gpt-partitions.txt changed from 198 to 207 and from 197 to 206 to make images built with this newer fdisk boot properly - in case images are still built on older versions of debian with the old numbers, then the numbers have to be reverted back in gpt-partitions.txt
- the serial console (3.3v 115200) can be accessed from the gpio headers 6 (gnd), 8 (tx on vf2, rx on usb-serial converter) and 10 (rx on vf2, tx on usb-serial converter)
- more info coming soon
