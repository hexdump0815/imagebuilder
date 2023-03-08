# snapdragon 7c based windows on arm laptops

## bootable sd card images

- https://github.com/hexdump0815/imagebuilder/releases/tag/230308-01
- https://github.com/hexdump0815/imagebuilder/releases/tag/230305-01
- https://github.com/hexdump0815/imagebuilder/releases/tag/221101-01

## tested systems - working

- samsung galaxy book go (snapdragon 7c gen2)
- acer aspire 1 a114-61 (snapdragon 7c)

see also https://github.com/hexdump0815/imagebuilder/issues/136 for all above

## untested systems

- asus exportbook b3 detachable b3000 (snapdragon 7c gen2)
- hp laptop 14 (14-ed0123wm) (snapdragon 7c gen2)
- lenovo 10w 82st (snapdragon 7c gen2)
- tcl book 14 go (snapdragon 7c)
- jp.ik turn connect t101 (snapdragon 7c)
- jp.ik leap connect t304 (snapdragon 7c)
- positivo wise n1212S (snapdragon 7c)

## kernel build notes

- https://github.com/hexdump0815/linux-mainline-qcom-msm8998-kernel/blob/main/readme.qc7

## priority

- low: will be worked on and improved rarely, still very limited mainline support

## special notes

- this is very much work in progress, not really useable yet and mostly ment as a starting point for helping to bring mainline linux forward on this platform
- the grub setup so far is only an ugly hack to make it boot at all and the boot config is currently hard coded in /boot/boot/grub/grub.cfg
- currently the dtb file for the samsung galaxy book go is hard coded in the grub config file, this needs to be adjusted in case of the aspire 1 or another snapdragon 7c system (handled via two grub menu entries since 230305-01 now)
- the root filesystems is currently still set to ext4 (but the usual btrfs should work as well i guess) (switched to btrfs root since 230305-01)
- so far only tested with bookworm, not sure if grub etc. in jammy is new enough to be working
- the linux support for those snapdragon 7c on windows on arm system is in its very early stages, but there is quite a bit of useable code already there from the snapdragon 7c chromebooks (trogdor)
- booting should only be done from usb for now, please keep the windows installation on emmc/ufs as it might be required to get updated firmware files from it still
- secure boot needs to be disabled in the bios in order to be able to boot those images as all
- some info on the samsung galaxy book go bringup can be found here: https://oftc.irclog.whitequark.org/aarch64-laptops/2022-10-18#31531590 and the following days and some info about the acer aspire 1 can be found here: https://oftc.irclog.whitequark.org/aarch64-laptops/2022-07-30#31145280
- samsung galaxy book go notes:
  - to enter the bios press f2 early after boot, sometimes it takes a few tries until it will enter the bios
  - to enter the boot selector press f10 early after powering on the device, sometimes it takes quite a few tries until the usb disk is detected by the boot selector (should be something like "uefi: usb ..." in the menu)
  - booting from usb seems to be quite selective on the device used: a sandisk ultra stick was detected only at around each 10th try, some no name slow cheap usb device worked much better, so some experimentation might be required
  - the right usb-c port (left not tested yet) is also working if some usb-c hub or adapter is connected to it while booting, this way a usb hub can be used to connect a mouse and usb ethernet
  - working so far: display framebuffer, keyboard (needs some key press during boot to get rid of logged errors), usb-a, usb-c (if connected together with usb-a at boot time already), gpu if at least one firmware file from windows is installed
  - some interesting info: https://github.com/aarch64-laptops/debian-cdimage/issues/21
- acer aspire 1 a114-61 notes:
  - the started mainline port for it by nikita travkin (travmurav):
    - https://github.com/TravMurav/linux/tree/aspire1
    - https://gitlab.com/TravMurav/pmaports/-/tree/aspire1/device/testing/linux-postmarketos-qcom-sc7180
    - https://gitlab.com/TravMurav/pmaports/-/tree/aspire1/device/testing/device-acer-aspire1
  - working so far (beyond what is supported on the samsung galaxy book go): touchpad, wifi, bt (not sure), audio (maybe), battery status
