# chromebook garalt

## bootable sd card images

- none yet

## tested systems - working

- lenovo chromebook duet 2024 - ciri

## untested systems

- no other geralt chromebooks available yet

## generic mainline linux on arm chromebook notes

- https://github.com/hexdump0815/linux-mainline-on-arm-chromebooks/blob/main/readme.md

## kernel build notes

- https://github.com/hexdump0815/linux-chromeos-kernel/blob/master/readme.grt
  - a chromeos based kernel is used until mainline gets useable on this device

## priority

- experimental mode

## special notes

- this is just some initial draft to support the bringup of this system
- this is still very much wip and not well tested, things might work or might not work
- as long as the chromeos kernel is used there is no gpu support
- sound is intentionally not working to avoid accidently breaking the audio hardware
- there is quite a bit of progress around mainline on this device and most things are already working - see: https://github.com/hexdump0815/linux-mainline-on-arm-chromebooks/issues/39 for more details - this will be taken care of once there is some more time ...
