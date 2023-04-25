# special setup required for apollo and gemini lake chromebooks

## overview

these notes describe the extra steps required to use the chromebook_x86_uefi
image on a chromebook with and apollo or gemini lake soc, i.e. with a celeron
or pentium silver n33xx, n34xx, n40xx, n41xx, n42xx and n50xx (maybe some more
or less than those even).

the steps cover two adjustements usually required for those devices:

- enable uefi booting
- make audio work
- switch suspend to s2idle mode

## enable uefi booting

in order to use the chromebook_x86_uefi image the boot process of the
chromebook has to be adjusted or changed to support booting via the widely
used uefi mechanism instead of the default depthcharge/kpart boot mechanism.
there are two ways to do this:

- adding an uefi rw payload to the bootloader (might not always work but is
  nearly risk free)
- replace the bootloader entirely with one only supporting uefi (requires ro
  access to the firmware flash where the bootloader lives and is more risky)

### adding an uefi rw payload to the bootloader

i found some information that it is possible to add a rw uefi payload to the
standard chromebook bootloader and did some experiments partially documented
here: https://github.com/hexdump0815/coreboot-cb-rw-uefi-payload

this procedure should work for all or at least most of the newer devices, but
maybe even for all apollo and gemini lake chromebooks. the good thing about it
is that it is nearly risk free as it only writes to some of the overwritable
regions of the bootloader flash (the so called rw region) and it is kind of
impossible to brick a chromebook this way, i.e. even if it does not work in
the end, the chromebook should still boot fine to chromeos afterwards by
pressing ctrl-d on the white boot screen. it did not work though for me when
trying to do it the apollo lake way described below for a skylake based chell
chromebook. for a kabylake based eve chromebook it seems to have worked for at
least one person - see: https://github.com/MrChromebox/firmware/issues/122

this procedure assumes a well charged apollo or gemini lake chromebook with
chromeos installed and the developer mode enabled and logged in as chronos
user on the console or in a terminal tab of chrome plus switching to the root
user there.

first it is a good idea to update your chromeos to the latest version and set
the crossystem dev_boot flags to allow at least usb booting by default as
described here:
https://github.com/hexdump0815/linux-mainline-on-arm-chromebooks in the
section about enabling the developer mode. in case the chromebook already has
the write protection disabled then it is a good idea to set the gbb flags
accordingly as described in the same document.

now find the codename of your chromebook and check if there is a uefi firmware
for it at https://mrchromebox.tech/#devices - next find the name of the
firmware file for that codename at
https://github.com/MrChromebox/scripts/blob/master/sources.sh - afterwards
follow the steps as described below.

#### apollo lake example

older (mostly apollo lake) chromebooks without solid altfw support (example
here: coral-rabbid - it did not work for a coral-robo360 for me, so it might
work or not depending on the actual chromebook model):

- save a backup copy of the original bios image before changing anything as it
  is always good to have it around just in case - so better transfer it (the
bios.bin.backup file) to a safe place
```
cd /tmp
flashrom -p host -r bios.bin.backup
cp bios.bin.backup bios.bin
```
- double check the size of the RW_LEGACY section - required later below
```
fmap_decode bios.bin | grep RW_LEGACY
```
- get the mrchromebox uefi firmware - the actual filename should be adjusted
  to chromebook type the procedure is done on
```
curl -LO https://www.mrchromebox.tech/files/firmware/full_rom/coreboot_tiano-rabbid-mrchromebox_20220718.rom
```
- extract the uefi payload from it
```
cbfstool coreboot_tiano-rabbid-mrchromebox_20220718.rom extract -n fallback/payload -m x86 -f cbox.pl
```
- create a proper RW_LEGACY firmware file out of it - keep in mind the size
  found out above
```
cbfstool rwl.bin create -m x86 -s 0x00200000
cbfstool rwl.bin add-payload -f cbox.pl -c lzma -n payload
dd if=/dev/zero of=smmstore bs=256k count=1
cbfstool rwl.bin add -f smmstore -n "smm store" -t raw -b 0x1bf000
```
- write the freshly created rw uefi firmware to the RW_LEGACY section of the
  flash
```
flashrom -p host -w -i RW_LEGACY:rwl.bin
```
- enable usb booting and make it the default (if wanted - otherwise: ctrl-u
  for usb/sd and and ctrl-d for emmc on boot)
```
crossystem dev_boot_usb=1
crossystem dev_default_boot=usb
```
- reboot with an uefi linux image on usb or sd card
- it might be required to enter the uefi bios on bootup using "esc" when
  offered to switch the boot device to the desired one in the "boot menu"
section of the bios. please keep in mind that the sd card might appear there
named like "generic usb device" as the sd card slot might be connected via usb
internally.

#### gemini lake example

newer (mostly gemini lake) chromebooks with more solid altfw support (example
here: octopus-blooglet):

- save a backup copy of the original bios image before changing anything as it
  is always good to have it around just in case - so better transfer it (the
bios.bin.backup file) to a safe place
```
cd /tmp
flashrom -p host -r bios.bin.backup
cp bios.bin.backup bios.bin
```
- get the mrchromebox uefi firmware - the actual filename should be adjusted
  to chromebook type the procedure is done on
```
curl -LO https://www.mrchromebox.tech/files/firmware/full_rom/coreboot_tiano-blooglet-mrchromebox_20220718.rom
```
- extract the uefi payload from it
```
cbfstool coreboot_tiano-blooglet-mrchromebox_20220718.rom extract -n fallback/payload -m x86 -f cbox.pl
```
- remove the original altfw tianocore payload
```
cbfstool bios.bin remove -r RW_LEGACY -n altfw/tianocore
```
- i guess this is required to avoid chromeos updates overwriting our changed
  firmware
```
cbfstool bios.bin remove -r RW_LEGACY -n cros_allow_auto_update
```
- add the new altfw tianocore payload
```
cbfstool bios.bin add-payload -r RW_LEGACY -n altfw/tianocore -f cbox.pl -c lzma
```
- write the RW_LEGACY section of the adjusted firmware to flash
```
flashrom -p host -i RW_LEGACY -w bios.bin
```
- enable altfw booting and make it the default (might not work if not set to
  default)
```
crossystem dev_boot_altfw=1
crossystem dev_default_boot=altfw
```
- reboot with an uefi linux image on usb or sd card
- it might be required to enter the uefi bios on bootup using "esc" when
  offered to switch the boot device to the desired one in the "boot menu"
section of the bios. please keep in mind that the sd card might appear there
named like "generic usb device" as the sd card slot might be connected via usb
internally.

#### setting gbb flags

if the flash rom write protection is already removed it is recommended to set
the gbb flags to 0x1499 - for more information about this topic see:
https://github.com/hexdump0815/linux-mainline-on-arm-chromebooks

this value is built from the sum of the following enabled flags:
```
VB2_GBB_FLAG_DEV_SCREEN_SHORT_DELAY - 0x1
VB2_GBB_FLAG_FORCE_DEV_SWITCH_ON - 0x8
VB2_GBB_FLAG_FORCE_DEV_BOOT_USB - 0x10
VB2_GBB_FLAG_FORCE_DEV_BOOT_ALTFW - 0x80
VB2_GBB_FLAG_DEFAULT_DEV_BOOT_ALTFW - 0x400
VB2_GBB_FLAG_DISABLE_LID_SHUTDOWN - 0x1000
```
see: https://github.com/MrChromebox/scripts/issues/89#issuecomment-1252758487

### replace the bootloader entirely with one only supporting uefi

in case write protection to the firmware flash has already been disabled it is
possible to replace the bootloader entirely with one only supporting uefi
booting. for this please have a look at https://mrchromebox.tech/ - there it
is possible to see if such a uefi firmware is available a certain chromebook
and there is a lot of documentation about the process of installing it. please
keep in mind that this approach (although well tested usually) is a bit more
risky as replacing the bootloader entirely might result in a bricked device in
the worst case - the risk for that should be very low and in many cases it
should be possible to unbrick it again on newer chromebooks with ccd, but one
should at least be aware of that risk.

## make audio work

to make audio work on apollo and gemini lake chromebooks the following steps
are required:

- uncomment some lines in /etc/modprobe.d/sound-apl-glk.conf - see the file
  itself for some more info
- rebuild the initrd via "initramfs -c -k kernel-version" (not sure if this is
  strictly required, but it cannot harm)
- only required for gemini lake chromebooks: point the firmware to the
  community signed version instead of the default intel signed one and block
further updates to the corresponding firmware package to avoid the changed
symlink getting overwritten by an update
```
cd /lib/firmware/intel/sof
mv sof-glk.ri sof-glk.ri.org
ln -s community/sof-glk.ri sof-glk.ri
apt-mark hold firmware-intel-sound
```
- after a reboot audio should hopefully work, it might be required to switch
  from headphones in pulseaudio once as for some reason the configuration used
seems to default to headphones initially by default
- it might require a special kernel build to work - see
  https://github.com/hexdump0815/linux-mainline-x86-64-kernel/releases and
https://github.com/hexdump0815/imagebuilder/blob/main/doc/installing-a-newer-kernel.md

## switch suspend to s2idle mode

as regular deep suspend most likeliy does not work with those apollo and
gemini lake chromebooks it is required to to switch to s2idle mode for
suspend. this can be done very easily by uncommenting the corresponding line
in /etc/rc.local and rebooting or running the uncommented line once by hand.
even in s2idle mode the power consumption will be very low in suspend mode and
the system should survive several days in this mode.
