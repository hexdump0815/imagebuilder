# daily driving experiments

in order to see how useable the velvet os images are and to find some hidden
problems appearing only after real world long time usage i started to pick a
system from time to time and try to use it as my daily driver for about a
week. usage usually is firefox with a few dozen tabs open (so not just a
single tab) and running all the time (i.e. not restarted fresh each day) and
lots of termial sessions. the system is usually only switched between running
and suspend (or for low power system without supsend support running all the
time) and never really rebooted as long as it is running stable. these notes
are my findings from those experiments for the different systems tried.

# general notes

- 2gb ram is only useable for 32bit systems or maybe 64bit systems with a
  32bit userland as 64bit systems usually need up to 50% more memory than
32bit systems
- zswap memory/swap compression helps with the limited memory giving around
  25% more (virtually) available memory with the current setup without any
major impact as long as there are enough or fast enough cpu cores around to
handle the compression without any major side effects. raising the zswap
percentage to higher values does not bring too much in real world situations
as the kernel starts to get more and more busy comrpessing and decrompressing
memory
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
  use compared to running from sd cards - if sd cards are used a1 rated ones
should be choosen as they have much better random io, which is often happening
in such a use case - regular (non a1 rated) sd cards are often very slow for
desktop usage to the point of being close to unuseable - most cheap usb
storage devices can be considered to behave similar to non a1 rated sd cards

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
- it was working reliable and quite ok (see below)
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
- it was working reliable and quite ok (see below)
- notes: due to the not that fast cpu (rk3328 at 4x1.3 ghz) it is not the
  fastest system, but it is still useable - running from emmc instead of sd
card helps to compensate a bit for that
- info: v5.19.1 kernel, debian bookworm, 4gb ram, 32gb emmc
