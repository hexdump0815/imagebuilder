## In order to add chromebook doc

1. you need to add files inside /doc/{device type}/system/

{system codename}/{device codename}.md (base it on other device doc)

- {system codename}/assets/{device codename}.jpg (image of device) (optional)
should be no bigger than 200kb
no stock images, this might give copyright trouble
only self created images which will be free to be used in the doc repo

2. add entry to

/doc/{device type}/system/readme.md
and
/systemc/{system}/readme.md

3. fill up device info

readme.md

### you can also update existing doc

## Additional notes

```diff
- broken
+ works
! partial
? unknown
```

what should be tested :
_Note. if not present on the device should be ommited_

Basic
- Internal storage
  - (working) able to write to internal storage
  - (broken) unable to get working
- Battery
  - (working) able to read battery level
  - (broken) unable to get working
- Screen
  - (working) screen works correctly out of the box
  - (partial) builtin display causes issues
  - (broken) unable to get working

Peripheria
- Touchscreen or Stylus
  - (working) touchscreen works correctly out of the box
  - (partial) requires tinkering to get working
    - need orientation adjustments
  - (broken) unable to get working
- Keyboard
  - (working) keyboard works correctly out of the box
  - (broken) unable to get working
- Touchpad
  - (working) touchscreen works correctly out of the box
  - (partial) requires tinkering to get working
    - needs pressure sensitivity adjustments
  - (broken) unable to get working
- Camera
  - (working) builtin camera works
  - (broken) unable to get working
- Gyroscope
  - (working) gyroscope works
  - (broken) unable to get working

Audio
- Speaker
  - (working) buildin speaker works
    - random high pitch noise should be noted doesn't make for partial
  - (partial) the speaker/s don't fully work
    - only some speakers work
    - requires tinkering to get fully working
  - (broken) unable to get working
- Headphones
_Note. only for devices with jack, usb headphones don't count_
  - (working) plugging in headphones works
    - lack of jack detection doesn't make for partial
  - (partial) plugging in headphones causes some issues
    - only microphone works
  - (broken) unable to get working

Connectivity
- Wifi
  - (working) works with wifi standards device supports
  - (partial) works with some standards device supports or causes other issues
    - only working with 2.4Ghz
    - disconnecting randomly without any reasons
  - (broken) unable to get working
- Bluetooth
  - (working) works with bluetooth standards device supports
  - (partial) works with some standards device supports or causes other issues
    - Doesn't work with some peripheria devices
    - disconnects randomly without any reasons
  - (broken) unable to get working

Connectors
- USB or USB-C
  - (working) works with all/most usb devices
    - issue with niche devices (notably suzyq cable and dvd players) can/should be noted
  - (partial) doesn't work with some widely used devices (but not all)
    - like mouse, keyboard, usb drives, etc.
  - (broken) unable to get working
- HDMI or USB-C to HDMI/DP
  - (working) plugging in device works without majour issues
    - audio being mute is not majour issue but can be noted
  - (partial) device works only when plugged in under certain contitions
    - only when plugged in at boot
  - (broken) device does not work at all
- Ethernet
  - (working) works with ethernet devices
  - (broken) unable to get working
- SD Reader
  - (working) works with sd card devices that device supports
  - (broken) unable to get working

Other
- Hardware encoding or Hardware decoding
  - (working) works by default in web browser/media player
  - (partial) needs tinkering to get working
  - (broken) unable to get working
- 3D acceleration (which one opengl/vulkan/...)
  - (working) At least one has to be present, working (and be conformant)
    - OpenGL X.X
    - Vulkan X
    - Other
  - (partial) One is present but not comformant/often results in graphical glitches
  - (broken) Devices runs (or has to run) on frame buffer