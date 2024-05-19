# milk-v duo

## bootable sd card images

- none yet

## tested systems - working

- milk-v duo 64mb

## untested systems

- milk-v duo 256m (could be made working with some extra adjustments most probably)
- milk-v duo-s 512m (could be made working with some extra adjustments most probably)
- lichee rv nano (could be made working with some extra adjustments maybe)

## kernel build notes

- https://github.com/hexdump0815/linux-cvitek-cv18xx-kernel/blob/main/readme.duo

## u-boot build notes

- none yet as for now the vendor u-boot etc. is used

## mesa build notes

- not required as no gpu and too little memory

## priority

- medium: some first experiments with a useable riscv64 sbc

## special notes

- all this is very much wip and not that useable yet
- for now ext4 is used as root fs as btrfs with compression as usual for those images does not make sense on such a low power system
- more info coming soon
