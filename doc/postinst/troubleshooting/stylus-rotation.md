# Stylus adjustment

some stylus input on some devices might be rotated

for wayland compositors and xorg DE's utilizing libinput the issue can be addressed in the way described below

1. running ```sudo lsinput```

output:
```bash
...         
 2: 27c6:0e51 I2C    4-0014           gt7375p 27C6:0E51 Stylus KEY ABS MSC     
 3: 27c6:0e51 I2C    4-0014           gt7375p 27C6:0E51 UNKNOW ABS             
 4: 27c6:0e51 I2C    4-0014           gt7375p 27C6:0E51 UNKNOW ABS             
...
```
we are looking for devices with stylus in the name (in case above it's 2)

_Note. if you can't find one, you can use ```evtest``` to go through the events each input device sends and find the one you want_

2. now let's create a special file at ```/etc/udev/rules.d/99-<name>-calibration.rules

_Note. the name can be anything but folowing above naming convention is recommended, (replace <name> with your device codename)_

the contents of this file it should be
```
ENV{DEVNAME}=="/dev/input/eventX",ENV{LIBINPUT_CALIBRATION_MATRIX}="0 -1 1 1 0 0"
```
_Note. if your device is plugged in via usb then the ```DEVNAME``` won't be static, you can use ```udevadm info /dev/input/eventX``` to check what else it can be identified with, some values might be iffy or apply to other not targeted devices_

_Note. replace X with the number of the device you found in the ```lsinput``` command_

_Note. the matrix above might not be the correct one, below are possible variants to try_
```bash
ENV{LIBINPUT_CALIBRATION_MATRIX}="1 0 0 0 1 0" # default
ENV{LIBINPUT_CALIBRATION_MATRIX}="0 -1 1 1 0 0" # 90 degree clockwise
ENV{LIBINPUT_CALIBRATION_MATRIX}="-1 0 1 0 -1 1" # 180 degree clockwise
ENV{LIBINPUT_CALIBRATION_MATRIX}="0 1 0 -1 0 1" # 270 degree clockwise
ENV{LIBINPUT_CALIBRATION_MATRIX}="-1 0 1 0 1 0" # reflect along y axis
```

after making the file run
```
sudo udevadm trigger /sys/class/input/eventX
```
_Note. replace X with the number of the device you found in the ```lsinput``` command_
to reload the device config

and 
```
udevadm info /dev/input/eventX
```
_Note. replace X with the number of the device you found in the ```lsinput``` command_
You should see your ```LIBINPUT_CALIBRATION_MATRIX``` listed there for the device

the changes usually take effect after a reboot
so reboot it and if it works you can let us know in the issues or create pr adding it to docs