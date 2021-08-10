# chromebook x86 uefi

## bootable sd card images

- https://github.com/hexdump0815/imagebuilder/releases/tag/210724-04

## tested systems - working

- acer c200 chromebook - squawks
- dell 3189 chromebook - kefka
- teclast tpad x80 plus windows 10 / android tablet

## untested systems

- in theory it should work for nearly all intel chromebooks with a working uefi firmware installed
- as there are no real chromebook dependency the chance is high that the images should simply work on most intel systems with uefi booting with secure boot disabled

## generic mainline linux on intel chromebook notes

- https://github.com/hexdump0815/linux-mainline-on-intel-chromebooks/blob/main/readme.md

## kernel build notes

- the regular debian/ubuntu distribution kernel is used in this case, so no kernel build required

## special notes

- for using these images a uefi bios from https://mrchromebox.tech/ has to be installed first (if one is available at all)
- images with 64bit userland (native) are provided as well as images with 32bit userland, which might be better for systems with only 2gb ram due to the lower ram consumption (about a third less for 32bit vs. 64bit)
