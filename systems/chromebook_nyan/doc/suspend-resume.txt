# problems around suspend and resume on nyan

## display not coming back properly after resume

- currently an ugly hack is in place to bring back the display properly and
  somewhat reliable after resume - for more details see
/lib/systemd/system-sleep/mrvl-and-edp-reload
- it seems to be somewhat more reliable with v5.18+, but sadly not completely reliable (see below)

## suspend and resume not working properly and/or reliable

- the lowest lp0 suspend mode does not seem to be supported by mainline and
  would require some extra firmware (see chromeos kernel - maybe for
inspiration)
- someone from archlinux arm got at least lp1 suspend mode working, but i was
  not able to reproduce this (i was unable to wake it up again after suspend)
(see:
https://archlinuxarm.org/forum/viewtopic.php?f=49&t=12185&sid=054215884699c2b79e457eadb8599012&start=230#p64180
for more details)
- see also:
  https://www.kernel.org/doc/Documentation/devicetree/bindings/arm/tegra/nvidia%2Ctegra20-pmc.txt
- see https://libera.irclog.whitequark.org/tegra/2021-12-22 for some
  experiments: lp2 and most probably lp1 seem to basically work, at least when
booted with init=/bin/bash suspend/resume worked fine via "rtcwake -m mem -s
15" with a deep mem suspend, fully booted (systemd) the system did a clean
shutdown immediately after resume
- v5.18/v5.19 update:
  - s2idle works, deep works (i.e. even the display gets restored properly
    now) with rtcwake and full new xorg, if run via suspend it does not seem
to get any wake events (maybe kbd is no longer working during suspend to get
the events?)
  - sadly after some more experimentation it looks like that even s2idle
    suspend is not working reliable - it most of the time comes back after the
first suspend, but trying to suspend multiple times usually ends in it failing
after a few times (i.e. not coming back) - tested with v5.18.1/v5.19.1/v5.19.2
  - i tried to rule out bt, wifi and sound by blacklisting or moving away
    their modules, but it did not change anything
  - i even had deep suspend once working to the point that it even came back
    after clicking on the trackpad, but i was not able to reproduce it again -
this at least shows that it should be possible to get it working - suspend
time in this example was a bit less than a minute
  - i did some battery usage measurements with s2idle resulting in about 4%
    battery usage per hour vs. only slightly less (3.5%+) with lp1 deep sleep
via rtcwake, so with s2idle we already nearly get what is possible with
mainline on this system - should still be enough to keep it alive when moving
from a to b or over night
  - i did another check to keep the system running idle with firefox with
    about 40 open tabs and display off and that used about 7% of the battery
(around 50wh) per hour, which means about 3.5w per hour which is not that bad
  - it looks like after returning from s2idle the system immediately shuts
    down (does so if on the console and call the logoff dialog in xorg), as a
result s2idle is not really useable currently for that reason as well (might
be a systemd thing maybe?)
  - hibernate fails to jump to system on resume and thus does still not work -
    hibernate options required to test: see doc/btrfs-and-hibernation-info.txt
