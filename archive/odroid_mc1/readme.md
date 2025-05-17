# odroid mc1, xu4, xu3, hc1, hc2

## bootable sd card images

- https://github.com/velvet-os/imagebuilder/releases/tag/210803-02
- https://github.com/velvet-os/imagebuilder/releases/tag/210508-01

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

## priority

- on hold: no further activities planned so far, no more access to hardware

## special notes

- this system stays on the linux v5.4 kernel from odroid for now as later mainline kernels have about 20% lower performance in some scenarios (but work fine otherwise)
- the mali gpu is only supported via the legacy mali blob as it is not yet supported by the open source panfrost mali driver
