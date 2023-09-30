# required firmware

for certain functionalities of the qcom sm7125 like gpu, wifi and most
proably quite a few more to work firmware files are required. this document
is the try to collect information about what is needed and where it can be
obtained from. some of the files are part of the linux-firmware repo and some
will have to be copied from the android installation of the device as the
firmware is often signed. the firmware files can usually be found on the
imagefv (/dev/sda22 on a72) and modem partitions (/dev/sda18 on a72 - i guess
the partitions will be the same on a52 most probably) of the device. it looks
like the files can differ between different versions for those phones, as for
instance the map220v firmware files (https://github.com/map220v/a72q-firmware)
did not work on my phone.

## installing the required firmware files for the samsung galaxy a52/a72

for this system the files from the image subdir of the above mentioned
partitions have to be copied to /lib/firmware/qcom/sm7125 - the following
procedure worked for me after an initial boot of the device with the provided
image and a powered usb-c hub with an ethernet connection (this is for an a72,
for an a52 some lines will have to be adjusted accordingly):
```
mkdir /tmp/fwmnt
mkdir /lib/firmware/qcom/sm7125/a72q
mount -o ro /dev/sda22 /tmp/fwmnt
cp -v /tmp/fwmnt/image/* /lib/firmware/qcom/sm7125/a72q
umount /tmp/fwmnt
mount -o ro /dev/sda18 /tmp/fwmnt
cp -av /tmp/fwmnt/image/* /lib/firmware/qcom/sm7125/a72q
umount /tmp/fwmnt
rmdir /tmp/fwmnt
```
and the wlanmdsp.mbn file has to be put additionally as well into
/lib/firmware/ath10k/WCN3990/hw1.0 (at least it has to be put there in case
wifi does not work properly with the original file, for instance it might
properly connect to the wifi without working network connections in the end)
```
cp -v /lib/firmware/qcom/sm7125/a72q/wlanmdsp.mbn /lib/firmware/ath10k/WCN3990/hw1.0
```
and the zap shader files have to be put into the qcom firmware directory
```
cp -v /lib/firmware/qcom/sm7125/a72q/a615_zap.* /lib/firmware/qcom
```

## steps required to enable gpu support with the firmware files in place

nothing special is required - as soon as the firmware files are in place the
gpu should be probed properly ("grep glamor /var/log/Xorg.0.log" should give
"modeset(0): glamor initialized"). the gpu related warnings early in the boot
process can be ignored as in the early boot the firmware is missing in the
initrd, but a reload will be retied automatically when the rootfs has been
mounted. to get rid of the early warnings the inird and then the boot.img could
be rebuilt and reinstalled. this step is required to get the lte modem
initialized properly.

## rebuilding the initrd, the boot.img and reinstalling it to enable the lte modem

coming soon
