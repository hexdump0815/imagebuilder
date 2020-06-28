based on the gentoo-on-rpi-64bit boot as based on that i finally got 64bit, u-boot and working vc4/v3d working
-> https://github.com/sakaki-/gentoo-on-rpi-64bit ... /boot firmware files are taken from the respberry os 64bit beta

some notes:
- it looks like the the *.dtb files in /boot directly are needed for the startup loader
- on the raspi those are then also used by the kernel, in this u-boot setup the kernel loads its own dtb later
- the overlay folder could go in theory i think as we do not use it here, but lets keep it for completeness
- in theory this should also work for rpi < 4
- the boot.txt is just an example for potentially setting u-boot variables and then boot extlinux from menu dir
