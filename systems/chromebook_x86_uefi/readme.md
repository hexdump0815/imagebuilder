# chromebook x86 uefi

## bootable sd card images

- https://github.com/velvet-os/imagebuilder/releases/tag/231002-02
- https://github.com/velvet-os/imagebuilder/releases/tag/230222-04
- https://github.com/velvet-os/imagebuilder/releases/tag/220906-01
- https://github.com/velvet-os/imagebuilder/releases/tag/210724-04

## tested systems - working

- acer c200 chromebook - squawks
- dell 3189 chromebook - kefka
- lenovo chromebook 500e (1st generation) - robo360
- hp chromebook 13 g1 - chell
  - see the extra notes in the doc subdir for such skylake chromebooks
- asus chromebook c423na - rabbid
  - see the extra notes in the doc subdir for such apl/glk chromebooks
- hp chromebook 12b - bloog
  - see the extra notes in the doc subdir for such apl/glk chromebooks
- hp chromebook 14a - blooglet
  - see the extra notes in the doc subdir for such apl/glk chromebooks
- teclast tpad x80 plus windows 10 / android tablet
- lenovo thinkpad x240
- hp x2 elite 1012 g1
- edugear cmt chromebook
- asus chromebook c202s/c202sa - terra
- various thin clients: fujitsu futro s740 and s940, dell wyse 5070, hp t630

## untested systems

- in theory it should work for nearly all intel chromebooks with a working uefi firmware installed
- apollo and gemini lake chromebooks should work well with the rw uefi payload method described in the doc subdir which does not require the slighly risky flashing of the full firmware
- as there are no real chromebook dependency the chance is high that the images should simply work on most intel systems with uefi booting with secure boot disabled

## generic mainline linux on intel chromebook notes

- https://github.com/hexdump0815/linux-mainline-on-intel-chromebooks/blob/main/readme.md

## kernel build notes

- the regular debian/ubuntu distribution kernel is used in this case, so no kernel build required

## priority

- low: will be worked on and improved rarely, not that much left to be done

## special notes

- for using these images a uefi bios from https://mrchromebox.tech/ has to be installed first (if one is available at all)
- images with 64bit userland (native) are provided as well as images with 32bit userland, which might be better for systems with only 2gb ram due to the lower ram consumption (about a third less for 32bit vs. 64bit)
- to change the screen orientation to landscape mode by default for some intel atom tablets /etc/lightdm/lighdm.conf needs to be adjusted by uncommenting the corresponding shell script for supported devices
- on some intel baytrail, cherrytrail and braswell systems intel_idle.max_cstate=2 might be required as a kernel cmdline option in case of screen blanking or flickering issues
- on some intel baytrail, cherrytrail and braswell systems some option for the sound driver is required (see /etc/modprobe.d/sound-byt-cht-brw.conf) to avoid a beeping sound after a few minutes
- some things relevant for the hp chromebook 13 g1 / chell:
  - to avoid battery drain if the system is powered off it can be put into battery disconnect mode with some special keyboard and power-plug procedure as described here: https://github.com/hexdump0815/linux-mainline-on-arm-chromebooks#storing-chromebooks-and-avoiding-battery-drain - for chell it is important to use the usb-c port more towards the front of the device for this procedure as with the other one it does not seem to work (i.e. no proper battery disconnect mode in that case) - it looks like this does not seem to work reliable, as another time i was not able to put the device into battery disconnect mode on which it worked before and trying it different times again it then worked again (maybe the power button must be released first afterwards? maybe the usb-c plug orientation counts or even the power supply used and the voltages it offers? maybe waiting longer before unplugging and longer before releasing the buttons? maybe there is some very special timing needed for the procedure? - main takeaway is: it should work, but maybe not at the first try ...)
  - the keyboard backlight can be controlled via /sys/class/leds/chromeos\:\:kbd_backlight/brightness (values can go from 0-100)
- some things relevant for the hp x2 elite 1012 g1:
  - if this device is just powered off normally the battery will drain quickly (up to around 5-10% per day), to completely turn it off the power button has to be pressed for about 15-20 seconds directly after shutdown - this way there will be no battery drain any longer and to power on the device a longer press to the power button will be required
- some things relevant for edugear cmt chromebook:
  - touchscreen not working with main line debian bookworm kernel
  - touchscreen working with the kernel from project at https://github.com/hexdump0815/linux-mainline-x86-64-kernel/releases/tag/6.1.51-stb-odk%2B
  - this unit should be similar to the following units:
    - ctl j5 chromebook
    - haier chromebook 11 c
    - cultilaser chromebook m11c
    - pcmerge chromebook pcm-116t-432b
    - prowise chromebook proline
    - viglen chromebook 360
