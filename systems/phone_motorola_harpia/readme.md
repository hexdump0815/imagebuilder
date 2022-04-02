# motorola moto g4 play - harpia

## bootable sd card images

- https://github.com/hexdump0815/imagebuilder/releases/tag/211231-02

## tested systems - working

- motorola moto g4 play xt1602 - harpia

## untested systems

- motorola moto g4 play xt1603
- motorola moto g4 play xt1604
- motorola moto g4 play xt1607

## kernel build notes

- right now i'm still using a postmarketos kernel+initrd=boot.img and will maybe later move to an own boot.img
  - https://github.com/hexdump0815/pmaports-other/tree/main/linux-postmarketos-qcom-msm8916
  - https://github.com/hexdump0815/pmaports-other/tree/main/device-motorola-harpia

## priority

- low: will be worked on and improved rarely

## special notes

- this is not very useable yet, still in a very early and experimental phase
- to install write the image to an sd card and install lk2nd-msm8916.img from https://github.com/msm8916-mainline/lk2nd/releases via the instructions in https://github.com/msm8916-mainline/lk2nd/blob/master/README.md
- a1 rated sd cards are highly recommended as otherwise the performance will be bad due to bad random disk io
- if the phone is connected to a computer or power supply via usb a shutdown will result in a reboot, disconnecting it will let it shutdown properly
- sometimes there the system was hanging during shutdown, tapping onto the screen a few times seems to help
- in case of problems with the boot process the phone does not seem to respond to the power button anymore to turn it off, pressing the vol-down and the power button together for a while might help out in those situation
- sound does not seem to work
- wifi only works partially (see link below)
- see also: https://wiki.postmarketos.org/wiki/Motorola_Moto_G4_Play_(motorola-harpia)
- if the usb port in the kernel is switched from "peripheral" to "host" mode in the dtb it is possible to connect usb devices (keyboard, mouse, ethernet etc.) to it via a powered otg usb hub ... it has to be powered as the usb port itself will not provide power ... it looks like the phone even gets powered well via the powered hub in this mode
