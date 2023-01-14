# chromebook x86 uefi

## bootable sd card images

- https://github.com/hexdump0815/imagebuilder/releases/tag/220906-01
- https://github.com/hexdump0815/imagebuilder/releases/tag/210724-04

## tested systems - working

- acer c200 chromebook - squawks
- dell 3189 chromebook - kefka
- hp chromebook 13 g1 - chell
  - see the extra notes in the doc subdir for such skylake chromebooks
- asus chromebook c423na - rabbid
  - see the extra notes in the doc subdir for such apl/glk chromebooks
- hp chromebook 12b - bloog
  - see the extra notes in the doc subdir for such apl/glk chromebooks
- hp chromebook 14a - blooglet
  - see the extra notes in the doc subdir for such apl/glk chromebooks
- teclast tpad x80 plus windows 10 / android tablet

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
