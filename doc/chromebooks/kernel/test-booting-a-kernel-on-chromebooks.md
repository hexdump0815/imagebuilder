in case one wants to test boot a new kernel on a chromebook
using the native depthcharge/kpart mechanism without risking
to have a non working system in case the new kernel does not
boot properly, the following command can be used to instruct
the bootloader to boot once from the second kernel partition
and go back to the regular first kernel partition on the
next boot afterwards:

cgpt add -i 2 -S 0 -T 1 -P 15 /dev/mmcblk0

the above command sets the number of tries (-T) to boot from
the second partition (-i) to 1 and increases its boot
priority to 15 (-P), which is higher than the priority of 
the default kernel partition 1 (10) - see "cgpt add --help"
for more info on those options. after the defined single
boot from kernel partition 2 depthcharge will reset the boot
parameters, so that the next boot will happen as usual from
kernel partition 1. of course to be able to boot from the
second kernel partition one has to install a proper kpart
format kernel to the second kernel partition via the dd
command.

for this to work well it is important to have a fixed root
filesystem defined in the kernel cmdline like

  root=LABEL=xyz

or

  root=/dev/xyz

this is the case for all the chromebook kernels used in
imagebuilder images using the dephcharge/kaprt meachnism
for booting (and in general for the other imagebuilder
images as well).

the relative root filesystem syntax used on chromebooks at
other places sometimes like

  root=PARTUUID=%U/PARTNROFF=1

will not work, as it references the root partition relative
to the kpart partition, which does no longer work if the
kernel is booted from the kernel partition 2 instead of 1
(in the example above the root filesystem is expected at the
next partition after the kernel partition, i.e. offset=1)

for testing and debugging kernel topics it might be useful to
be able to see the kernel console output during boot. for
this a special suzyqable is required and the following should
be added to the kernel commandline when building the kpart
kernel image (after the already existing console= entry, as
only the last console= entry has the highest priority for
displaying the kernel boot log)

  console=ttyS0,115200n8 earlycon
