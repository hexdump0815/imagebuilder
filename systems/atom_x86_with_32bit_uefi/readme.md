# intel 64bit atom (z3735f, z3470d, z8300, z8350 etc.) systems (often tablets) with 32bit uefi bios

## bootable sd card images

- https://github.com/hexdump0815/imagebuilder/releases/tag/220912-02
- https://github.com/hexdump0815/imagebuilder/releases/tag/210811-01

## tested systems - working

- chuwi vi8 windows 10 / android tablet
- dell venue 8 pro windows 10 tablet (model 5830 only)
- teclast x80 hd windows 10 / android tablet
- linx 1010b windows 10 tablet / 2 in 1
- unobook 2in1 educational laptop
- beelink z83 box

## untested systems

- there are for sure various other windwos 10 / android tablets which may work with this image

## kernel build notes

- the regular debian/ubuntu distribution kernel is used in this case, so no kernel build required
- https://github.com/hexdump0815/linux-mainline-x86-64-kernel/blob/main/readme.d8p
  - old special kernel for the dell venue 8 pro which seems to no longer be required

## priority

- low: will be worked on and improved rarely, not that much left to be done

## special notes

- to change the screen orientation to landscape mode by default /etc/lightdm/lighdm.conf needs to be adjusted by uncommenting the corresponding shell script for supported devices
- some things relevant for the dell venue 8 pro:
  - to enter the bios press esc often on poweron and as soon as the dell logo appears press f2
  - bluetooth and the cameras are not supported yet
  - be careful with the micro-usb connector as it is the rare type-a version into which a type-b plug can easily inserted the wrong way around which most probably would kill the device
  - there is a lot of information about running linux on the dellvenue 8 pro at https://www.studioteabag.com/science/dell-venue-pro-linux/
- some things relevant for the chuwi vi8
  - the touch screen is not supported by default as the required kernel module is not enabled in the debian kernel (CONFIG_TOUCHSCREEN_SILEAD) - a cusomt kernel has to be built to enable it
- some things relevant for the unobook
  - the cameras are not supported yet
  - sound does not give output neither via speaker nor via headphone jack
  - the touchpad does not seem to be able to handle multiple fingers, but there is a vertical scroll area on the right side at least
  - the devices seem to come with secure boot enabled and it was quite tricky to get it disabled as so far i did not find any key to get directly into the bios
    - luckily my device did boot from usb first, not sure if this is the default
    - i was able to get into the bios by booting the debian bullseye default i386 installer, go to the grub cmdline there and exit it via 'exit' command - also exiting this way from an efi shell works in case someone ends up in an efi shell
    - after such an exit the bios boot device menu was shown, from there one can get into another menu via 'tab' key from which one can enter the bios setup and disable secure boot in it
    - a plan b i had in mind was to use the mokutil command to try to disable secure boot from within a debian bullseye system installed with secure boot enabled using the default i386 installer
- something relevant for the beelink z83
  - it is recommended to run "apt-get install r8168-dkms" to install a ethernet driver, which is more stable (with the default in kernel driver ethernet sometimes worked and sometimes not
