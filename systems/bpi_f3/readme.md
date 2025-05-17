# banana pi f3

## bootable sd card images

- https://github.com/velvet-os/imagebuilder/releases/tag/240521-01

## tested systems - working

- banana pi f3 (4gb ram / 16gb emmc version running from sd card)

## untested systems

- banana pi f3 (2gb ram / 8gb emmc version)

## kernel build notes

- https://github.com/hexdump0815/linux-spacemit-k1-kernel/blob/main/readme.bf3

## u-boot build notes

- none yet as for now the vendor u-boot on the sd card is used

## mesa build notes

- none yet, but will come once its time to look closer at gpu support

## priority

- medium: some first experiments with a useable riscv64 sbc

## special notes

- all this is very much wip and not that useable yet
- the image has only been tested with the 4gb ram version of the bpi f3 and it looks like at least the 2gb ram version needs some special steps to get it booting - see: https://forum.banana-pi.org/t/bpi-f3-not-booting/18574/5
- more info coming soon
