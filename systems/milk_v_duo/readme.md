# milk-v duo

## bootable sd card images

- https://github.com/hexdump0815/imagebuilder/releases/tag/240526-01

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
- the same applies to zswap memory compression: it does not make sense for a system with so little memory and cpu resources
- the image has rndis usb networking enabled by default, i.e. if connected to and powered via another computer by a usb-c/a cable a network connection via this usb connection should be established if the other computer is setup properly
- the image will also work with the milk-v io-board for the duo and a network connection should be possible via the ethernet port
- the usb ports are not working by default with the io-board as that would conflict with the rndis usb network setup enabled by default for non io-board use cases - they can be enabled via "rc-update delete usb-rndis default; rc-update add usb-host default" and a reboot afterwards
- when the system has booted the blue led will start blinking after around one minute and the network connection should be available after about another minute
- beware that there are devices where the blue led is broken and they will as a result not blink even if everything is working properly (i alone own two of such slightly broken devices)
- for the sipeed lichee rv nano, milk-v duo 256mb and duo-s there are also very nice debian images available from fishwaldo: https://github.com/Fishwaldo/sophgo-sg200x-debian
- more info coming soon
