# samsung galaxy tab a 9.7 - gt510

## bootable sd card images

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

## special notes

- this is not very useable yet, still in a very early and experimental phase
- the lte models of those tablets have 2gb or ram and the wifi ones only 1.5gb
- to install write the image to an sd card and install lk2nd-msm8916.img from https://github.com/msm8916-mainline/lk2nd/releases via the instructions in https://github.com/msm8916-mainline/lk2nd/blob/master/README.md
- a1 rated sd cards are highly recommended as otherwise the performance will be bad due to bad random disk io
- for some reason at least once the firmware loading for wifi did not work after the first boot, after rebooting it worked
- if the tablet is connected to a computer or power supply via usb a shutdown will result in a reboot, disconnecting it will let it shutdown properly
- sometimes there the system was hanging during shutdown, tapping onto the screen a few times seems to help
- in case of problems with the boot process the tablet does not seem to respond to the power button anymore to turn it off, pressing the vol-down and the power button together for a while might help out in those situation
- see also https://wiki.postmarketos.org/wiki/Samsung_Galaxy_Tab_A_9.7_2015_(samsung-gt510)
