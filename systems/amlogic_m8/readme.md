# amlogic meson8

## bootable sd card images

- https://github.com/hexdump0815/imagebuilder/releases/tag/200823-01

## tested systems - working

- mxq tv box (amlogic s805 based)

## untested systems

some more work will be required to make the devices below working

- amlogic s805 based tv boxes
- amlogic s802 based tv boxes
- amlogic s812 based tv boxes
- odroid c1
- odroid c1+

## kernel build notes

- https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/blob/master/readme.av7
- https://github.com/hexdump0815/linux-mainline-and-mali-amlogic-kernel/blob/master/readme.m8x

## special notes

- tv boxes are always hit and miss, so they might work or might not work and are usually of low quality
- the meson8 mainline support is still very experimental
- the hdmi output is not yet supported (so only serial console is possible for now)
