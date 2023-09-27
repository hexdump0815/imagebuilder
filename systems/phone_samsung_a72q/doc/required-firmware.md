# required firmware

for certain functionalities of the qcom sm7125 like gpu, wifi and most
proably quite a few more to work firmware files are required. this document
is the try to collect information about what is needed and where it can be
obtained from. some of the files are part of the linux-firmware repo and some
will have to be copied from the android installation of the device as the
firmware is often signed. the firmware files can usually be found on the
imagefv and modem partitions.

more info coming soon ...

## required firmware files for the samsung galaxy a52/a72

for this system the following files have to be put into
/lib/firmware/qcom/sm7125:
```
coming soon ...
```
and the following file has to be put additionally as well into
/lib/firmware/ath10k/WCN3990/hw1.0 (at least it has to be put there in case
wifi does not work properly with the original file, for instance it might
properly connect to the wifi without working network connections in the end)
```
wlanmdsp.mbn
```

## steps required to enable gpu support with the firmware files in place

coming soon ...
