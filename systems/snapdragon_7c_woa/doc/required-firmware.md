# required firmware

for certain functionalities of the qcom sc7180 (7c) like gpu, wifi and most
proably quite a few more to work firmware files are required. this document
is the try to collect information about what is needed and where it can be
obtained from. some of the files are part of the linux-firmware repo and some
will have to be copied from the windows installation of the device as the
firmware is often signed. the firmware files can usually be found at the
path c:/Windows/System32/DriverStore/FileRepository in the windows
installation. in a wsl shell on windows this means we are interested in the
following files:
```
cd /mnt/c/Windows/System32/DriverStore/FileRepository
tar czf /tmp/windows-firmware.tar.gz */*.mbn */*.jsn
```
fomr this archive it is possible to pick the required firmware files then
later for the linux side - the actual files are in subfolders and for some
there are multiple versions around - in those cases the latest should be the
best.

for this and other reasones it is a good idea to leave a windows installation
on the device - only this way it is possible to get firmware and bios updates
and besides that some information useful for linux bringup can be found in
*.inf files and the registry in windows.

## required firmware files for the acer aspire 1

for this system the following files have to be put into
/lib/firmware/qcom/sc7180-acer-aspire1:
```
adspr.jsn
adspua.jsn
cdspr.jsn
modemr.jsn
modemuw.jsn
qcadsp7180.mbn
qccdsp7180.mbn
qcdxkmsuc7180.mbn
qcmpss7180.mbn
qcmpss7180_nm.mbn
qcvss7180.mbn
wlanmdsp.mbn
```

see also:
- https://oftc.irclog.whitequark.org/aarch64-laptops/2023-02-21#31912679
- https://gist.githubusercontent.com/TravMurav/7ccd69932260e0477ead267873062e7e/raw/1d554139e68e14d60089fc6ce0f91b86339d6e1e/aspire-1-firmware-list.txt

## required firmware files for the samsung galaxy book go

for this system the following files have to be put into
/lib/firmware/qcom/sc7180-samsung-galaxy-book-go:
```
adspr.jsn
adspua.jsn
cdspr.jsn
modemr.jsn
modemuw.jsn
qcadsp7180.mbn
qccdsp7180.mbn
qcdxkmsuc7180.mbn
qcmpss7180_BTU.mbn
qcmpss7180_nm.mbn
qcvss7180.mbn
wlanmdsp.mbn
```
