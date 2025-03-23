# samsung galaxy tab a 9.7 - gt510

## bootable sd card images

- https://github.com/hexdump0815/imagebuilder/releases/tag/231111-01
- https://github.com/hexdump0815/imagebuilder/releases/tag/211231-01

## tested systems - working

- samsung galaxy tab a 9.7 lte - sm-t555

## untested systems

- samsung galaxy tab a 9.7 wifi - sm-t550
- samsung galaxy tab a 9.7 wifi pen - sm-p550
- samsung galaxy tab a 9.7 lte pen - sm-p555

## kernel build notes

- right now i'm still using a postmarketos kernel+initrd=boot.img and will maybe later move to an own boot.img
  - https://github.com/hexdump0815/pmaports-other/tree/main/linux-postmarketos-qcom-msm8916
  - https://github.com/hexdump0815/pmaports-other/tree/main/device-samsung-gt510

## priority

- medium: will be worked on and improved from time to time

## special notes

- this is not very useable yet, still in a very early and experimental phase
- the lte models of those tablets have 2gb or ram and the wifi ones only 1.5gb
- to install write the image to an sd card and install lk2nd-msm8916.img from https://github.com/msm8916-mainline/lk2nd/releases via the instructions in https://github.com/msm8916-mainline/lk2nd/blob/master/README.md
- a1 rated sd cards are highly recommended as otherwise the performance will be bad due to bad random disk io
- it looks like those devices will not run from all kinds of sd cards, so in case of a non booting device trying a different sd card might be worth a try (known to be working: sandisk ultra a1 32gb)
- for some reason at least once the firmware loading for wifi did not work after the first boot, after rebooting it worked
- if the tablet is connected to a computer or power supply via usb a shutdown will result in a reboot, disconnecting it will let it shutdown properly
- sometimes there the system was hanging during shutdown, tapping onto the screen a few times seems to help (i did not see this happen anymore in recent times)
- in case of problems with the boot process the tablet does not seem to respond to the power button anymore to turn it off, pressing the vol-down and the power button together for a while might help out in those situations
- see also https://wiki.postmarketos.org/wiki/Samsung_Galaxy_Tab_A_9.7_2015_(samsung-gt510)
- for changing the kernel config via the pmbootstrap framework the following command should be used as the msm8916 kernel can be built for armv7l or aarch64: pmbootstrap kconfig edit --arch aarch64 postmarketos-qcom-msm8916
- if the usb port in the kernel is switched from "peripheral" to "host" mode in the dtb (which is the case for latest kernel used here) it is possible to connect usb devices (keyboard, mouse, ethernet etc.) to it via a powered otg usb hub ... it has to be powered as the usb port itself will not provide power ... it looks like the tablet even gets powered well via the powered hub in this mode
- suspend via s2idle mode seems to work quite well and the tablet should be able to survive more than a day in this mode - wakeup can be done via a short press on the power button or by conneting power to usb
  - sadly it seems to wake up on its own after about 30-60 minutes for yet unknown reasons
  - the whole suspend/resume topic seems to be still very fragile here as just upgrading from v5.18.1 to v5.18.10 results in suspend working the first time, but waking up immediately again at the second suspend try
