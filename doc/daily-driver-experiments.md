# daily driving experiments

in order to see how useable the velvet os images are and to find some hidden
problems appearing only after real world long time usage i started to pick a
system from time to time and try to use it as my daily driver for about a
week. usage usually is firefox with a few dozen tabs open (so not just a
single tab) and running all the time (i.e. not restarted fresh each day) and
lots of termial sessions. the system is usually only switched between running
and suspend (or for low power system without supsend support running all the
time) and never really rebooted as long as it is running stable. when running
this way top with shift-h will show around 1500 threads, so actually quite a
few for such small systems. these notes are my findings from those experiments
for the different systems tried.

# general notes

- 2gb ram is only useable for 32bit systems or maybe 64bit systems with a
  32bit userland as 64bit systems usually need up to 50% more memory than
32bit systems (or the other way around: a 32bit userland only needs about
two thirds of the memory of a 64bit userland)
- if possible a 64bit userland is recommended over a 32bit one as nowadays the
  64 bit version receives more real world testing, but if there is not enough
memory 32bit is ok too - for arm more so than for intel as close to nobody is
still using 32bit intel anywhere, on arm there is still a lot of raspberry pi
stuff running on 32bit arm
- zswap memory/swap compression helps with the limited memory giving around
  25% more (virtually) available memory with the current setup without any
major impact as long as there are enough or fast enough cpu cores around to
handle the compression without any major side effects. raising the zswap
percentage to higher values does not bring too much in real world situations
as the kernel starts to get more and more busy comrpessing and decrompressing
memory. for systems with only 2gb of ram it might make sense to increase the
zswap percentage to 20% resulting in about one third of extra (virtually)
available memory. the zswap memory compression ratio seems to end up around
2.5-3 with the settings used for real world usage.
- the swap file should be of about the size of the ram size as a good starting
point - less might result in processes being killed from time to time due to
short bursts of high memory usage and more might result in a very slow system
due to a lot of swap io in the end. for systems with only 2gb of ram it might
be a good idea to provide about 150% of that as swap space (i.e. 3gb in that
case) as with zswap some swap space usage is counted twice: once for the
compressed memory (which is considered as used swap space by the system
although it is not written out to disk) and another time if a small fraction
of that really gets written to disk in the end (if more memory is required
than can be made available by compression) - see /scripts/zswap-status.sh to
see how much is really written to the swap file (usually much less than what
is shown in 'top' or 'free'.
- btrfs transparent filesystem compression helps quite well with the usually
  rather small storage sizes of chromebooks or other small devices by
providing around 50%-100% more (virtual) disk space depending on what files
are being stored - with this it is possible to run linux quite well even on
systems with 16gb of storage - even less is possible, 32gb is getting quite
comfortable and 64gb or more is plenty of disk space ...
- most of the images enable all the above mentioned features by default
- please keep in mind that this is just a look at daily usage keeping in mind
  that the systems are usually not the most powerful ones, so no wonders are
expected and especially there is no focus at all on gpu performance, gaming
usage, video hardware decoding etc. (i.e. for instance as long as it is
possible to somehow watch youtube videos at an somewhat acceptable resolution
it is considered to be ok, it does not matter if its 8k, 4k, full hd, hd or
even less)
- from my experience the overhead from running a luks encrypted root fs can
  be neglected on current systems, so it is nothing to worry about performance
wise
- running from emmc (or even ssd) as storage makes a big difference for daily
  use compared to running from sd cards - if sd cards are used, a1 rated ones
should be choosen as they have much better random io, which is often happening
in such a use case - regular (non a1 rated) sd cards are often very slow for
desktop usage to the point of being close to unuseable - most cheap usb
storage devices can be considered to behave similar to non a1 rated sd cards
and thus it is recommended to use high quality usb devices like sandisk ultra.

# chromebook oak - elm - august 2022

- tested for more than two weeks
- it was working surprisingly well and reliable
- notes: no gpu support and display power management is not working well (but
  worked around by the default settings)
- info: v5.19.1 kernel, debian bullseye, 4gb ram, 32gb emmc

# chromebook veyron - mighty - august 2022

- tested for about a week
- it was working surprisingly well and reliable
- notes:
  - panfrost driver had to be disabled as the system was getting unstable
  (kernel memory allocation issues) with it as soon as firefox was used heavily
  - besides that firefox had to be restarted after about 3 days due to too high
  memory usage most probably due to memory leaks in firefox
- info: v5.19.3 kernel, debian bookworm, 2gb ram, 16gb emmc

# chromebook kukui - krane - september 2022

- tested for about a week
- it was working surprisingly well and reliable
- notes: the display was very nice to work with when scaled down via xrandr
  scaling to 1280x800
- info: v5.18.10 kernel, debian bookworm, 4gb ram, 64gb emmc

# chromebook octopus - bloog - september 2022

- tested for about a week
- it was working surprisingly well and reliable
- notes: i started running from sd card which did not perform too well, but 
  since moving to emmc everything seemed to run perfectly fine
- info: v5.19.6 kernel, debian bookworm, 4gb ram, 64gb emmc

# chromebook snow - september 2022

- tested a few hours and then given up on it - it is getting too slow to be
  really useable for a longer time as soon as it gets used more heavily
- notes: it looks like having only 2gb ram (i.e. having to make quite a bit of
  use of memory/swap compression) and only two not too powerful cpu cores is
the limiting factor here
- info: v5.18.1 kernel, debian bookworm, 2gb ram, 16gb emmc

# amlogic gx - h96max x3 s905x3 tv box - september 2022

- tested for about a week
- it was working reliable and quite ok
- notes: after a while of use the system stalls for a moment from time to time
  and i initially suspected it to be panfrost related again as on rk3288, but
after disabling panfrost the stalls still aprreared from time to time and the
reason seems to be that i was running from an sd card instead of emmc and the
stalls seem to happen whenever data is being written to the swap file - so it
looks like even the better a1 rated sd cards are still far behind emmc even if
they are way better than regular sd cards - beside those stalls from time to
time the system was quite useable
- info: v5.19.1 kernel, debian bookworm, 4gb ram, 32gb a1 sd card

# rockchip rk3328 - t9 rk3328 tv box - september/october 2022

- tested for about a week
- it was working reliable and quite ok
- notes: due to the not that fast cpu (4xa53 at 1.3ghz) it is not the fastest
  system, but it is still useable - running from emmc instead of sd card helps
to compensate a bit for that
- info: v5.19.1 kernel, debian bookworm, 4gb ram, 32gb emmc

# amlogic gx - mi box s905x tv box - october 2022

- tested for a few days
- it was working reliable and quite ok, but somewhat slow
- notes: due to the not that fast cpu (4xa53 at 1.4ghz) it is not the
  fastest system - combining this with only 2gb ram does not really help and
using a 64bit kernel with a 32bit userland is the only option to be able to
really use it as a desktop system for a bit heavier use. putting the swap
onto some area of the emmc was helpful in combination with a high quality usb
stick for the root filesystem (the mi box does not have an sd card slot). with
all that the system was kind of useable in the end, but rather on the slower
end and some patience is required now and then.
- info: v6.0.0 kernel, debian bookworm (32bit userland), 2gb ram, 32gb sandisk
  ultra usb stick for the system and 5gb android data partiion area on emmc
for swap

# amlogic gx - a95xr2 s905w tv box - october 2022

- tested for a few days
- it was working reliable and quite ok, but quite slow
- notes: this was the try to go a bit lower even than for the last test with
  the amlogic s905x as the s905w is even slower (4xa53 at 1.2ghz), so all
from above is valid here and the system is even a bit slower. running from
emmc here instead of a usb stick on the s905x might help a bit here. to my
surprise the analog audio output of the box was actually working after doing
some minimal setting changes in alsamixer - i did not actualy expect this :)
- info: v6.0.0 kernel, debian bookworm (32bit userland), 2gb ram, 16gb emmc

# atom 32bit uefi - linx 1010b 2in1 - october 2022

- given up after a day
- it was working reliable and quite ok, but too slow
- notes: i expected it to be faster than the amlogic s905w (faster out of
  order intel cpu cores - 4xatom at up to 1.8 ghz vs. slower in order arm cpu
cores - 4xa53 at 1.2ghz), but it was at least as slow if not even slower than
that, most proably still quite useable for lighter load (just a few tabs in
firefox etc.) but not really in the tested scenario. again due to the only 2gb
of ram a 32bit userland was used to keep memory usage lower.
- info: v6.0.0 kernel, debian bookworm (32bit i686 userland), 2gb ram, 32gb
  emmc

# chromebook octopus - blooglet - october 2022

- tested for about two weeks
- it was working surprisingly well and reliable
- notes: it was a joy to use after testing all the lower spec systems over the
  last weeks - 4gb of ram and at least 4 cpu cores of useable speed are really
recommended for daily use if possible - with those specs using the system is
really comfortable compared to everything with lower specs
- info: v6.0.0 kernel, debian bookworm, 4gb ram, 64gb emmc, broken keyboard,
  so it was used with usb kbd and mouse

# chromebook kukui - kappa - october 2022

- tested for about a week
- it was working surprisingly well and reliable
- notes: it was as useable as the blooglet due to the 8 cpu cores and 4gb of
  ram - using the system is really comfortable ... only thing noticed: with
the usb hub (on the usb-a port) i usually use for mouse, keyboard an ethernet
the mouse simply did not work and always gave usb errors, with another usb hub
(on the usb-c port) everything was working fine
- info: v6.0.0 kernel, debian bookworm, 4gb ram, 32gb emmc

# odroid u3 - october 2022

- given up early on during initial tests
- it was not really working well as processes got oom killed after some
  heavier firefox useage
- notes: i always wanted to know if it is meanwhile possible to use the trusty
  old odroid u3 as a desktop system due to all the new clever features like
zswap, mglru etc. and it looks like it might be possible (albeit rather slow)
but as soon as firefox got used a bit heavier the kernel oom killed a lot of
processes and with them usually the whole org session, so not a good base for
using it as a desktop ... there were some locking errors in dmesg as well, so
some deeper investigation might be required to get this going
- info: v6.0.0 kernel, debian bookworm, 2gb ram, 32gb a1 sd card
