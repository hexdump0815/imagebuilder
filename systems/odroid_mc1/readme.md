# odroid mc1, xu4, xu3, hc1, hc2

## bootable sd card images

- https://github.com/hexdump0815/imagebuilder/releases/tag/210508-01

## tested systems - working

- odroid mc1

## untested systems

- odroid xu4
- odroid xu3
- odroid hc1
- odroid hc2

## kernel build notes

- https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/blob/master/readme.e54
- https://github.com/hexdump0815/linux-mainline-and-mali-exynos5422-kernel/blob/master/readme.e54
  - older v5.4 kernel based on the odroid tree for the xu4

## u-boot build notes

- https://github.com/hexdump0815/u-boot-misc/blob/master/readme.e54

## special notes

- the mali gpu is only supported via the legacy mali blob as it is not yet supported by the open source panfrost mali driver
