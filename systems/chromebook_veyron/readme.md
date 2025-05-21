# chromebook veyron

## bootable sd card images

- https://github.com/velvet-os/imagebuilder/releases/tag/231001-02
- https://github.com/velvet-os/imagebuilder/releases/tag/230218-05
- https://github.com/velvet-os/imagebuilder/releases/tag/220820-01
- https://github.com/velvet-os/imagebuilder/releases/tag/220611-02
- https://github.com/velvet-os/imagebuilder/releases/tag/210731-01
- https://github.com/velvet-os/imagebuilder/releases/tag/210613-03
- https://github.com/velvet-os/imagebuilder/releases/tag/210321-01
- https://github.com/velvet-os/imagebuilder/releases/tag/200526-01

## tested systems - working

- medion chromebook s2013 - jaq
- medion chromebook s2015 - mighty
- asus chromebook c201 - speedy
- asus chromebook c100 - minnie
  - see also: https://github.com/velvet-os/imagebuilder/issues/16
- hisense chromebook 11 - jerry
- edugear chromebook m series - mighty
  - see also: https://github.com/velvet-os/imagebuilder/issues/110
- asus chromebit cs10 - mickey
  - u-boot not working yet: https://github.com/velvet-os/imagebuilder/issues/130#issuecomment-1454334195

see also https://github.com/velvet-os/imagebuilder/issues/81 for all above

## untested systems

(list below from: https://www.chromium.org/chromium-os/tpm_firmware_update?tmpl=/system/app/templates/print/&showPrintDialog=1)

- haier chromebook 11 -jaq
- true idc chromebook 11 - jaq
- xolo chromebook - jaq
- ctl j2 / j4 chromebook for education - jerry
- edugear chromebook k series - jerry
- epik 11.6" chromebook elb1101 - jerry
- mecer chromebook - jerry
- ncomputing chromebook cx100 - jerry
- poin2 chromebook 11 - jerry
- positivo chromebook ch1190 - jerry
- videonet chromebook bl10 - jerry
- chromebook pcm-116e - mighty
- haier chromebook 11e - mighty
- lumos education chromebook - mighty
- nexian chromebook 11.6-inch - mighty
- prowise 11.6" entry line chromebook - mighty
- sector 5 e1 rugged chromebook - mighty
- viglen chromebook 11 - mighty

## generic mainline linux on arm chromebook notes

- https://github.com/hexdump0815/linux-mainline-on-arm-chromebooks/blob/main/readme.md

## kernel build notes

- https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/blob/master/readme.cbr

## u-boot build notes

- https://github.com/hexdump0815/u-boot-chainloading-for-arm-chromebooks/blob/master/readme.cbr

## mesa build notes

- https://github.com/hexdump0815/mesa-etc-build/blob/master/mesa-build.txt

## priority

- medium: will be worked on and improved from time to time

## special notes

- the veyron chromebooks seem to not boot properly with all sd cards (and as it seems not at all from usb devices) ... if booting does not work it might be worth to try different sd cards ... older and smaller ones seem to have the higher chance to work well
- for all images starting with 210731-01 full deep suspend/resume seems to be working, but sometimes maybe not that reliable (it might be considered to switch to s2idle for suspend in /etc/rc.local in case it should be too unreliable)
- for some strange reason the sound output will be set to headphone by default after the first boot and needs to be switched to speakers manually once
- sound seems to be gone after resume from suspend, if it is really required it might be considered to switch to s2idle for suspend in
/etc/rc.local
- by default the image will boot on veyron mighty, all other systems will require some adjustments of the file extlinux/extlinux.conf in the second partition (see the comments in the file) and writing the corresponding u-boot file from the "extra" subdir of the third partititon (/boot/extra) to the first partition
- deep suspend is a bit limited with a mainline kernel
  - see: https://irclog.whitequark.org/linux-rockchip/2018-04-03#21712549 - "for suspend/resume but at least between ChromeOS 3.14 and mainline there is a huge difference in handling of ddr self-refresh (not done in mainline at all, so you only get a light suspend)" - would need uboot or lower level support for more
  - it uses about 1.5-2% of the battery capacity per hour, so should keep the system alive for quite a while (more than a day) in suspend mode
- in the past (up to including debian bullseye and ubuntu focal) display gamma and color profile settings (night/red shift mode, display color calibration etc.) were not working at all on arm systems and it seems like starting with debian bookworm it is now working on systems with the proper support for it - luckily on this system it seems to be supported now
