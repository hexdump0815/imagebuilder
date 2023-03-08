# chromebook x86 mbr

## bootable sd card images

- https://github.com/hexdump0815/imagebuilder/releases/tag/230222-03
- https://github.com/hexdump0815/imagebuilder/releases/tag/220912-01
- https://github.com/hexdump0815/imagebuilder/releases/tag/210724-04

## tested systems - working

- acer cb3 111 chromebook - gnawty

## untested systems

- in theory it should work for nearly all intel chromebooks with a working legacy rw firmware installed
- as there are no real chromebook dependency the chance is high that the images should simply work on most intel systems with mbr booting

## generic mainline linux on intel chromebook notes

- https://github.com/hexdump0815/linux-mainline-on-intel-chromebooks/blob/main/readme.md

## kernel build notes

- the regular debian/ubuntu distribution kernel is used in this case, so no kernel build required

## priority

- low: will be worked on and improved rarely, not that much left to be done

## special notes

- for using these images a legacy rw bios from https://mrchromebox.tech/ has to be installed first (if one is available at all)
- images with 64bit userland (native) are provided as well as images with 32bit userland, which might be better
for systems with only 2gb ram due to the lower ram consumption (about a third less for 32bit vs. 64bit)
