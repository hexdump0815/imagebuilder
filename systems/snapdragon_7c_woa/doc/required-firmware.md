# required firmware

for certain functionalities of the qcom sc7180 (7c) like gpu, wifi and most
proably quite a few more to work firmware files are required. this document
is the try to collect information about what is needed and where it can be
obtained from. some of the files are part of the linux-firmware repo and some
will have to be copied from the windows installation of the device as the
firmware is often signed. the firmware files can usually be found at the
path C:\Windows\System32\DriverStore\FileRepository in the windows
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

for this and other reasons it is a good idea to leave a windows installation
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
for gpu functionality only qcdxkmsuc7180.mbn is required, the other files are
required for things like wifi, video decoding, audio etc.

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
for gpu functionality only qcdxkmsuc7180.mbn is required, the other files are
required for things like wifi, video decoding, audio, lte modem etc.

it looks like there is still some problem with the qcmpss7180 firmware on the
samsung galaxy book go and as a result it is better to move those two files
away for now as otherwise the log might get spammed by failed tries to load
it.

## steps required to enable gpu support with the firmware files in place

after the firmware files were put into place as described above the following
steps have to be run as root on the system in order to enable gpu support in
xorg:
```
cp /etc/X11/xorg.conf.d.samples/11-modesetting.conf /etc/X11/xorg.conf.d
rm /etc/X11/xorg.conf.d/11-fbdev.conf
update-initramfs -c -k $(uname -r)
```
after a reboot freedreno support should be enabled in xorg if everything is
setup correctly.

## some general notes around firmware and firmware loading

i noticed filesystem errors when running from usb and i'm not sure if those
started when i started playing around with the firmware files or if they
were around already before (i.e. some independent usb problem then). it
could be that this is also related to firmware loading similar to what is
described here (and in the lines around):
https://oftc.irclog.whitequark.org/aarch64-laptops/2023-01-28#31850582
but this does not have to be the case.

update: the latest image has the pd mapper disabled by default and it looks
like with this the filesystem corruption is gone when running with an usb
rootfs ... only minimal testing done so far, but as it was running reliable
before i started to look into firmware loading and as part of that playing
around with pd-mapper this might maybe really be it. in that case the
pd-mapper startup most probably will have to move into initrd when there is
no usb rootfs mounted yet.
